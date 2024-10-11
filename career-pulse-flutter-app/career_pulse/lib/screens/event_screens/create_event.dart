import 'package:flutter/material.dart';
import 'dart:io'; // For file handling
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../models/event.dart'; // Adjust import based on your directory structure
import '../../services/event_service.dart'; // Import the event service

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _eventTitle = '';
  String _eventDescription = '';
  String _eventVenue = '';
  String _eventLink = '';
  DateTime? _startDate;
  DateTime? _endDate;
  File? _eventDocument;

  // Event service instance
  final EventService _eventService = EventService();

  // File picker for document selection
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _eventDocument = File(result.files.single.path!);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF001F54), // Navy blue for selection
              onPrimary: Colors.white, // Text color for selected items
              onSurface: Color(0xFF001F54), // Text color for unselected items
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color(0xFF001F54), // Navy blue for action buttons
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _clearDocument() {
    setState(() {
      _eventDocument = null; // Clear the selected document
    });
  }

  Future<void> _submitEvent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create an Event instance
      Event newEvent = Event(
        eventId: 0, // Assuming 0 for new event creation
        eventTitle: _eventTitle,
        eventDescription: _eventDescription,
        eventVenue: _eventVenue,
        eventLink: _eventLink,
        eventImageUrl: '', // Add logic for image URL if needed
        startDate: _startDate!,
        endDate: _endDate!,
      );

      // Call the service to create the event with the document file
      bool success = await _eventService.createEvent(newEvent, _eventDocument);

      if (success) {
        // Handle success (e.g., navigate back or show success message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully!')),
        );

        Navigator.pushReplacementNamed(
            context, '/event'); // Navigate to event listing
      } else {
        // Handle failure (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create event.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              // Event Title
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Title',
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
                  _eventTitle = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Event Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Description',
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
                  _eventDescription = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Event Venue
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Venue',
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
                  _eventVenue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event venue';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Event Link
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Link',
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
                  _eventLink = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Start Date
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Date',
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
                    icon: const Icon(Icons.calendar_today,
                        color: Color(0xFF001F54)), // Calendar icon
                    onPressed: () =>
                        _selectDate(context, true), // Open date picker on tap
                  ),
                ),
                controller: TextEditingController(
                  text: _startDate == null
                      ? ''
                      : DateFormat('yyyy-MM-dd').format(_startDate!),
                ),
              ),
              const SizedBox(height: 16),

              // End Date
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Date',
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
                    icon: const Icon(Icons.calendar_today,
                        color: Color(0xFF001F54)), // Calendar icon
                    onPressed: () =>
                        _selectDate(context, false), // Open date picker on tap
                  ),
                ),
                controller: TextEditingController(
                  text: _endDate == null
                      ? ''
                      : DateFormat('yyyy-MM-dd').format(_endDate!),
                ),
              ),
              const SizedBox(height: 16),

              // Document Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Event Document',
                    style: TextStyle(
                      color: Color(0xFF001F54),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDocument,
                    child: const Text('Pick Document'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF001F54), // White text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_eventDocument != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_eventDocument!.path
                        .split('/')
                        .last), // Display selected document name
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearDocument, // Clear document
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitEvent,
                child: const Text('Create Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F54), // Navy blue button
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
