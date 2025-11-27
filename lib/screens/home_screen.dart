import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/preferences_service.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PreferencesService _preferencesService;
  late List<NewsArticle> _articles;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Technology', 'Business', 'Sports', 'Health'];

  @override
  void initState() {
    super.initState();
    _preferencesService = PreferencesService();
    _initializePreferences();
    _loadArticles();
  }

  Future<void> _initializePreferences() async {
    await _preferencesService.init();
    setState(() {});
  }

  void _loadArticles() {
    // Sample news data
    _articles = [
      NewsArticle(
        id: '1',
        title: 'Flutter 4.0 Released with New Features',
        description: 'The latest version of Flutter brings improved performance and new widgets for better app development.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Flutter+4.0',
        category: 'Technology',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NewsArticle(
        id: '2',
        title: 'Tech Giants Announce New Partnership',
        description: 'Leading technology companies join forces to create innovative solutions for the future.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Tech+Partnership',
        category: 'Business',
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      NewsArticle(
        id: '3',
        title: 'Mobile Development Trends 2024',
        description: 'Explore the latest trends in mobile app development and what developers should focus on.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Mobile+Trends',
        category: 'Technology',
        publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      NewsArticle(
        id: '4',
        title: 'Stock Market Reaches New Heights',
        description: 'Global markets show strong performance with tech stocks leading the way.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Stock+Market',
        category: 'Business',
        publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      NewsArticle(
        id: '5',
        title: 'Championship Game Highlights',
        description: 'Exciting moments from the biggest sports event of the season.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Sports',
        category: 'Sports',
        publishedAt: DateTime.now().subtract(const Duration(hours: 10)),
      ),
      NewsArticle(
        id: '6',
        title: 'New Health Study Shows Benefits',
        description: 'Recent research reveals important health benefits of regular exercise.',
        imageUrl: 'https://via.placeholder.com/400x200?text=Health',
        category: 'Health',
        publishedAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];
  }

  List<NewsArticle> get _filteredArticles {
    if (_selectedCategory == 'All') {
      return _articles;
    }
    return _articles.where((article) => article.category == _selectedCategory).toList();
  }

  Future<void> _toggleFavorite(NewsArticle article) async {
    if (article.isFavorite) {
      await _preferencesService.removeFavorite(article.id);
    } else {
      await _preferencesService.addFavorite(article);
    }
    setState(() {
      article.isFavorite = !article.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // News list
          Expanded(
            child: _filteredArticles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.newspaper,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No articles found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = _filteredArticles[index];
                      return NewsCard(
                        article: article,
                        onFavoriteToggle: () => _toggleFavorite(article),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
