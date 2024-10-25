import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location History'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('startLocation'),
                  position: LatLng(37.7749, -122.4194),
                  infoWindow: InfoWindow(
                    title: 'Start Location',
                    snippet: '8:30 AM',
                  ),
                ),
                Marker(
                  markerId: MarkerId('endLocation'),
                  position: LatLng(37.8044, -122.2711),
                  infoWindow: InfoWindow(
                    title: 'End Location',
                    snippet: '4:30 PM',
                  ),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: [
                    LatLng(37.7749, -122.4194),
                    LatLng(37.8044, -122.2711),
                  ],
                  color: Colors.blue,
                  width: 5,
                ),
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of locations
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Location $index'),
                  subtitle: Text('Visited at 09:00 AM'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
