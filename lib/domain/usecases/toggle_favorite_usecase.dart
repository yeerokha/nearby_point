import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/repositories/poi_repository.dart';

class ToggleFavoriteUseCase {
  final POIRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(POIEntity poi) async {
    await repository.toggleFavorite(poi);
  }
}
