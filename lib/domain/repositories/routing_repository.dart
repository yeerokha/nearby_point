import 'package:latlong2/latlong.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';

abstract class RoutingRepository {
  Future<List<LatLng>?> getRoute(LatLng origin, LatLng destination);
  Future<RouteEntity?> getRouteWithInfo(LatLng origin, LatLng destination);
}
