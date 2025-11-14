import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nearby_point/core/di/dependency_injection.dart';
import 'package:nearby_point/presentation/screens/map_screen_refactored.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DependencyInjection.createMapProvider(),
      child: MaterialApp(
        title: 'Nearby Points',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MapScreen(),
      ),
    );
  }
}
