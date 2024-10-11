import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/event.dart'; // Replace with your Event model path
import '../../services/event_service.dart'; // Replace with your EventService path
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class EventView extends StatefulWidget {
  final int eventId;

  const EventView({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  late Future<Event> futureEvent;

  @override
  void initState() {
    super.initState();
    futureEvent = EventService().getEventById(widget.eventId); // Fetch the event details by ID
  }

  Future<void> downloadFile(String url, String filename) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/$filename';

      Dio dio = Dio();
      await dio.download(url, savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to $savePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Event>(
        future: futureEvent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No event found'));
          }

          final event = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section with Title and Background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF001F54),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventTitle,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Event Venue label
                      Text(
                        event.eventVenue,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Description Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventDescription,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Start Date: ${event.startDate.toLocal()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'End Date: ${event.endDate.toLocal()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Document Download Button
                if (event.eventDocument != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          downloadFile(
                            'https://example.com${event.eventDocument!.path}', // Replace with the correct base URL
                            event.eventDocument!.path.split('/').last,
                          );
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download Document'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 32), // Bottom padding
              ],
            ),
          );
        },
      ),
    );
  }
}
