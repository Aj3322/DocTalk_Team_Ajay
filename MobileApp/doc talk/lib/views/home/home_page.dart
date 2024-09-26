import 'package:flutter/material.dart';
import 'widgets/chatbot_card.dart';
import 'widgets/doctor_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DocTalk Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Welcome to DocTalk!',
                style: Theme.of(context).textTheme.headline1, // Adapts to light/dark mode
              ),
              SizedBox(height: 24.0),
              // Chatbot Card
              ChatbotCard(),
              SizedBox(height: 16.0),
              // Doctor Card
              DoctorCard(),
            ],
          ),
        ),
      ),
    );
  }
}
