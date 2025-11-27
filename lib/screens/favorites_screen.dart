import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/preferences_service.dart';
import '../widgets/news_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late PreferencesService _preferencesService;
  List<NewsArticle> _favorites = [];

  @override
  void initState() {
    super.initState();
    _preferencesService = PreferencesService();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await _preferencesService.init();
    final favorites = await _preferencesService.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFavorite(String articleId) async {
    await _preferencesService.removeFavorite(articleId);
    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Articles'),
        elevation: 0,
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorite articles yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add articles to your favorites to see them here',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final article = _favorites[index];
                return NewsCard(
                  article: article,
                  onFavoriteToggle: () => _removeFavorite(article.id),
                );
              },
            ),
    );
  }
}
