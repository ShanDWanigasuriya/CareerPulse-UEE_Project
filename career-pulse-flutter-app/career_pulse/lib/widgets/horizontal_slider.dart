import 'package:flutter/material.dart';

// Horizontal Slider Widget
class HorizontalSlider extends StatelessWidget {
  const HorizontalSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(5, (index) => _buildSliderItem(index)),
      ),
    );
  }

  // Private method to build each slider item
  Widget _buildSliderItem(int index) {
    return Container(
      width: 250, // Adjust width as needed
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Color(0xFF001F54),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Event ${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
