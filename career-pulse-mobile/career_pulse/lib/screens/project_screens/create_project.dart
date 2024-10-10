import 'package:flutter/material.dart';
import 'dart:io'; // For file handling
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../models/project.dart';
import '../../services/project_service.dart'; // Import the service

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _projectName = '';
  String _projectDescription = '';
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;
  File? _projectDocument;

  // Project status options
  final List<String> _projectStatusOptions = [
    'Ongoing',
    'Completed',
    'Upcoming'
  ];

  // Project service instance
  final ProjectService _projectService = ProjectService();

  // File picker for document selection
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _projectDocument = File(result.files.single.path!);
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
      _projectDocument = null; // Clear the selected document
    });
  }

  Future<void> _submitProject() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a Project instance
      Project newProject = Project(
        projectId: 0, // Assuming 0 for new project creation
        collaboratorId: 1, // Replace with the actual collaboratorId
        projectName: _projectName,
        projectDescription: _projectDescription,
        projectStatus: _projectStatusOptions.indexOf(_selectedStatus!) + 1,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      // Call the service to create the project
      bool success =
          await _projectService.createProject(newProject, _projectDocument);

      if (success) {
        // Handle success (e.g., navigate back or show success message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project created successfully!')),
        );

        Navigator.pushReplacementNamed(context, '/project');
      } else {
        // Handle failure (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create project.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              // Project Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Project Name',
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
                  _projectName = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Project Description',
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
                  _projectDescription = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project Status Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Project Status',
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
                value: _selectedStatus,
                items: _projectStatusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a project status';
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
                        _selectDate(context, false), // Open date picker on tap
                  ),
                ),
                onTap: () => _selectDate(context, true),
                controller: TextEditingController(
                  text: _startDate == null
                      ? ''
                      : DateFormat.yMd().format(_startDate!),
                ),
                validator: (value) {
                  if (_startDate == null) {
                    return 'Please select a start date';
                  }
                  return null;
                },
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
                        color: Color(0xFF001F54)),
                    onPressed: () => _selectDate(context, true),
                  ),
                ),
                onTap: () => _selectDate(context, false),
                controller: TextEditingController(
                  text: _endDate == null
                      ? ''
                      : DateFormat.yMd().format(_endDate!),
                ),
                validator: (value) {
                  if (_endDate == null) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Project Document
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Project Document',
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
                  text: _projectDocument != null
                      ? _projectDocument!.path.split('/').last
                      : 'Upload Project Document',
                ),
                validator: (value) {
                  if (_projectDocument == null) {
                    return 'Please upload a project document';
                  }
                  return null;
                },
              ),
              if (_projectDocument !=
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
                          _projectDocument!.path.split('/').last,
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
                onPressed: _submitProject,
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
