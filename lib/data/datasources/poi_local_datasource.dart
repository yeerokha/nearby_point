import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nearby_point/data/models/poi_model.dart';

abstract class POILocalDataSource {
  Future<List<POIModel>> loadPOIs();
}

class POILocalDataSourceImpl implements POILocalDataSource {
  @override
  Future<List<POIModel>> loadPOIs() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/poi.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final response = POIResponse.fromJson(jsonMap);
      return response.points;
    } catch (e) {
      throw Exception('Failed to load POIs: $e');
    }
  }
}
