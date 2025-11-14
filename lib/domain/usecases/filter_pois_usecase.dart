import 'package:nearby_point/domain/entities/poi_entity.dart';

class FilterPOIsUseCase {
  List<POIEntity> call({
    required List<POIEntity> pois,
    String? searchQuery,
    Set<POICategory>? categories,
  }) {
    return pois.where((poi) {
      final matchesSearch = searchQuery == null ||
          searchQuery.isEmpty ||
          poi.name.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCategory =
          categories == null || categories.isEmpty || categories.contains(poi.category);

      return matchesSearch && matchesCategory;
    }).toList();
  }
}
