import 'package:flutter/material.dart';
import '../../widgets/app_chrome.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarks = [
      'Surah Al-Fatiha - Ayah 1',
      'Dua Kumail - Line 5',
      'Book Mafatih - Section 2',
      'Ziyarat Ashura - Line 10',
    ];

    return Scaffold(
      appBar: haqaiqAppBar(context, title: 'Bookmarks'),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
      body: bookmarks.isEmpty
          ? const Center(
              child: Text('No bookmarks yet'),
            )
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookmarks[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                );
              },
            ),
    );
  }
}
