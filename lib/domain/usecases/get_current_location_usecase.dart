import 'package:latlong2/latlong.dart';
import 'package:nearby_point/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<LatLng?> call() async {
    final hasPermission = await repository.requestPermission();
    if (!hasPermission) return null;

    return await repository.getCurrentLocation();
  }
}
