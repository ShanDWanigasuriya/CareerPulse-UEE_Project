import 'package:flutter/material.dart';

// Sample data for horizontal cards
const List<String> projectStatuses = ['Ongoing', 'Completed', 'Upcoming'];

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    const String profileImageUrl =
        'https://via.placeholder.com/150'; // Placeholder image URL
    const String fullName = 'John Doe';
    const String email = 'johndoe@example.com';
    const String memberType = 'Mentor'; // Example member type

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // Enable vertical scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  SizedBox(height: 16),
                  Text(
                    fullName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    memberType,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF001F54),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle edit profile action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit Profile tapped')),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF001F54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle settings action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings tapped')),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF001F54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login screen
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF001F54),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Horizontal Scrollable Cards
              // SizedBox(
              //   height: 150, // Fixed height for the horizontal list
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: projectStatuses.length,
              //     itemBuilder: (context, index) {
              //       return _buildHorizontalCard(context, index);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHorizontalCard(BuildContext context, int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Handle card tap event
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Tapped on ${projectStatuses[index]}')),
  //       );
  //     },
  //     child: Card(
  //       elevation: 4, // Shadow effect for the card
  //       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: SizedBox(
  //         width: 200, // Increased width for the card
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Colors.blue[900], // Navy blue background
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Center(
  //             child: Text(
  //               projectStatuses[index],
  //               style: const TextStyle(
  //                 color: Colors.white, // White text color
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
