import 'package:flutter/material.dart';
import 'dart:io'; // For file handling
import 'package:file_picker/file_picker.dart';
import '../../models/job.dart'; // Import the Job model
import '../../services/job_service.dart'; // Import the Job service

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _jobTitle = '';
  String _jobDescription = '';
  String? _selectedJobType;
  File? _jobDocument;

  // Job type options
  final List<String> _jobTypeOptions = [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance'
  ];

  // Job service instance
  final JobService _jobService = JobService();

  // File picker for document selection
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _jobDocument = File(result.files.single.path!);
      });
    }
  }

  void _clearDocument() {
    setState(() {
      _jobDocument = null; // Clear the selected document
    });
  }

  Future<void> _submitJob() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a Job instance
      Job newJob = Job(
        jobId: 0, // Assuming 0 for new job creation
        jobTitle: _jobTitle,
        jobDescription: _jobDescription,
        jobTypeEnum: _selectedJobType!,
        document: _jobDocument,
      );

      // Call the service to create the job
      bool success = await _jobService.createJob(newJob, _jobDocument);

      if (success) {
        // Handle success (e.g., navigate back or show success message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job created successfully!')),
        );

        Navigator.pushReplacementNamed(context, '/job');
      } else {
        // Handle failure (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create job.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              
              // Job Title
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Job Title',
                  labelStyle: const TextStyle(
                    color: Color(0xFF001F54), // Navy blue text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Light grey background
                ),
                onSaved: (value) {
                  _jobTitle = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Job Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Job Description',
                  labelStyle: const TextStyle(
                    color: Color(0xFF001F54), // Navy blue text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Light grey background
                ),
                maxLines: 4,
                onSaved: (value) {
                  _jobDescription = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Job Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Job Type',
                  labelStyle: const TextStyle(
                    color: Color(0xFF001F54), // Navy blue text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Light grey background
                ),
                value: _selectedJobType,
                items: _jobTypeOptions.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedJobType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a job type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Job Document
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Job Document',
                  labelStyle: const TextStyle(
                    color: Color(0xFF001F54),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF001F54)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.upload_file,
                        color: Color(0xFF001F54)), // Upload icon
                    onPressed: _pickDocument,
                  ),
                ),
                controller: TextEditingController(
                  text: _jobDocument != null
                      ? _jobDocument!.path.split('/').last
                      : 'Upload Job Document',
                ),
                validator: (value) {
                  if (_jobDocument == null) {
                    return 'Please upload a job document';
                  }
                  return null;
                },
              ),
              if (_jobDocument !=
                  null) // Row to show file name and clear button
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _jobDocument!.path.split('/').last,
                          style: const TextStyle(
                            color: Color(0xFF001F54),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear, color: Colors.red),
                        onPressed: _clearDocument,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F54), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
