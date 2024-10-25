// lib/screens/route_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps; // Prefixed import
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // Use this for polyline points
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RouteScreen extends StatefulWidget {
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late gmaps.GoogleMapController mapController; // Using the prefixed class
  Set<gmaps.Polyline> _polylines = {};
  final gmaps.LatLng _startLocation = gmaps.LatLng(37.7749, -122.4194); // San Francisco
  final gmaps.LatLng _endLocation = gmaps.LatLng(37.7849, -122.4094); // Another location in SF

  @override
  void initState() {
    super.initState();
    _getRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Screen')),
      body: gmaps.GoogleMap( // Using the prefixed class
        onMapCreated: _onMapCreated,
        initialCameraPosition: gmaps.CameraPosition( // Using the prefixed class
          target: _startLocation,
          zoom: 14.0,
        ),
        polylines: _polylines,
      ),
    );
  }

  void _onMapCreated(gmaps.GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getRoute() async {
    final googleApiKey = dotenv.env['GOOGLE_API_KEY']; // Load API key from .env file

    // Construct the URL for the Google Directions API
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_startLocation.latitude},${_startLocation.longitude}&destination=${_endLocation.latitude},${_endLocation.longitude}&key=$googleApiKey';

    // Make the HTTP request
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        // Create an instance of PolylinePoints
        final polylinePoints = PolylinePoints();

        // Extract polyline points from the response
        final points = data['routes'][0]['legs'][0]['steps'].map((step) {
          return polylinePoints.decodePolyline(step['polyline']['points']);
        }).expand((x) => x).toList();

        // Create a polyline from the points
        setState(() {
          _polylines.add(gmaps.Polyline(
            polylineId: gmaps.PolylineId('route'),
            color: Colors.blue,
            points: points,
            width: 4,
          ));
        });

        // Move the camera to the start location
        mapController.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(
            gmaps.LatLngBounds(
              southwest: gmaps.LatLng(
                _startLocation.latitude < _endLocation.latitude
                    ? _startLocation.latitude
                    : _endLocation.latitude,
                _startLocation.longitude < _endLocation.longitude
                    ? _startLocation.longitude
                    : _endLocation.longitude,
              ),
              northeast: gmaps.LatLng(
                _startLocation.latitude > _endLocation.latitude
                    ? _startLocation.latitude
                    : _endLocation.latitude,
                _startLocation.longitude > _endLocation.longitude
                    ? _startLocation.longitude
                    : _endLocation.longitude,
              ),
            ),
            100, // Padding
          ),
        );
      } else {
        // Handle errors, e.g., show a message to the user
        print('Error getting directions: ${data['error_message']}');
      }
    } else {
      // Handle HTTP request errors
      print('HTTP error: ${response.statusCode}');
    }
  }
}
