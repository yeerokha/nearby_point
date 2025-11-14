import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nearby_point/presentation/providers/map_provider.dart';
import 'package:nearby_point/presentation/widgets/search_bar_widget.dart';
import 'package:nearby_point/presentation/widgets/category_filter_button.dart';
import 'package:nearby_point/presentation/widgets/location_error_banner.dart';
import 'package:nearby_point/presentation/widgets/map_widget.dart';
import 'package:nearby_point/presentation/widgets/poi_info_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.currentLocation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              MapWidget(
                mapController: provider.mapController,
                currentLocation: provider.currentLocation!,
                pois: provider.filteredPOIs,
                selectedPOI: provider.selectedPOI,
                routeInfo: provider.routeInfo,
                onPOITap: (poi) => provider.selectPOI(poi),
              ),
              _buildSearchBar(context, provider),
              if (provider.locationError != null) _buildLocationError(context, provider),
              if (provider.selectedPOI != null) _buildPOIInfo(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, MapProvider provider) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      right: 10,
      child: SearchBarWidget(
        hintText: 'Search places...',
        onChanged: (value) => provider.updateSearchQuery(value),
        trailing: CategoryFilterButton(selectedCategories: provider.selectedCategories, onCategoryToggle: (category) => provider.toggleCategoryFilter(category)),
      ),
    );
  }

  Widget _buildLocationError(BuildContext context, MapProvider provider) {
    return Positioned(top: MediaQuery.of(context).padding.top + 70, left: 10, right: 10, child: LocationErrorBanner(errorMessage: provider.locationError!, onRetry: () => provider.retryLocation()));
  }

  Widget _buildPOIInfo(BuildContext context, MapProvider provider) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: POIInfoBottomSheet(
        poi: provider.selectedPOI!,
        routeInfo: provider.routeInfo,
        isLoadingRoute: provider.isLoadingRoute,
        onToggleFavorite: (poi) => provider.toggleFavorite(poi),
        onNavigate: () {},
      ),
    );
  }
}
