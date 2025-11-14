import 'package:nearby_point/domain/entities/poi_entity.dart';
import 'package:nearby_point/domain/repositories/poi_repository.dart';

class GetAllPOIsUseCase {
  final POIRepository repository;

  GetAllPOIsUseCase(this.repository);

  Future<List<POIEntity>> call() async {
    return await repository.getAllPOIs();
  }
}
