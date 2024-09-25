import os
from fastapi import Body, FastAPI, UploadFile, File, Form, HTTPException
from dotenv import load_dotenv
from pydantic import BaseModel
import pandas as pd
import google.generativeai as genai
from io import BytesIO
from PIL import Image

# Load environment variables
load_dotenv()
google_api_key = os.getenv("google_api_key")
# Configure Google Generative AI model
genai.configure(api_key=google_api_key)
model = genai.GenerativeModel('gemini-1.5-pro')

# Initialize the FastAPI app
app = FastAPI()


# Load doctor's data from Excel
try:
    doc_data = pd.read_excel("doc_data.xlsx")
except Exception as e:
    print(f"Error loading doctor data: {e}")
    raise

# Helper function to schedule an appointment
def schedule_appointment(doctor_name):
    try:
        doctor = doc_data[doc_data['Names'] == doctor_name]
        if not doctor.empty:
            if 'Appointments' not in doc_data.columns:
                doc_data['Appointments'] = 0
            doc_data.loc[doc_data['Names'] == doctor_name, 'Appointments'] += 1
            doc_data.to_excel("doc_data.xlsx", index=False)
            return f"Appointment scheduled with Dr. {doctor_name}."
        else:
            return f"Doctor {doctor_name} not found."
    except Exception as e:
        print(f"Error scheduling appointment: {e}")
        return "An error occurred while scheduling the appointment."

# Helper function to get a response from the AI model
def get_gemini_response(prompt, image=None):
    try:
        if image:
            response = model.generate_content([prompt, image])
        else:
            response = model.generate_content(prompt)
        if response:
            return response.text
        else:
            return "Unable to generate a response."
    except Exception as e:
        print(f"Error generating response from AI model: {e}")
        return "An error occurred while generating a response."


@app.get("/")
async def home():
    return {"message": "Welcome To Doc Talk"}

# API route to handle text and image input
@app.post("/chatbot/")
async def chatbot(prompt: str=Body() ,image: UploadFile = File(None)):
    try:
        img = None
        if image:
            image_bytes = await image.read()
            img = Image.open(BytesIO(image_bytes))
            img.save('upload.png') 

        response_text = get_gemini_response(prompt, img)

        # Find recommended doctors based on the response
        possible_specialties = doc_data['Speciality'].str.lower().tolist()
        recommended_doctors = []
        for specialty in possible_specialties:
            if specialty in response_text.lower():
                recommended_doctors.append(doc_data[doc_data['Speciality'].str.lower() == specialty])

        return {
            "bot_response": response_text,
            "recommended_doctors": recommended_doctors[:3]  # Limit to top 3 recommendations
        }
    except Exception as e:
        print(f"Error in chatbot endpoint: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")

# API route to schedule an appointment
@app.post("/schedule/")
async def schedule(doctor_name: str = Form(...)):
    try:
        appointment_message = schedule_appointment(doctor_name)
        return {"message": appointment_message}
    except Exception as e:
        print(f"Error in schedule endpoint: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")


