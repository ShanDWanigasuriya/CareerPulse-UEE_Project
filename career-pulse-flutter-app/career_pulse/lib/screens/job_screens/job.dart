import 'package:flutter/material.dart';
import '../../models/job.dart'; // Assuming you have Job model in this path
import '../../services/job_service.dart'; // Assuming a service for fetching jobs
import  '../../screens/job_screens/view_job.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  // Track the selected label (0 for "All", 1 for "Full-Time", 2 for "Part-Time", etc.)
  int _selectedLabelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Opportunities'),
      ),
      body: Column(
        children: [
          // Row of clickable labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLabel('Full-Time', 1),
                _buildLabel('Part-Time', 2),
                _buildLabel('Freelance', 3),
              ],
            ),
          ),
          // Vertical list of jobs
          const Expanded(
            child: VerticalJobList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed, e.g. navigate to job creation screen
          Navigator.pushNamed(context, '/createJob');
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
        // Optionally, filter the list of jobs based on the selected label
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
}

class VerticalJobList extends StatefulWidget {
  const VerticalJobList({super.key});

  @override
  _VerticalJobListState createState() => _VerticalJobListState();
}

class _VerticalJobListState extends State<VerticalJobList> {
  late Future<List<Job>> futureJobs;

  @override
  void initState() {
    super.initState();
    futureJobs = JobService().getAllJobs(); // Fetch jobs on init
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: futureJobs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No jobs available'));
        }

        // Jobs loaded successfully
        final jobs = snapshot.data!;
        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return _buildJobCard(jobs[index]);
          },
        );
      },
    );
  }

  Widget _buildJobCard(Job job) {
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
            // Job title
            Text(
              job.jobTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Job type
            Text(
              'Job Type: ${job.jobTypeEnum}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // View button aligned to the right
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align the button to the right
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Navigate to a job details screen with the selected job details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewJob(jobId: job.jobId),
                        ),
                      );
                    } catch (error) {
                      // Handle error (e.g., show a message to the user)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${error.toString()}')),
                      );
                    }
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
