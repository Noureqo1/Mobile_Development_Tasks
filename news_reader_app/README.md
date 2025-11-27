# News Reader App - Structure

## Overview
A Flutter-based news reader application with tab-based navigation, favorites management, and customizable settings.

## Project Structure

```
lib/
├── main.dart                          # App entry point and main navigation
├── models/
│   └── news_article.dart             # NewsArticle data model
├── screens/
│   ├── home_screen.dart              # Home screen with news feed and category filter
│   ├── favorites_screen.dart         # Favorites screen showing saved articles
│   └── settings_screen.dart          # Settings screen for app preferences
├── services/
│   └── preferences_service.dart      # Shared preferences management
└── widgets/
    └── news_card.dart                # Reusable news article card widget
```

## Features

### 1. **Navigation**
- Bottom navigation bar with 3 tabs (Home, Favorites, Settings)
- IndexedStack for efficient screen switching
- Preserves state when switching between tabs

### 2. **Home Screen**
- Displays news articles in a scrollable list
- Category filtering (All, Technology, Business, Sports, Health)
- Add/remove articles from favorites
- Shows article metadata (category, time, title, description)
- Placeholder images for articles

### 3. **Favorites Screen**
- View all saved favorite articles
- Remove articles from favorites
- Empty state message when no favorites exist

### 4. **Settings Screen**
- **Appearance**: Theme mode selection (Light, Dark, System)
- **Notifications**: Toggle notifications on/off
- **About**: App version and build information
- All settings persist using SharedPreferences

### 4. **Data Persistence**
- SharedPreferences for storing:
  - Favorite articles (JSON serialized)
  - Theme preference
  - Notification settings

## Key Implementation Details

### Navigation Flow
- Uses `Navigator.push/pop` for stack-based navigation
- `BottomNavigationBar` with `IndexedStack` for efficient tab switching
- State is preserved when switching between tabs

### Preferences Management
- `PreferencesService` handles all local data persistence
- Favorites stored as JSON array
- Theme and notification settings stored as strings/booleans

### UI Components
- Material Design 3 with custom color scheme
- Responsive layouts with proper spacing
- Error handling for image loading
- Empty states for better UX

## Dependencies
- `flutter`: Core framework
- `shared_preferences: ^2.2.2`: Local data persistence

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Sample Data
The app includes 6 sample news articles across different categories for demonstration purposes.

## Features Added in Lab7 Task:

## Overview
The News Reader App now includes comprehensive data persistence, CRUD operations, and backup/restore functionality.

## Features Implemented

### 1. **Local Data Persistence** ✅
- **SharedPreferences Integration**: All data is stored locally on the device
- **JSON Serialization**: Data is serialized to JSON format for storage
- **Automatic Saving**: Changes are automatically persisted to device storage
- **Data Categories**: Separate storage for favorites and articles

### 2. **CRUD Operations** ✅

#### Create
- `createArticle(NewsArticle)` - Add a new article to local storage
- Prevents duplicate articles by checking article ID

#### Read
- `getAllArticles()` - Retrieve all stored articles
- `getArticleById(String id)` - Retrieve a specific article by ID
- `getFavorites()` - Get all favorited articles

#### Update
- `updateArticle(NewsArticle)` - Update an existing article
- Returns `true` if update was successful, `false` if article not found

#### Delete
- `deleteArticle(String id)` - Remove a specific article
- `deleteAllArticles()` - Clear all stored articles
- `removeFavorite(String id)` - Remove from favorites

### 3. **Backup (Export JSON)** ✅
- **exportDataToJson()** - Export all data to JSON string
- Includes:
  - Version information
  - Export timestamp
  - All favorites
  - All articles
- JSON format is human-readable and portable
- Can be copied to clipboard for easy sharing

### 4. **Import JSON Restore** ✅
- **importDataFromJson(String json)** - Import data from JSON backup
- Validates backup format before importing
- Restores both favorites and articles
- Returns `true` on success, `false` on failure
- Error handling for corrupted or invalid JSON

## File Structure

