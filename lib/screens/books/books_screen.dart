import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  Future<List<Map<String, dynamic>>> _loadBooks() async {
    final jsonString =
        await rootBundle.loadString('assets/json/books/index.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(data['items'] as List? ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        backgroundColor: const Color(0xFF1B4D3E),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load books: ${snapshot.error}'));
          }

          final books = snapshot.data ?? [];
          return ListView.separated(
            itemCount: books.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final book = books[index];
              final titleArabic = book['titleArabic'] as String? ?? '';
              final chapterCount = book['chapterCount'] as int? ?? 0;
              final lineCount = book['lineCount'] as int? ?? 0;

              return ListTile(
                title: Text(book['title'] as String? ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (titleArabic.isNotEmpty)
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(titleArabic),
                      ),
                    Text('$chapterCount chapters - $lineCount lines'),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/book/${book['id']}'),
              );
            },
          );
        },
      ),
    );
  }
}
