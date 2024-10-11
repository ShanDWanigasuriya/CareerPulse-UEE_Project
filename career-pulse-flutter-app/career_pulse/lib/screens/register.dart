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
    var success = await _authService.register(member, _profileImage);

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color (Navy blue)
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF001F54),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Center(
                  child: Image.asset(
                    'assets/Dev2.png',
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 10,
                        color: Colors.white.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              // Welcome text
                              const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Username TextField
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.person),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Password TextField
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  filled: true,
                                  fillColor: Colors.white70,
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
                                  DropdownMenuItem(
                                      value: 1, child: Text('Collaborator')),
                                  DropdownMenuItem(
                                      value: 2, child: Text('Mentor')),
                                  DropdownMenuItem(
                                      value: 3, child: Text('Job Seeker')),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text('Community Member')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMemberType = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              // Full Name TextField
                              TextField(
                                controller: _fullNameController,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.person),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Email TextField
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Profile Image Upload
                              // Profile Image Upload
                              ListTile(
                                title: const Text("Upload Profile Image"),
                                subtitle: _profileImage != null
                                    ? Text('Image: ${_profileImage!.path}')
                                    : const Text('No Image selected'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _profileImage =
                                          null; // Clear the selected image
                                    });
                                  },
                                ),
                                onTap: _pickImage,
                              ),

                              const SizedBox(height: 30),
                              // Register Button
                              ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  backgroundColor: const Color(0xFF001F54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Already have an account? Login link
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text(
                                  'Already have an account? Login',
                                  style: TextStyle(
                                      color: Color(0xFF001F54), fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
