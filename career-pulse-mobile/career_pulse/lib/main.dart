import 'package:flutter/material.dart';
import './screens/login.dart';
import './screens/home.dart';
import './screens/register.dart';
import './screens/project_screens/project.dart';
import './screens/project_screens/create_project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/project': (context) => const ProjectScreen(),
        '/createProject': (context) => const CreateProjectScreen()
      },
    );
  }
}
