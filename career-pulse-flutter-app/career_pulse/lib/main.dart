import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/register.dart';
import './screens/project_screens/project.dart';
import './screens/project_screens/create_project.dart';
import 'screens/login.dart';
import 'screens/mentorship_screens/create_mentorship.dart';
import 'screens/mentorship_screens/mentor.dart';
import 'widgets/loading_screen.dart';

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
        '/': (context) => LoadingScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/project': (context) => const ProjectScreen(),
        '/createProject': (context) => const CreateProjectScreen(),
        '/mentor': (context) => const MentorScreen(),
        '/createMentor': (context) => const CreateMentorScreen()
      },
    );
  }
}
