import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationDataSource {
  Future<bool> requestPermission();
  Future<LatLng?> getCurrentLocation();
  Stream<LatLng> getLocationStream();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  @override
  Future<LatLng?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<LatLng> getLocationStream() {
    return Geolocator.getPositionStream().map(
      (Position position) => LatLng(position.latitude, position.longitude),
    );
  }
}
