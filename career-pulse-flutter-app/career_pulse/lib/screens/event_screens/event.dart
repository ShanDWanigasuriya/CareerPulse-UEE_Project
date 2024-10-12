import 'package:flutter/material.dart';
import '../../models/event.dart'; // Assuming you have Event model in this path
import '../../services/event_service.dart'; // Assuming a service for fetching events
import '../event_screens/view_event.dart'; // Assuming a screen to view event details

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // Track the selected label (0 for "All", 1 for "Upcoming", 2 for "Past", etc.)
  int _selectedLabelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(
        children: [
          // Row of clickable labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLabel('All', 0),
                _buildLabel('Upcoming', 1),
                _buildLabel('Past', 2),
              ],
            ),
          ),
          // Vertical list of events
          const Expanded(
            child: VerticalEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed, e.g. navigate to event creation screen
          Navigator.pushNamed(context, '/createevent');
        },
        backgroundColor: const Color(0xFF001F54), // Navy blue color
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ), // Plus icon
      ),
    );
  }

  // Helper method to build clickable label
  Widget _buildLabel(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLabelIndex = index;
        });
        // Optionally, filter the list of events based on the selected label
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: _selectedLabelIndex == index
              ? FontWeight.bold
              : FontWeight.normal,
          color: _selectedLabelIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

class VerticalEventList extends StatefulWidget {
  const VerticalEventList({super.key});

  @override
  _VerticalEventListState createState() => _VerticalEventListState();
}

class _VerticalEventListState extends State<VerticalEventList> {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = EventService().getAllEvents(); // Fetch events on init
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No events available'));
        }

        // Events loaded successfully
        final events = snapshot.data!;
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return _buildEventCard(events[index]);
          },
        );
      },
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event title
            Text(
              event.eventTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Event description
            Text(
              event.eventDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            // Event date
            Text(
              'Start: ${event.startDate.toLocal()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // View button aligned to the right
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align the button to the right
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Navigate to an event details screen with the selected event details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventView(eventId: event.eventId),
                        ),
                      );
                    } catch (error) {
                      // Handle error (e.g., show a message to the user)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${error.toString()}')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
