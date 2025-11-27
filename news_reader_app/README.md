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
