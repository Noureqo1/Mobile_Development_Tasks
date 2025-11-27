import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PreferencesService _preferencesService;
  String _themeMode = 'system';
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _preferencesService = PreferencesService();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _preferencesService.init();
    setState(() {
      _themeMode = _preferencesService.getThemeMode();
      _notificationsEnabled = _preferencesService.isNotificationsEnabled();
    });
  }

  Future<void> _updateThemeMode(String mode) async {
    await _preferencesService.setThemeMode(mode);
    setState(() {
      _themeMode = mode;
    });
  }

  Future<void> _updateNotifications(bool enabled) async {
    await _preferencesService.setNotificationsEnabled(enabled);
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Theme section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Mode',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<String>(
                          segments: const <ButtonSegment<String>>[
                            ButtonSegment<String>(
                              value: 'light',
                              label: Text('Light'),
                              icon: Icon(Icons.light_mode),
                            ),
                            ButtonSegment<String>(
                              value: 'dark',
                              label: Text('Dark'),
                              icon: Icon(Icons.dark_mode),
                            ),
                            ButtonSegment<String>(
                              value: 'system',
                              label: Text('System'),
                              icon: Icon(Icons.settings),
                            ),
                          ],
                          selected: <String>{_themeMode},
                          onSelectionChanged: (Set<String> newSelection) {
                            _updateThemeMode(newSelection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Notifications section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: SwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive updates about new articles'),
                    value: _notificationsEnabled,
                    onChanged: _updateNotifications,
                  ),
                ),
              ],
            ),
          ),
          // About section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'App Version',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '1.0.0',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Build Number',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '1',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'News Reader App © 2024',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
