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
    futureMentorships =
        MentorService().getAllMentorships(); // Fetch mentorships on init
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
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mentorship title with a professional color and improved font
            Text(
              mentorship.mentorshipTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              mentorship.mentorshipDescription,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Mentor name with spacing and slight color change
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'By ${mentorship.mentorName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Mentor description with a more professional tone
            // Text(
            //   mentorship.mentorDescription,
            //   style: const TextStyle(
            //     fontSize: 14,
            //     color: Colors.black45,
            //     height: 1.5,
            //   ),
            // ),
            // const SizedBox(height: 12),

            // View button aligned to the right, with updated style
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF001F54),
                    elevation: 4,
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 16,
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
