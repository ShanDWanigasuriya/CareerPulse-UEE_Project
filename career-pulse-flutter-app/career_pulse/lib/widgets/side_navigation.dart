// custom_drawer.dart
import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF001F54), // Navy blue header background
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu, // Icon in the header
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Project Opportunities
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
          // Mentorships
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
              Navigator.pushNamed(context, '/mentorships');
            },
          ),
          // Jobs
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
              Navigator.pushNamed(context, '/jobs');
            },
          ),
          // Events
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
              Navigator.pushNamed(context, '/events');
            },
          ),
        ],
      ),
    );
  }
}
