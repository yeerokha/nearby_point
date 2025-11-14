import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  Future<List<int>> getFavoriteIds();
  Future<bool> isFavorite(int id);
  Future<void> addFavorite(int id);
  Future<void> removeFavorite(int id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String favoritesKey = 'favorite_poi_ids';

  @override
  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(favoritesKey) ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }

  @override
  Future<bool> isFavorite(int id) async {
    final favorites = await getFavoriteIds();
    return favorites.contains(id);
  }

  @override
  Future<void> addFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteIds();
    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList(
        favoritesKey,
        favorites.map((id) => id.toString()).toList(),
      );
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteIds();
    favorites.remove(id);
    await prefs.setStringList(
      favoritesKey,
      favorites.map((id) => id.toString()).toList(),
    );
  }
}
