// lib/screens/attendance_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart'; // Import the Member class
import 'live_location_screen.dart'; // Import the LiveLocationScreen

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample member location
    LatLng memberLocation = LatLng(37.7749, -122.4194); // San Francisco Coordinates
    Member member = Member(name: "John Doe", location: memberLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LiveLocationScreen(member: member),
              ),
            );
          },
          child: Text('View Live Location'),
        ),
      ),
    );
  }
}
