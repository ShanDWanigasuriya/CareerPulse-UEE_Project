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
      itemCount: 5, // Number of items
      itemBuilder: (context, index) {
        return _buildPostCard(index);
      },
    );
  }

  Widget _buildPostCard(int index) {
    // List of asset image paths
    final List<String> imagePaths = [
      'assets/project1.png',
      'assets/project2.png',
      'assets/project3.png',
      'assets/project4.png',
      'assets/project5.png',
    ];

    // Sample data for project details
    final List<String> projectNames = [
      'AI Research Initiative',
      'Clean Energy Project',
      'Urban Development Plan',
      'Educational Platform',
      'Healthcare Monitoring System',
    ];

    final List<String> cities = [
      'New York',
      'Los Angeles',
      'Chicago',
      'San Francisco',
      'Houston',
    ];

    final List<int> participants = [20, 35, 50, 25, 40];

    final List<String> datesPosted = [
      '2024-10-01',
      '2024-09-25',
      '2024-09-20',
      '2024-09-15',
      '2024-09-10',
    ];

    const String status = 'Ongoing'; // Example project status

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
                  child: Image.asset(
                    imagePaths[index], // Load image from assets
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
                        projectNames[index], // Project name from sample data
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Location: ${cities[index]}', // City from sample data
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Participants: ${participants[index]}', // Participants from sample data
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Date posted next to the image
                      Text(
                        datesPosted[index], // Date posted from sample data
                        style: const TextStyle(
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    status,
                    style: TextStyle(
                      fontSize: 15,
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
                      borderRadius: BorderRadius.circular(10), // Rounded button
                    ),
                    backgroundColor: const Color(0xFF001F54),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
