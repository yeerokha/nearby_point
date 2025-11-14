import 'package:latlong2/latlong.dart';
import 'package:nearby_point/data/datasources/routing_remote_datasource.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';
import 'package:nearby_point/domain/repositories/routing_repository.dart';

class RoutingRepositoryImpl implements RoutingRepository {
  final RoutingRemoteDataSource remoteDataSource;

  RoutingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<LatLng>?> getRoute(LatLng origin, LatLng destination) async {
    return await remoteDataSource.getRoute(origin, destination);
  }

  @override
  Future<RouteEntity?> getRouteWithInfo(LatLng origin, LatLng destination) async {
    final result = await remoteDataSource.getRouteWithInfo(origin, destination);

    if (result == null) return null;

    return RouteEntity(
      points: result['points'] as List<LatLng>,
      distanceMeters: result['distance'] as double,
      durationSeconds: result['duration'] as double,
    );
  }
}
