import 'package:nearby_point/data/datasources/favorites_local_datasource.dart';
import 'package:nearby_point/data/datasources/location_datasource.dart';
import 'package:nearby_point/data/datasources/poi_local_datasource.dart';
import 'package:nearby_point/data/datasources/routing_remote_datasource.dart';
import 'package:nearby_point/data/repositories/location_repository_impl.dart';
import 'package:nearby_point/data/repositories/poi_repository_impl.dart';
import 'package:nearby_point/data/repositories/routing_repository_impl.dart';
import 'package:nearby_point/domain/repositories/location_repository.dart';
import 'package:nearby_point/domain/repositories/poi_repository.dart';
import 'package:nearby_point/domain/repositories/routing_repository.dart';
import 'package:nearby_point/domain/usecases/filter_pois_usecase.dart';
import 'package:nearby_point/domain/usecases/get_all_pois_usecase.dart';
import 'package:nearby_point/domain/usecases/get_current_location_usecase.dart';
import 'package:nearby_point/domain/usecases/get_route_usecase.dart';
import 'package:nearby_point/domain/usecases/toggle_favorite_usecase.dart';
import 'package:nearby_point/presentation/providers/map_provider.dart';

class DependencyInjection {
  // Data Sources
  static final POILocalDataSource _poiLocalDataSource = POILocalDataSourceImpl();
  static final FavoritesLocalDataSource _favoritesLocalDataSource = FavoritesLocalDataSourceImpl();
  static final LocationDataSource _locationDataSource = LocationDataSourceImpl();
  static final RoutingRemoteDataSource _routingRemoteDataSource = RoutingRemoteDataSourceImpl();

  // Repositories
  static final POIRepository _poiRepository = POIRepositoryImpl(
    localDataSource: _poiLocalDataSource,
    favoritesDataSource: _favoritesLocalDataSource,
  );

  static final LocationRepository _locationRepository = LocationRepositoryImpl(
    dataSource: _locationDataSource,
  );

  static final RoutingRepository _routingRepository = RoutingRepositoryImpl(
    remoteDataSource: _routingRemoteDataSource,
  );

  // Use Cases
  static final GetAllPOIsUseCase _getAllPOIsUseCase = GetAllPOIsUseCase(_poiRepository);
  static final FilterPOIsUseCase _filterPOIsUseCase = FilterPOIsUseCase();
  static final GetCurrentLocationUseCase _getCurrentLocationUseCase = GetCurrentLocationUseCase(_locationRepository);
  static final GetRouteUseCase _getRouteUseCase = GetRouteUseCase(_routingRepository);
  static final ToggleFavoriteUseCase _toggleFavoriteUseCase = ToggleFavoriteUseCase(_poiRepository);

  // Provider
  static MapProvider createMapProvider() {
    return MapProvider(
      getAllPOIsUseCase: _getAllPOIsUseCase,
      filterPOIsUseCase: _filterPOIsUseCase,
      getCurrentLocationUseCase: _getCurrentLocationUseCase,
      getRouteUseCase: _getRouteUseCase,
      toggleFavoriteUseCase: _toggleFavoriteUseCase,
    );
  }
}
