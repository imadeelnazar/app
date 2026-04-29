import 'package:flutter/material.dart';
import '../../widgets/app_chrome.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String language = 'English';
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(context, title: 'Settings'),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
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
          // Dark Mode
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkMode,
            onChanged: (value) => setState(() => darkMode = value),
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
            subtitle: const Text('Hidayat v1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
