import 'package:flutter/material.dart';

// Vertical List Widget
class VerticalList extends StatelessWidget {
  const VerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), // Disable internal scrolling
      shrinkWrap: true, // Adjust size to fit contents
      itemCount: 10, // Number of items
      itemBuilder: (context, index) {
        return _buildPostCard(index);
      },
    );
  }

  Widget _buildPostCard(int index) {
    // Sample data
    const String imageUrl =
        'https://via.placeholder.com/150'; // Placeholder image URL
    const String status = 'Ongoing'; // Example project status
    const String datePosted = '2024-10-10'; // Example date posted

    return Card(
      elevation: 4, // Shadow effect for the card
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row: Image and details (including date)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 100, // Fixed width for the image
                    height: 100, // Fixed height for the image
                  ),
                ),
                const SizedBox(width: 16), // Spacing between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project ${index + 1}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Location: City ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Participants: ${index * 10 + 5}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Date posted next to the image
                      const Text(
                        datePosted,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Space between rows
            // Second row: Project status and View button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Project status label
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    status,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // View button
                ElevatedButton(
                  onPressed: () {
                    // Define what happens when the button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                  ),
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
