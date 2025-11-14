import 'package:latlong2/latlong.dart';

class RouteEntity {
  final List<LatLng> points;
  final double distanceMeters;
  final double durationSeconds;

  RouteEntity({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  String get distanceText {
    if (distanceMeters < 1000) {
      return '${distanceMeters.toStringAsFixed(0)} m';
    } else {
      return '${(distanceMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  String get durationText {
    final minutes = (durationSeconds / 60).round();
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      return '$hours h $remainingMinutes min';
    }
  }
}
