import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearby_point/core/constants/app_constants.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/entities/route_entity.dart';
import 'package:nearby_point/domain/usecases/get_all_pois_usecase.dart';
import 'package:nearby_point/domain/usecases/filter_pois_usecase.dart';
import 'package:nearby_point/domain/usecases/get_current_location_usecase.dart';
import 'package:nearby_point/domain/usecases/get_route_usecase.dart';
import 'package:nearby_point/domain/usecases/toggle_favorite_usecase.dart';

class MapProvider extends ChangeNotifier {
  final GetAllPOIsUseCase getAllPOIsUseCase;
  final FilterPOIsUseCase filterPOIsUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetRouteUseCase getRouteUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  final MapController mapController = MapController();

  LatLng? _currentLocation;
  List<POIEntity> _allPOIs = [];
  List<POIEntity> _filteredPOIs = [];
  POIEntity? _selectedPOI;
  RouteEntity? _routeInfo;
  bool _isLoadingRoute = false;
  String _searchQuery = '';
  final Set<POICategory> _selectedCategories = {};
  String? _locationError;
  bool _isLoading = false;

  MapProvider({
    required this.getAllPOIsUseCase,
    required this.filterPOIsUseCase,
    required this.getCurrentLocationUseCase,
    required this.getRouteUseCase,
    required this.toggleFavoriteUseCase,
  });

  // Getters
  LatLng? get currentLocation => _currentLocation;
  List<POIEntity> get filteredPOIs => _filteredPOIs;
  POIEntity? get selectedPOI => _selectedPOI;
  RouteEntity? get routeInfo => _routeInfo;
  bool get isLoadingRoute => _isLoadingRoute;
  String get searchQuery => _searchQuery;
  Set<POICategory> get selectedCategories => _selectedCategories;
  String? get locationError => _locationError;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    await _initializeLocation();
    await _loadPOIs();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _initializeLocation() async {
    final location = await getCurrentLocationUseCase();
    if (location != null) {
      _currentLocation = location;
      _locationError = null;
    } else {
      _currentLocation = AppConstants.defaultLocation;
      _locationError = 'Could not get your location. Using default location.';
    }
    notifyListeners();
  }

  Future<void> retryLocation() async {
    _locationError = null;
    notifyListeners();
    await _initializeLocation();
  }

  Future<void> _loadPOIs() async {
    try {
      _allPOIs = await getAllPOIsUseCase();
      _updateFilteredPOIs();
    } catch (e) {
      debugPrint('Error loading POIs: $e');
    }
  }

  void _updateFilteredPOIs() {
    _filteredPOIs = filterPOIsUseCase(
      pois: _allPOIs,
      searchQuery: _searchQuery,
      categories: _selectedCategories.isEmpty ? null : _selectedCategories,
    );
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _updateFilteredPOIs();
  }

  void toggleCategoryFilter(POICategory category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _updateFilteredPOIs();
  }

  Future<void> selectPOI(POIEntity poi) async {
    if (_currentLocation == null) return;

    _selectedPOI = poi;
    _isLoadingRoute = true;
    _routeInfo = null;
    notifyListeners();

    final routeInfo = await getRouteUseCase(_currentLocation!, poi.location);

    if (routeInfo != null) {
      _routeInfo = routeInfo;
      _isLoadingRoute = false;
      notifyListeners();

      _fitCameraToBounds(routeInfo.points);
    } else {
      _isLoadingRoute = false;
      notifyListeners();

      _fitCameraToBounds([_currentLocation!, poi.location]);
    }
  }

  void _fitCameraToBounds(List<LatLng> points) {
    if (points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    final bounds = LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );

    mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(AppConstants.cameraPadding),
      ),
    );
  }

  Future<void> toggleFavorite(POIEntity poi) async {
    await toggleFavoriteUseCase(poi);

    // Reload POIs to update favorite status
    await _loadPOIs();

    // Update selected POI if it's the one being toggled
    if (_selectedPOI?.id == poi.id) {
      _selectedPOI = _allPOIs.firstWhere((p) => p.id == poi.id);
      notifyListeners();
    }
  }

  void clearSelection() {
    _selectedPOI = null;
    _routeInfo = null;
    notifyListeners();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
