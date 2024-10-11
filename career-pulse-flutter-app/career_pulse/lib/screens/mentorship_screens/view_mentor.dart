import 'package:flutter/material.dart';
import '../../models/mentor.dart'; // Assuming you have the Mentorship model
import '../../services/mentor_service.dart'; // Assuming this has the service

class ViewMentorship extends StatelessWidget {
  final int mentorshipId;

  const ViewMentorship({super.key, required this.mentorshipId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentorship Details'),
      ),
      body: FutureBuilder<Mentorship>(
        future: MentorService().getMentorshipById(mentorshipId), // Fetch the mentorship details by ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No mentorship details available'));
          }

          final mentorship = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mentorship.mentorshipTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Mentor: ${mentorship.mentorName}'),
                const SizedBox(height: 8),
                Text('Description: ${mentorship.mentorshipDescription}'),
                const SizedBox(height: 8),
                Text('Experience: ${mentorship.mentorExperience}'),
                const SizedBox(height: 8),
                Text('Expertise: ${mentorship.mentorExpertise}'),
                const SizedBox(height: 16),
                // Optionally, display the document URL if available
                if (mentorship.mentorDocumentUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download Document'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 32), // Bottom padding
              ],
            ),
          );
        },
      ),
    );
  }
}
