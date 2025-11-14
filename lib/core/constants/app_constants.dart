import 'package:latlong2/latlong.dart';

class AppConstants {
  // Map Configuration
  static const LatLng defaultLocation = LatLng(43.2401, 76.8897); // Almaty
  static const double defaultZoom = 15.0;
  static const double minZoom = 5.0;
  static const double maxZoom = 18.0;
  static const double maxTileZoom = 19.0;

  // Map Tile URLs
  static const String osmTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgent = 'com.example.nearby_point';

  // OSRM Configuration
  static const String osrmBaseUrl = 'https://router.project-osrm.org';

  // UI Constants
  static const double markerSize = 40.0;
  static const double currentLocationMarkerSize = 20.0;
  static const double routeStrokeWidth = 4.0;
  static const double fallbackRouteStrokeWidth = 3.0;
  static const double cameraPadding = 80.0;

  // Animation
  static const Duration animationDuration = Duration(milliseconds: 300);
}
