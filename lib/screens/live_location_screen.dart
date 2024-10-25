// lib/screens/live_location_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart'; // Import the Member class

class LiveLocationScreen extends StatefulWidget {
  final Member member;

  LiveLocationScreen({required this.member});

  @override
  _LiveLocationScreenState createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Location')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.member.location, // Use member's location
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('current_location'),
                  position: widget.member.location, // Use member's location
                ),
              },
            ),
          ),
          // Timeline view of visited locations
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Location 1'),
                  subtitle: Text('08:30 AM'),
                ),
                ListTile(
                  title: Text('Location 2'),
                  subtitle: Text('10:15 AM'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
