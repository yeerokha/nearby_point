import 'package:latlong2/latlong.dart';

enum POICategory {
  restaurant,
  cafe,
  gasStation,
  shopping,
  carService,
  other,
}

class POIEntity {
  final int id;
  final String name;
  final double lat;
  final double lng;
  final POICategory category;
  final bool isFavorite;

  POIEntity({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.category,
    this.isFavorite = false,
  });

  LatLng get location => LatLng(lat, lng);

  POIEntity copyWith({
    int? id,
    String? name,
    double? lat,
    double? lng,
    POICategory? category,
    bool? isFavorite,
  }) {
    return POIEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
