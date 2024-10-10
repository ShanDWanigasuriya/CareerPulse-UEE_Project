import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/authservice.dart';
import '../models/member.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();

  File? _profileImage; // For storing the profile image
  int _selectedMemberType = 1; // Default to Collaborator

  final _authService = AuthService();
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Handle registration
  _register() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var fullName = _fullNameController.text;
    var email = _emailController.text;

    // Construct the Member object
    var member = Member(
      userName: username,
      password: password,
      memberType: _selectedMemberType, // Your dropdown value
      fullName: fullName,
      email: email,
      isActive: true, // Assuming new members are active upon registration
    );

    // Call register method in AuthService with a nullable profile image
    var success = await _authService.register(member, _profileImage); // _profileImage can be null

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Username
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Password
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Member Type Dropdown
            DropdownButtonFormField<int>(
              value: _selectedMemberType,
              decoration: const InputDecoration(
                labelText: 'Member Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 1, child: Text('Collaborator')),
                DropdownMenuItem(value: 2, child: Text('Mentor')),
                DropdownMenuItem(value: 3, child: Text('Job Seeker')),
                DropdownMenuItem(value: 4, child: Text('Community Member')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMemberType = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            // Full Name
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Profile Image Upload
            Row(
              children: [
                _profileImage != null
                    ? Image.file(
                        _profileImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Upload Profile Image'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Register Button
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
