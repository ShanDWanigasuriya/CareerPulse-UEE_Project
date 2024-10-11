import 'package:flutter/material.dart';
import 'horizontal_slider.dart'; // Import the HorizontalSlider widget
import 'mentor_slider.dart';
import 'vertical_list.dart'; // Import the VerticalList widget
import 'banner.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: BannerToExplore(),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Featured Events',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          HorizontalSlider(), // Use HorizontalSlider component
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available Projects',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          VerticalList(), // Use VerticalList component
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Top Mentors',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          MentorHorizontalSlider(),
        ],
      ),
    );
  }
}
