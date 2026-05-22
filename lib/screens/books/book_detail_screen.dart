import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_chrome.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/reader_audio_bar.dart';

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
          appBar: haqaiqAppBar(context, title: title),
          bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 3),
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
    final title = book['title'] as String? ?? 'Book';
    final readerLines = _collectBookLines(chapters);

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
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: chapters.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ReaderAudioBar(title: title, lines: readerLines);
        }
        return _ChapterTile(chapter: chapters[index - 1], title: title);
      },
    );
  }

  List<ReaderLine> _collectBookLines(List<Map<String, dynamic>> chapters) {
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
    return lines;
  }
}

class _ChapterTile extends StatelessWidget {
  final Map<String, dynamic> chapter;
  final String title;

  const _ChapterTile({required this.chapter, required this.title});

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
            child: _SectionView(section: section, title: title),
          ),
      ],
    );
  }
}

class _SectionView extends StatelessWidget {
  final Map<String, dynamic> section;
  final String title;

  const _SectionView({required this.section, required this.title});

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
        for (final line in lines)
          _LineView(
            line: line,
            readerLine: ReaderLine.fromJson(line),
            title: title,
          ),
      ],
    );
  }
}

class _LineView extends StatelessWidget {
  final Map<String, dynamic> line;
  final ReaderLine readerLine;
  final String title;

  const _LineView({
    required this.line,
    required this.readerLine,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final arabic = line['textArabic'] as String? ?? '';
    final urdu = line['textUrdu'] as String? ?? '';
    final farsi = line['textFarsi'] as String? ?? '';
    final english = line['textEnglish'] as String? ?? '';
    final transliteration = line['transliteration'] as String? ?? '';

    final number = line['number'] as int? ?? readerLine.number;

    return ReaderLineHighlight(
      lineNumber: number,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                '$number',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.volume_up_outlined),
                tooltip: 'Read this line',
                onPressed: () => ReaderAudioService.instance.playSingle(
                  title: title,
                  line: readerLine,
                ),
              ),
            ],
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
