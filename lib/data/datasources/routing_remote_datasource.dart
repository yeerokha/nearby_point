import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nearby_point/core/constants/app_constants.dart';

abstract class RoutingRemoteDataSource {
  Future<List<LatLng>?> getRoute(LatLng origin, LatLng destination);
  Future<Map<String, dynamic>?> getRouteWithInfo(LatLng origin, LatLng destination);
}

class RoutingRemoteDataSourceImpl implements RoutingRemoteDataSource {
  @override
  Future<List<LatLng>?> getRoute(LatLng origin, LatLng destination) async {
    try {
      final url = Uri.parse(
        '${AppConstants.osrmBaseUrl}/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=polyline',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['code'] == 'Ok' && data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final encodedPolyline = route['geometry'] as String;

          final polylinePoints = PolylinePoints();
          final decoded = polylinePoints.decodePolyline(encodedPolyline);

          return decoded.map((point) => LatLng(point.latitude, point.longitude)).toList();
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error getting route: $e');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getRouteWithInfo(LatLng origin, LatLng destination) async {
    try {
      final url = Uri.parse(
        '${AppConstants.osrmBaseUrl}/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=polyline',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['code'] == 'Ok' && data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final encodedPolyline = route['geometry'] as String;
          final distance = route['distance'] as num;
          final duration = route['duration'] as num;

          final polylinePoints = PolylinePoints();
          final decoded = polylinePoints.decodePolyline(encodedPolyline);
          final points = decoded.map((point) => LatLng(point.latitude, point.longitude)).toList();

          return {
            'points': points,
            'distance': distance.toDouble(),
            'duration': duration.toDouble(),
          };
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error getting route with info: $e');
      return null;
    }
  }
}
