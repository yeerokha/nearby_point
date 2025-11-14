import 'package:json_annotation/json_annotation.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';

part 'poi_model.g.dart';

@JsonSerializable()
class POIModel {
  final int id;
  final String name;
  final double lat;
  final double lng;
  @JsonKey(defaultValue: POICategory.other)
  final POICategory category;

  POIModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.category = POICategory.other,
  });

  factory POIModel.fromJson(Map<String, dynamic> json) => _$POIModelFromJson(json);
  Map<String, dynamic> toJson() => _$POIModelToJson(this);

  POIEntity toEntity({bool isFavorite = false}) {
    return POIEntity(
      id: id,
      name: name,
      lat: lat,
      lng: lng,
      category: category,
      isFavorite: isFavorite,
    );
  }

  factory POIModel.fromEntity(POIEntity entity) {
    return POIModel(
      id: entity.id,
      name: entity.name,
      lat: entity.lat,
      lng: entity.lng,
      category: entity.category,
    );
  }
}

@JsonSerializable()
class POIResponse {
  final List<POIModel> points;

  POIResponse({required this.points});

  factory POIResponse.fromJson(Map<String, dynamic> json) => _$POIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$POIResponseToJson(this);
}