```
lib/
├── services/
│   └── preferences_service.dart    # Enhanced with CRUD & backup/restore
├── screens/
│   ├── backup_restore_screen.dart  # New backup/restore UI
│   └── settings_screen.dart        # Updated with backup/restore link
└── models/
    └── news_article.dart           # NewsArticle with JSON serialization
```

## API Reference

### PreferencesService Methods

#### CRUD Operations
```dart
// Create
Future<void> createArticle(NewsArticle article)

// Read
Future<List<NewsArticle>> getAllArticles()
Future<NewsArticle?> getArticleById(String id)
Future<List<NewsArticle>> getFavorites()

// Update
Future<bool> updateArticle(NewsArticle article)

// Delete
Future<bool> deleteArticle(String articleId)
Future<void> deleteAllArticles()
Future<void> removeFavorite(String articleId)
```

#### Backup & Restore
```dart
// Export to JSON
Future<String> exportDataToJson()

// Import from JSON
Future<bool> importDataFromJson(String jsonString)
```

## Usage Examples

### Adding an Article
```dart
final article = NewsArticle(
  id: '7',
  title: 'New Article',
  description: 'Article description',
  imageUrl: 'https://example.com/image.jpg',
  category: 'Technology',
  publishedAt: DateTime.now(),
);

await preferencesService.createArticle(article);
```

### Retrieving Articles
```dart
// Get all articles
final articles = await preferencesService.getAllArticles();

// Get specific article
final article = await preferencesService.getArticleById('7');
```

### Updating an Article
```dart
article.title = 'Updated Title';
final success = await preferencesService.updateArticle(article);
```

### Deleting Articles
```dart
// Delete single article
await preferencesService.deleteArticle('7');

// Delete all articles
await preferencesService.deleteAllArticles();
```

### Backup & Restore
```dart
// Export backup
final jsonBackup = await preferencesService.exportDataToJson();

// Import backup
final success = await preferencesService.importDataFromJson(jsonBackup);
```

## Backup JSON Format

```json
{
  "version": "1.0",
  "exportedAt": "2024-01-15T10:30:00.000Z",
  "favorites": [
    {
      "id": "1",
      "title": "Article Title",
      "description": "Article description",
      "imageUrl": "https://example.com/image.jpg",
      "category": "Technology",
      "publishedAt": "2024-01-15T08:00:00.000Z",
      "isFavorite": true
    }
  ],
  "articles": [
    {
      "id": "2",
      "title": "Another Article",
      "description": "Description",
      "imageUrl": "https://example.com/image2.jpg",
      "category": "Business",
      "publishedAt": "2024-01-14T12:00:00.000Z",
      "isFavorite": false
    }
  ]
}
```

## How to Use Backup & Restore

### Accessing Backup & Restore
1. Go to **Settings** tab
2. Scroll to **Data Management** section
3. Tap **Backup & Restore**

### Creating a Backup
1. Click **Export Data** button
2. Your backup JSON will be displayed
3. Click **Copy to Clipboard** to copy the data
4. Save it in a text file or email it to yourself

### Restoring from Backup
1. Click **Import Data** button
2. Paste your backup JSON in the dialog
3. Click **Import**
4. Your data will be restored

## Data Storage Details

- **Storage Location**: Device's local SharedPreferences
- **Persistence**: Data persists across app sessions
- **Backup Format**: JSON (human-readable, portable)
- **Encryption**: Not encrypted (consider adding for sensitive data)
- **Size Limit**: Depends on device storage

## Best Practices

1. **Regular Backups**: Export your data regularly to prevent data loss
2. **Safe Storage**: Keep backup files in a secure location
3. **Version Control**: Note the export date for version tracking
4. **Testing**: Test restore functionality before relying on it
5. **Multiple Copies**: Keep multiple backup copies in different locations

## Error Handling

- Invalid JSON format returns `false` on import
- Missing required fields are handled gracefully
- Corrupted data is skipped during import
- All operations include try-catch blocks

## Future Enhancements

- Cloud backup integration
- Automatic periodic backups
- Encrypted backups
- Selective restore (choose what to restore)
- Backup versioning and history