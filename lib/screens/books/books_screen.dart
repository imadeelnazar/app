import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/app_chrome.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  Future<List<Map<String, dynamic>>> _loadBooks() async {
    final jsonString =
        await rootBundle.loadString('assets/json/books/index.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(data['items'] as List? ?? []);
  }

  Future<void> _readBook(Map<String, dynamic> book) async {
    final file = book['file'] as String? ?? '';
    if (file.isEmpty) return;

    final jsonString = await rootBundle.loadString('assets/json/books/$file');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final chapters =
        List<Map<String, dynamic>>.from(data['chapters'] as List? ?? []);
    final lines = <ReaderLine>[];

    for (final chapter in chapters) {
      final sections =
          List<Map<String, dynamic>>.from(chapter['sections'] as List? ?? []);
      for (final section in sections) {
        final sectionLines =
            List<Map<String, dynamic>>.from(section['lines'] as List? ?? []);
        lines.addAll(sectionLines.map(ReaderLine.fromJson));
      }
    }

    await ReaderAudioService.instance.playLines(
      title: data['title'] as String? ?? book['title'] as String? ?? 'Book',
      lines: lines,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(context, title: 'Books'),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 3),
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

          final query = _query.toLowerCase();
          final books = (snapshot.data ?? []).where((book) {
            final searchText = [
              book['title'],
              book['titleArabic'],
              book['titleUrdu'],
              book['titleFarsi'],
              book['category'],
              book['id'],
            ].join(' ').toLowerCase();
            return query.isEmpty || searchText.contains(query);
          }).toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: HidayatSearchField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  hintText: 'Search books',
                ),
              ),
              Expanded(
                child: ListView.separated(
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.volume_up_outlined),
                            tooltip: 'Read aloud',
                            onPressed: () => _readBook(book),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push('/book/${book['id']}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
