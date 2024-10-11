import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(47, 128, 224, 1.0), // RGB(47, 128, 224)
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
              'assets/dev.png', // Image should be placed in the assets folder
              height: 200, // Adjust the size as needed
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
