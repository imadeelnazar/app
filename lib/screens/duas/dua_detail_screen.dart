import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_chrome.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/reader_audio_bar.dart';

class DuaDetailScreen extends StatelessWidget {
  final String duaId;

  const DuaDetailScreen({super.key, required this.duaId});

  Future<Map<String, dynamic>> _loadDua() async {
    final indexString =
        await rootBundle.loadString('assets/json/duas/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final item = items.firstWhere(
      (dua) => dua['id'] == duaId,
      orElse: () => throw StateError('Unknown dua: $duaId'),
    );
    final duaString =
        await rootBundle.loadString('assets/json/duas/${item['file']}');
    return json.decode(duaString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadDua(),
      builder: (context, snapshot) {
        final title = snapshot.data?['title'] as String? ?? 'Dua';

        return Scaffold(
          appBar: haqaiqAppBar(context, title: title),
          bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 2),
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
      return Center(child: Text('Unable to load dua: ${snapshot.error}'));
    }

    final dua = snapshot.data ?? {};
    final lines = List<Map<String, dynamic>>.from(dua['lines'] as List? ?? []);
    final readerLines = lines.map(ReaderLine.fromJson).toList();
    final titleArabic = dua['titleArabic'] as String? ?? '';
    final title = dua['title'] as String? ?? 'Dua';

    if (lines.isEmpty) {
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
          Text(dua['description'] as String? ?? ''),
          const SizedBox(height: 12),
          const Text('Licensed text has not been added for this dua yet.'),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lines.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ReaderAudioBar(title: title, lines: readerLines);
        }
        final line = lines[index - 1];
        final readerLine = readerLines[index - 1];
        return _DuaLineView(line: line, readerLine: readerLine, title: title);
      },
    );
  }
}

class _DuaLineView extends StatelessWidget {
  final Map<String, dynamic> line;
  final ReaderLine readerLine;
  final String title;

  const _DuaLineView({
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
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
