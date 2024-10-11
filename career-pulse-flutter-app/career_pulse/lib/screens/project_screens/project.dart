import 'package:career_pulse/screens/project_screens/view_project.dart';
import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../services/project_service.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // Track the selected label (0 for "All", 1 for "Ongoing", 2 for "Completed")
  int _selectedLabelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Opportunities'),
      ),
      body: Column(
        children: [
          // Row of clickable labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLabel('Ongoing', 1),
                _buildLabel('Completed', 2),
                _buildLabel('Upcoming', 3),
              ],
            ),
          ),
          // Vertical list of projects
          const Expanded(
            child: VerticalList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed, e.g. navigate to project creation screen
          Navigator.pushNamed(context, '/createProject');
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
        // Optionally, filter the list of projects based on the selected label
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

class VerticalList extends StatefulWidget {
  const VerticalList({super.key});

  @override
  _VerticalListState createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  late Future<List<Project>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects = ProjectService().getAllProjects(); // Fetch projects on init
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No projects available'));
        }

        // Projects loaded successfully
        final projects = snapshot.data!;
        return ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildPostCard(projects[index]);
          },
        );
      },
    );
  }

  Widget _buildPostCard(Project project) {
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
            // Project title
            Text(
              project.projectName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Project status
            Text(
              'Status: ${project.projectStatus}', // Map this to meaningful status names as needed
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Dates side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start Date: ${project.startDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // View button aligned to the right
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align the button to the right
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Navigate to ViewProject with the fetched project details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewProject(projectId: project.projectId),
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

