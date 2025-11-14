import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearby_point/core/constants/app_constants.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng currentLocation;
  final List<POIEntity> pois;
  final POIEntity? selectedPOI;
  final RouteEntity? routeInfo;
  final Function(POIEntity) onPOITap;

  const MapWidget({
    super.key,
    required this.mapController,
    required this.currentLocation,
    required this.pois,
    this.selectedPOI,
    this.routeInfo,
    required this.onPOITap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: currentLocation,
        initialZoom: AppConstants.defaultZoom,
        minZoom: AppConstants.minZoom,
        maxZoom: AppConstants.maxZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.osmTileUrl,
          userAgentPackageName: AppConstants.userAgent,
          maxZoom: AppConstants.maxTileZoom,
        ),
        if (routeInfo != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routeInfo!.points,
                color: Colors.blue,
                strokeWidth: AppConstants.routeStrokeWidth,
              ),
            ],
          ),
        MarkerLayer(
          markers: _buildPOIMarkers(),
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: currentLocation,
              width: AppConstants.currentLocationMarkerSize,
              height: AppConstants.currentLocationMarkerSize,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Marker> _buildPOIMarkers() {
    return pois.map((poi) {
      Color markerColor;
      final isSelected = selectedPOI?.id == poi.id;

      if (isSelected) {
        markerColor = Colors.green;
      } else if (poi.isFavorite) {
        markerColor = Colors.yellow;
      } else {
        markerColor = Colors.red;
      }

      return Marker(
        point: poi.location,
        width: AppConstants.markerSize,
        height: AppConstants.markerSize,
        child: GestureDetector(
          onTap: () => onPOITap(poi),
          child: Icon(
            Icons.location_on,
            color: markerColor,
            size: AppConstants.markerSize,
          ),
        ),
      );
    }).toList();
  }
}
