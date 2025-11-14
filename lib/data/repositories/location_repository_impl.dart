import 'package:latlong2/latlong.dart';
import 'package:nearby_point/data/datasources/location_datasource.dart';
import 'package:nearby_point/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<bool> requestPermission() async {
    return await dataSource.requestPermission();
  }

  @override
  Future<LatLng?> getCurrentLocation() async {
    return await dataSource.getCurrentLocation();
  }

  @override
  Stream<LatLng> getLocationStream() {
    return dataSource.getLocationStream();
  }
}
