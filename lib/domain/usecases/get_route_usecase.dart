import 'package:latlong2/latlong.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';
import 'package:nearby_point/domain/repositories/routing_repository.dart';

class GetRouteUseCase {
  final RoutingRepository repository;

  GetRouteUseCase(this.repository);

  Future<RouteEntity?> call(LatLng origin, LatLng destination) async {
    return await repository.getRouteWithInfo(origin, destination);
  }
}
