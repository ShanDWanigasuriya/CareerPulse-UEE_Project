import 'package:flutter/material.dart';
import '../services/authservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  _login() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    Navigator.pushReplacementNamed(context, '/home');
    // var member = await _authService.login(username, password);

    // if (member != null) {
    //   // Navigate to home
    //   Navigator.pushReplacementNamed(context, '/home');
    // } else {
    //   Navigator.pushReplacementNamed(context, '/');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF001F54), // Navy blue color
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo at the top of the page
              Padding(
                padding: const EdgeInsets.only(
                    top: 90.0), // Adjust top padding if needed
                child: Center(
                  child: Image.asset(
                    'assets/Dev2.png', // Update with your logo path
                    height: 100, // Adjust height as needed
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
                                'Welcome!',
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
                              const SizedBox(height: 30),
                              // Login Button
                              ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  backgroundColor: Color(0xFF001F54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Register link
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text(
                                  'Don’t have an account? Register',
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
