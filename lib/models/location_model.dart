class LocationModel {
  final String id;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
