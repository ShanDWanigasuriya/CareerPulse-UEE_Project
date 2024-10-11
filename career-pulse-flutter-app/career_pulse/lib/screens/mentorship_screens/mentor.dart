import 'package:flutter/material.dart';
import '../../models/mentor.dart';
import '../../services/mentor_service.dart';
import 'view_mentor.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  _MentorScreenState createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  // Track the selected label (0 for "All", 1 for "Available", 2 for "Unavailable")
  int _selectedLabelIndex = 0;
  late Future<List<Mentorsip>> futureMentors;

  @override
  void initState() {
    super.initState();
    futureMentors = MentorService().getAllMentors(); // Fetch mentors on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentorship Opportunities'),
      ),
      body: Column(
        children: [
          // Row of clickable labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLabel('All', 0),
                _buildLabel('Available', 1),
                _buildLabel('Unavailable', 2),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Mentorsip>>(
              future: futureMentors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No mentors available'));
                }

                // Mentors loaded successfully
                final mentors = snapshot.data!;
                return ListView.builder(
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    return _buildMentorCard(mentors[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to mentor creation screen
          Navigator.pushNamed(context, '/createMentor');
        },
        backgroundColor: const Color(0xFF001F54), // Navy blue color
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ), // Plus icon
      ),
    );
  }

  // Helper method to build clickable label
  Widget _buildLabel(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLabelIndex = index;
        });
        // Optionally, filter the list of mentors based on the selected label
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: _selectedLabelIndex == index
              ? FontWeight.bold
              : FontWeight.normal,
          color: _selectedLabelIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildMentorCard(Mentorsip mentor) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mentor.mentorName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mentor.mentorDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Expertise: ${mentor.expertise}', // Expertise field
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Availability: ${mentor.isAvailable ? 'Available' : 'Unavailable'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to ViewMentor with the fetched mentor details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewMentor(mentorId: mentor.mentorId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
