import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/news_article.dart';

class PreferencesService {
  static const String _favoritesKey = 'favorites';
  static const String _articlesKey = 'articles';
  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== FAVORITES MANAGEMENT ====================
  
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

  // ==================== CRUD OPERATIONS FOR ARTICLES ====================
  
  /// Create - Add a new article
  Future<void> createArticle(NewsArticle article) async {
    final articles = await getAllArticles();
    if (!articles.any((a) => a.id == article.id)) {
      articles.add(article);
      await _saveArticles(articles);
    }
  }

  /// Read - Get all articles
  Future<List<NewsArticle>> getAllArticles() async {
    final jsonString = _prefs.getString(_articlesKey);
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

  /// Read - Get article by ID
  Future<NewsArticle?> getArticleById(String id) async {
    final articles = await getAllArticles();
    try {
      return articles.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update - Update an existing article
  Future<bool> updateArticle(NewsArticle article) async {
    final articles = await getAllArticles();
    final index = articles.indexWhere((a) => a.id == article.id);
    
    if (index != -1) {
      articles[index] = article;
      await _saveArticles(articles);
      return true;
    }
    return false;
  }

  /// Delete - Remove an article
  Future<bool> deleteArticle(String articleId) async {
    final articles = await getAllArticles();
    final initialLength = articles.length;
    articles.removeWhere((a) => a.id == articleId);
    
    if (articles.length < initialLength) {
      await _saveArticles(articles);
      return true;
    }
    return false;
  }

  /// Delete all articles
  Future<void> deleteAllArticles() async {
    await _prefs.remove(_articlesKey);
  }

  Future<void> _saveArticles(List<NewsArticle> articles) async {
    final jsonList = articles.map((a) => a.toJson()).toList();
    await _prefs.setString(_articlesKey, jsonEncode(jsonList));
  }

  // ==================== BACKUP & RESTORE ====================
  
  /// Export all data (favorites + articles) to JSON string
  Future<String> exportDataToJson() async {
    final favorites = await getFavorites();
    final articles = await getAllArticles();
    
    final backupData = {
      'version': '1.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'favorites': favorites.map((a) => a.toJson()).toList(),
      'articles': articles.map((a) => a.toJson()).toList(),
    };
    
    return jsonEncode(backupData);
  }

  /// Import data from JSON string
  Future<bool> importDataFromJson(String jsonString) async {
    try {
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Validate backup format
      if (!backupData.containsKey('favorites') || !backupData.containsKey('articles')) {
        return false;
      }

      // Import favorites
      final favoritesList = (backupData['favorites'] as List<dynamic>)
          .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
          .toList();
      await _saveFavorites(favoritesList);

      // Import articles
      final articlesList = (backupData['articles'] as List<dynamic>)
          .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
          .toList();
      await _saveArticles(articlesList);

      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== THEME PREFERENCE ====================
  
  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }

  String getThemeMode() {
    return _prefs.getString(_themeKey) ?? 'system';
  }

  // ==================== NOTIFICATIONS PREFERENCE ====================
  
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_notificationsKey, enabled);
  }

  bool isNotificationsEnabled() {
    return _prefs.getBool(_notificationsKey) ?? true;
  }
}
