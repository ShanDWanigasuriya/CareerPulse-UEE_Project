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
        future: MentorService().getMentorshipById(
            mentorshipId), // Fetch the mentorship details by ID
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF001F54),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          mentorship.mentorshipTitle,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(221, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  mentorship.mentorshipDescription,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    //fontStyle: FontStyle.italic,
                    color: Color.fromARGB(221, 37, 1, 1),
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child: Text(
                    'Mentor Details',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(221, 37, 1, 1),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centers horizontally
                  children: [
                    Text(
                      mentorship.mentorName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(221, 37, 1, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Experience',
                        style: const TextStyle(
                          fontSize: 19,
                          //fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF001F54),
                        ),
                      ),
                    ),
                    Text(
                      mentorship.mentorExperience,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(221, 37, 1, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Expertise',
                        style: const TextStyle(
                          //fontStyle: FontStyle.italic,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF001F54),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        mentorship.mentorExpertise,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(221, 37, 1, 1),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // // Optionally, display the document URL if available
                // if (mentorship.mentorDocumentUrl != null)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     child: Center(
                //       child: ElevatedButton.icon(
                //         onPressed: () {},
                //         icon: const Icon(Icons.download),
                //         label: const Text('Download Document'),
                //         style: ElevatedButton.styleFrom(
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 12, horizontal: 24),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),

                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // This centers the button horizontally
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Show SnackBar for success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Session booked successfully!'),
                            backgroundColor:
                                Colors.green, // Optional: to style the SnackBar
                          ),
                        );

                        // Navigate or handle booking logic after showing the message
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BookSessionScreen(
                        //       mentorshipId: mentorship.mentorshipId!,
                        //     ),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color(0xFF001F54), // Same color theme
                        elevation: 4,
                      ),
                      child: const Text(
                        'Book Session',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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
