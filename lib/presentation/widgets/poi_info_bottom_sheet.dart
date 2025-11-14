import 'package:flutter/material.dart';
import 'package:nearby_point/core/constants/app_constants.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';

class POIInfoBottomSheet extends StatelessWidget {
  final POIEntity poi;
  final RouteEntity? routeInfo;
  final bool isLoadingRoute;
  final Function(POIEntity) onToggleFavorite;
  final VoidCallback? onNavigate;

  const POIInfoBottomSheet({
    super.key,
    required this.poi,
    this.routeInfo,
    required this.isLoadingRoute,
    required this.onToggleFavorite,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.animationDuration,
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildCoordinates(),
          if (isLoadingRoute || routeInfo != null) ...[
            const SizedBox(height: 12),
            _buildRouteInfo(context),
          ],
          const SizedBox(height: 16),
          _buildNavigateButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                poi.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getCategoryName(),
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            poi.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: poi.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () => onToggleFavorite(poi),
        ),
      ],
    );
  }

  Widget _buildCoordinates() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.grey, size: 16),
        const SizedBox(width: 4),
        Text(
          '${poi.lat.toStringAsFixed(6)}, ${poi.lng.toStringAsFixed(6)}',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRouteInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoadingRoute
          ? const Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12),
                Text('Calculating route...'),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRouteDetail(
                  Icons.directions_car,
                  routeInfo!.distanceText,
                  'Distance',
                  context,
                ),
                _buildRouteDetail(
                  Icons.access_time,
                  routeInfo!.durationText,
                  'Duration',
                  context,
                ),
              ],
            ),
    );
  }

  Widget _buildRouteDetail(IconData icon, String value, String label, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigateButton() {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: onNavigate,
            icon: const Icon(Icons.directions),
            label: const Text('Navigate'),
          ),
        ),
      ],
    );
  }

  String _getCategoryName() {
    return poi.category.toString().split('.').last;
  }
}
