import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;

  const BookDetailScreen({super.key, required this.bookId});

  Future<Map<String, dynamic>> _loadBook() async {
    final indexString =
        await rootBundle.loadString('assets/json/books/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final item = items.firstWhere(
      (book) => book['id'] == bookId,
      orElse: () => throw StateError('Unknown book: $bookId'),
    );
    final bookString =
        await rootBundle.loadString('assets/json/books/${item['file']}');
    return json.decode(bookString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadBook(),
      builder: (context, snapshot) {
        final title = snapshot.data?['title'] as String? ?? 'Book';

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: const Color(0xFF1B4D3E),
          ),
          body: _buildBody(context, snapshot),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Unable to load book: ${snapshot.error}'));
    }

    final book = snapshot.data ?? {};
    final chapters =
        List<Map<String, dynamic>>.from(book['chapters'] as List? ?? []);
    final titleArabic = book['titleArabic'] as String? ?? '';

    if (chapters.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (titleArabic.isNotEmpty)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                titleArabic,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          const SizedBox(height: 12),
          Text(book['description'] as String? ?? ''),
          const SizedBox(height: 12),
          const Text('Licensed text has not been added for this book yet.'),
        ],
      );
    }

    return ListView.builder(
      itemCount: chapters.length,
      itemBuilder: (context, index) => _ChapterTile(chapter: chapters[index]),
    );
  }
}

class _ChapterTile extends StatelessWidget {
  final Map<String, dynamic> chapter;

  const _ChapterTile({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final sections =
        List<Map<String, dynamic>>.from(chapter['sections'] as List? ?? []);
    final titleArabic = chapter['titleArabic'] as String? ?? '';

    return ExpansionTile(
      title: Text('${chapter['number']}. ${chapter['title']}'),
      subtitle: titleArabic.isEmpty
          ? null
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Text(titleArabic),
            ),
      children: [
        for (final section in sections)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _SectionView(section: section),
          ),
      ],
    );
  }
}

class _SectionView extends StatelessWidget {
  final Map<String, dynamic> section;

  const _SectionView({required this.section});

  @override
  Widget build(BuildContext context) {
    final lines =
        List<Map<String, dynamic>>.from(section['lines'] as List? ?? []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          section['title'] as String? ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        for (final line in lines) _LineView(line: line),
      ],
    );
  }
}

class _LineView extends StatelessWidget {
  final Map<String, dynamic> line;

  const _LineView({required this.line});

  @override
  Widget build(BuildContext context) {
    final arabic = line['textArabic'] as String? ?? '';
    final urdu = line['textUrdu'] as String? ?? '';
    final farsi = line['textFarsi'] as String? ?? '';
    final english = line['textEnglish'] as String? ?? '';
    final transliteration = line['transliteration'] as String? ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${line['number']}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          if (arabic.isNotEmpty)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                arabic,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          if (urdu.isNotEmpty)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(urdu),
            ),
          if (farsi.isNotEmpty)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(farsi),
            ),
          if (english.isNotEmpty) Text(english),
          if (transliteration.isNotEmpty)
            Text(
              transliteration,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
