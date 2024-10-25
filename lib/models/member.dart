// lib/models/member.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Member {
  final String name;
  final LatLng location; // Member's location

  Member({required this.name, required this.location});
}
