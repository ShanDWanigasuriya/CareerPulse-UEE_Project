import 'package:flutter/material.dart';
import 'dart:io'; // For file handling
import 'package:file_picker/file_picker.dart';
import '../../models/mentor.dart';
import '../../services/mentor_service.dart';

class CreateMentorScreen extends StatefulWidget {
  const CreateMentorScreen({super.key});

  @override
  _CreateMentorScreenState createState() => _CreateMentorScreenState();
}

class _CreateMentorScreenState extends State<CreateMentorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _mentorshipTitle = '';
  String _mentorshipDescription = '';
  String _mentorName = '';
  String _mentorDescription = '';
  String _mentorExperience = '';
  String _mentorExpertise = '';
  File? _mentorDocument;

  // Mentor service instance
  final MentorService _mentorService = MentorService();

  // File picker for document selection
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _mentorDocument = File(result.files.single.path!);
      });
    }
  }

  void _clearDocument() {
    setState(() {
      _mentorDocument = null; // Clear the selected document
    });
  }

  Future<void> _submitMentor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a Mentorship instance
      Mentorship newMentorship = Mentorship(
        mentorshipId: 0,
        mentorshipTitle: _mentorshipTitle,
        mentorshipDescription: _mentorshipDescription,
        mentorName: _mentorName,
        mentorDescription: _mentorDescription,
        mentorExperience: _mentorExperience,
        mentorExpertise: _mentorExpertise,
        mentorDocument:
            _mentorDocument, // This will store the file in the model if needed
      );

      // Call the service to create the mentor, pass both the Mentorship and the document
      bool success =
          await _mentorService.createMentor(newMentorship, _mentorDocument);

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mentor created successfully!')),
        );

        // Navigate back or reset form after success
        Navigator.pushReplacementNamed(context, '/mentor');
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create mentor.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mentor + Mentorship Slots'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),

              // Mentorship Title
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentorship Title',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                onSaved: (value) {
                  _mentorshipTitle = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentorship title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentorship Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentorship Description',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                maxLines: 4,
                onSaved: (value) {
                  _mentorshipDescription = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentorship description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentor Name',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                onSaved: (value) {
                  _mentorName = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentor name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentor Description',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                maxLines: 4,
                onSaved: (value) {
                  _mentorDescription = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentor description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Experience
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentor Experience',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                onSaved: (value) {
                  _mentorExperience = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentor experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Expertise
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentor Expertise',
                  labelStyle: const TextStyle(color: Color(0xFF001F54)),
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
                ),
                onSaved: (value) {
                  _mentorExpertise = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mentor expertise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Document upload
              ListTile(
                title: const Text("Upload Mentor Document"),
                subtitle: _mentorDocument != null
                    ? Text('Document: ${_mentorDocument!.path}')
                    : const Text('No document selected'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _clearDocument,
                ),
                onTap: _pickDocument,
              ),
              const SizedBox(height: 16),

              // Submit button
              ElevatedButton(
                onPressed: _submitMentor,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
