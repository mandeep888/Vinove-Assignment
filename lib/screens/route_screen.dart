// lib/screens/route_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_services_dart/google_maps_services_dart.dart'; // Adjusted if needed
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteScreen extends StatefulWidget {
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late GoogleMapController mapController;
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  final PolylinePoints polylinePoints = PolylinePoints();

  // Replace with your actual Google Maps API Key
  final String googleApiKey = "YOUR_GOOGLE_API_KEY"; // Store this securely

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Screen')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco coordinates
          zoom: 14.0,
        ),
        polylines: _polylines,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPolyline,
        child: Icon(Icons.directions),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getPolyline() async {
    // Start and end coordinates for the route
    LatLng startLocation = LatLng(37.7749, -122.4194); // San Francisco
    LatLng endLocation = LatLng(37.7849, -122.4094); // Another location in SF

    // Getting the route between the two locations
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear(); // Clear previous points
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 4,
        ));
      });

      // Move the camera to the start location
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              startLocation.latitude < endLocation.latitude
                  ? startLocation.latitude
                  : endLocation.latitude,
              startLocation.longitude < endLocation.longitude
                  ? startLocation.longitude
                  : endLocation.longitude,
            ),
            northeast: LatLng(
              startLocation.latitude > endLocation.latitude
                  ? startLocation.latitude
                  : endLocation.latitude,
              startLocation.longitude > endLocation.longitude
                  ? startLocation.longitude
                  : endLocation.longitude,
            ),
          ),
          100, // Padding
        ),
      );
    }
  }
}
