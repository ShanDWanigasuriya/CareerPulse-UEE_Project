import 'package:flutter/material.dart';
import 'dart:io'; // For file handling
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../models/mentor.dart';
import '../../services/mentor_service.dart'; // For date formatting

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
  String _experience = '';
  String _expertise = '';
  File? _mentorDocument;

  // For managing multiple time slots
  List<Map<String, dynamic>> _timeSlots = [];

  // Project service instance
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

  // Add a new time slot
  void _addTimeSlot() {
    setState(() {
      _timeSlots.add({
        'date': null,
        'startTime': null,
        'endTime': null,
      });
    });
  }

  // Remove a specific time slot
  void _removeTimeSlot(int index) {
    setState(() {
      _timeSlots.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _timeSlots[index]['date'] = picked;
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, int index, String field) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeSlots[index][field] = picked;
      });
    }
  }

  Future<void> _submitMentor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a Project instance
      Mentorsip newMentorship = Mentorsip(
          mentorshipId: 1,
          mentorId: 0,
          collaboratorId: 1,
          mentorshipTitle: _mentorshipTitle,
          mentorshipDescription: _mentorshipDescription,
          mentorName: _mentorName,
          mentorDescription: _mentorDescription,
          experience: _experience,
          expertise: _expertise,
          isAvailable: true);

      // Call the service to create the project
      bool success =
          await _mentorService.createMentor(newMentorship, _mentorDocument);

      if (success) {
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mentor created successfully!')),
        );

        // Navigate back or reset form after success
        Navigator.pushReplacementNamed(context, '/mentors');
      } else {
        // Handle failure (e.g., show error message)
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

              // Mentor Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentorship Title',
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

              // Mentor Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mentorship Description',
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

              // Experience
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Experience (years)',
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
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _experience = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Expertise
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expertise',
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
                ),
                onSaved: (value) {
                  _expertise = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expertise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mentor Document (optional)
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Upload Mentor Image',
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
                    icon:
                        const Icon(Icons.upload_file, color: Color(0xFF001F54)),
                    onPressed: _pickDocument,
                  ),
                ),
                controller: TextEditingController(
                  text: _mentorDocument != null
                      ? _mentorDocument!.path.split('/').last
                      : 'Upload Image',
                ),
              ),
              if (_mentorDocument != null)
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
                          _mentorDocument!.path.split('/').last,
                          style: const TextStyle(
                            color: Color(0xFF001F54),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: _clearDocument,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),

              // Mentor Time Slots
              const Text(
                'Mentoring Time Slots',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001F54),
                ),
              ),
              const SizedBox(height: 16),

              Column(
                children: _timeSlots.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> slot = entry.value;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time Slot ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _removeTimeSlot(index),
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Date picker
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: slot['date'] == null
                                  ? 'Select Date'
                                  : DateFormat.yMMMd().format(slot['date']),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context, index),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Start time picker
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: slot['startTime'] == null
                                  ? 'Select Start Time'
                                  : slot['startTime'].format(context),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time),
                                onPressed: () =>
                                    _selectTime(context, index, 'startTime'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // End time picker
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: slot['endTime'] == null
                                  ? 'Select End Time'
                                  : slot['endTime'].format(context),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time),
                                onPressed: () =>
                                    _selectTime(context, index, 'endTime'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Add new slot button
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addTimeSlot,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F54), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Time Slot',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: _submitMentor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F54), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Mentor',
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
