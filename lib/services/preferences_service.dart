import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/news_article.dart';

class PreferencesService {
  static const String _favoritesKey = 'favorites';
  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Favorites management
  Future<void> addFavorite(NewsArticle article) async {
    final favorites = await getFavorites();
    if (!favorites.any((a) => a.id == article.id)) {
      article.isFavorite = true;
      favorites.add(article);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String articleId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((a) => a.id == articleId);
    await _saveFavorites(favorites);
  }

  Future<List<NewsArticle>> getFavorites() async {
    final jsonString = _prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveFavorites(List<NewsArticle> favorites) async {
    final jsonList = favorites.map((a) => a.toJson()).toList();
    await _prefs.setString(_favoritesKey, jsonEncode(jsonList));
  }

  // Theme preference
  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }

  String getThemeMode() {
    return _prefs.getString(_themeKey) ?? 'system';
  }

  // Notifications preference
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_notificationsKey, enabled);
  }

  bool isNotificationsEnabled() {
    return _prefs.getBool(_notificationsKey) ?? true;
  }
}
