import 'package:latlong2/latlong.dart';

abstract class LocationRepository {
  Future<bool> requestPermission();
  Future<LatLng?> getCurrentLocation();
  Stream<LatLng> getLocationStream();
}
