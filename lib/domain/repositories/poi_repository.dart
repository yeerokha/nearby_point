import 'package:nearby_point/domain/entities/poi_entity.dart';

abstract class POIRepository {
  Future<List<POIEntity>> getAllPOIs();
  Future<POIEntity?> getPOIById(int id);
  Future<List<int>> getFavoriteIds();
  Future<bool> isFavorite(int id);
  Future<void> toggleFavorite(POIEntity poi);
}
