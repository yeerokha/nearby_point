// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

POIModel _$POIModelFromJson(Map<String, dynamic> json) => POIModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  category:
      $enumDecodeNullable(_$POICategoryEnumMap, json['category']) ??
      POICategory.other,
);

Map<String, dynamic> _$POIModelToJson(POIModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'lat': instance.lat,
  'lng': instance.lng,
  'category': _$POICategoryEnumMap[instance.category]!,
};

const _$POICategoryEnumMap = {
  POICategory.restaurant: 'restaurant',
  POICategory.cafe: 'cafe',
  POICategory.gasStation: 'gasStation',
  POICategory.shopping: 'shopping',
  POICategory.carService: 'carService',
  POICategory.other: 'other',
};

POIResponse _$POIResponseFromJson(Map<String, dynamic> json) => POIResponse(
  points:
      (json['points'] as List<dynamic>)
          .map((e) => POIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$POIResponseToJson(POIResponse instance) =>
    <String, dynamic>{'points': instance.points};
