import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF001F54), // Navy blue header background
            ),
            child: Center(
              child: Image.asset(
                'assets/Dev2.png', // Replace with the path to your logo
                height: 80, // Adjust the size of the logo as needed
                fit: BoxFit.contain, // Make sure the logo fits well
              ),
            ),
          ),
          
          // Home List Item
          ListTile(
            leading: const Icon(Icons.home_outlined,
                color: Color(0xFF001F54)), // Icon for list item
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF001F54), // Navy blue text
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),

          // Project Opportunities List Item
          ListTile(
            leading: const Icon(Icons.work_outline,
                color: Color(0xFF001F54)), // Icon for list item
            title: const Text(
              'Project Opportunities',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF001F54), // Navy blue text
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/project');
            },
          ),

          // Mentorships List Item
          ListTile(
            leading: const Icon(Icons.school_outlined,
                color: Color(0xFF001F54)), // Icon for list item
            title: const Text(
              'Mentorships',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF001F54),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/mentor');
            },
          ),

          // Jobs List Item
          ListTile(
            leading: const Icon(Icons.business_center_outlined,
                color: Color(0xFF001F54)), // Icon for list item
            title: const Text(
              'Jobs',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF001F54),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/job');
            },
          ),
          // Events List Item
          ListTile(
            leading: const Icon(Icons.event_available_outlined,
                color: Color(0xFF001F54)), // Icon for list item
            title: const Text(
              'Events',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF001F54),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/event');
            },
          ),
        ],
      ),
    );
  }
}
