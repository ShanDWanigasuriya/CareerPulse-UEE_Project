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
  // Track the selected label (0 for "All", 1 for "Ongoing", 2 for "Completed")
  int _selectedLabelIndex = 0;

  late Future<List<Mentorship>> futureMentorships;

  @override
  void initState() {
    super.initState();
    futureMentorships = MentorService().getAllMentorships(); // Fetch mentorships on init
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
                _buildLabel('Ongoing', 1),
                _buildLabel('Completed', 2),
              ],
            ),
          ),
          // Vertical list of mentorships
          Expanded(
            child: FutureBuilder<List<Mentorship>>(
              future: futureMentorships,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No mentorships available'));
                }

                final mentorships = snapshot.data!;
                return ListView.builder(
                  itemCount: mentorships.length,
                  itemBuilder: (context, index) {
                    return _buildMentorshipCard(mentorships[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed, e.g. navigate to mentorship creation screen
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
        // Optionally, filter the list of mentorships based on the selected label
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

  Widget _buildMentorshipCard(Mentorship mentorship) {
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
            // Mentorship title
            Text(
              mentorship.mentorshipTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Mentor name
            Text(
              'Mentor: ${mentorship.mentorName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            // Mentor description
            Text(
              mentorship.mentorDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // View button aligned to the right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewMentorship(
                          mentorshipId: mentorship.mentorshipId!,
                        ),
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
          ],
        ),
      ),
    );
  }
}
