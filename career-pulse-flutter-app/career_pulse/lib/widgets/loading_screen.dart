import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF001F54), // RGB(47, 128, 224)
        body: Center(
          child: GestureDetector(
            onTap: () {
              // Navigate to the OnboardingScreen when the image is tapped
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen()),
              );
            },
            child: Image.asset(
              'assets/Dev2.png', // Image should be placed in the assets folder
              height: 100, // Adjust the size as needed
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
