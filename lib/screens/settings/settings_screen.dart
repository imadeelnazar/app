import 'package:flutter/material.dart';
import '../../services/app_theme_service.dart';
import '../../widgets/app_chrome.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String language = 'English';
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: haqaiqAppBar(context, title: 'Settings'),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
      body: ListView(
        children: [
          // Language Setting
          ListTile(
            title: const Text('Language'),
            subtitle: Text(language),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: const Text('Select Language'),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() => language = 'English');
                        Navigator.pop(context);
                      },
                      child: const Text('English'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() => language = 'Urdu');
                        Navigator.pop(context);
                      },
                      child: const Text('Urdu'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() => language = 'Farsi');
                        Navigator.pop(context);
                      },
                      child: const Text('Farsi'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: AppThemeService.instance.mode,
              builder: (context, mode, _) {
                final selected = mode == ThemeMode.dark ? {'dark'} : {'light'};
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Theme Mode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'light',
                            icon: Icon(Icons.light_mode_rounded),
                            label: Text('Light'),
                          ),
                          ButtonSegment(
                            value: 'dark',
                            icon: Icon(Icons.dark_mode_rounded),
                            label: Text('Dark'),
                          ),
                        ],
                        selected: selected,
                        onSelectionChanged: (value) {
                          final next = value.first == 'dark'
                              ? ThemeMode.dark
                              : ThemeMode.light;
                          AppThemeService.instance.setMode(next);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(),
          // Notifications
          SwitchListTile(
            title: const Text('Notifications'),
            value: notifications,
            onChanged: (value) => setState(() => notifications = value),
          ),
          const Divider(),
          // About
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Haqaiq v1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
