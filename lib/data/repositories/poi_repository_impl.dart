import 'package:nearby_point/data/datasources/poi_local_datasource.dart';
import 'package:nearby_point/data/datasources/favorites_local_datasource.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/repositories/poi_repository.dart';

class POIRepositoryImpl implements POIRepository {
  final POILocalDataSource localDataSource;
  final FavoritesLocalDataSource favoritesDataSource;

  POIRepositoryImpl({
    required this.localDataSource,
    required this.favoritesDataSource,
  });

  @override
  Future<List<POIEntity>> getAllPOIs() async {
    final models = await localDataSource.loadPOIs();
    final favoriteIds = await favoritesDataSource.getFavoriteIds();

    return models.map((model) {
      final isFavorite = favoriteIds.contains(model.id);
      return model.toEntity(isFavorite: isFavorite);
    }).toList();
  }

  @override
  Future<POIEntity?> getPOIById(int id) async {
    final allPOIs = await getAllPOIs();
    try {
      return allPOIs.firstWhere((poi) => poi.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<int>> getFavoriteIds() async {
    return await favoritesDataSource.getFavoriteIds();
  }

  @override
  Future<bool> isFavorite(int id) async {
    return await favoritesDataSource.isFavorite(id);
  }

  @override
  Future<void> toggleFavorite(POIEntity poi) async {
    final isFav = await isFavorite(poi.id);
    if (isFav) {
      await favoritesDataSource.removeFavorite(poi.id);
    } else {
      await favoritesDataSource.addFavorite(poi.id);
    }
  }
}
