import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_chrome.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/reader_audio_bar.dart';

class ZiyarahDetailScreen extends StatelessWidget {
  final String ziyarahId;

  const ZiyarahDetailScreen({super.key, required this.ziyarahId});

  Future<Map<String, dynamic>> _loadZiyarah() async {
    final indexString =
        await rootBundle.loadString('assets/json/ziyaraat/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final item = items.firstWhere(
      (ziyarah) => ziyarah['id'] == ziyarahId,
      orElse: () => throw StateError('Unknown Ziyarah: $ziyarahId'),
    );
    final jsonString =
        await rootBundle.loadString('assets/json/ziyaraat/${item['file']}');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadZiyarah(),
      builder: (context, snapshot) {
        final title = snapshot.data?['title'] as String? ?? 'Ziyarah';

        return Scaffold(
          appBar: hidayatAppBar(context, title: title),
          bottomNavigationBar: const HidayatBottomNav(currentIndex: 4),
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
      return Center(child: Text('Unable to load Ziyarah: ${snapshot.error}'));
    }

    final ziyarah = snapshot.data ?? {};
    final lines =
        List<Map<String, dynamic>>.from(ziyarah['lines'] as List? ?? []);
    final readerLines = lines.map(ReaderLine.fromJson).toList();
    final titleArabic = ziyarah['titleArabic'] as String? ?? '';
    final title = ziyarah['title'] as String? ?? 'Ziyarah';

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
          Text(ziyarah['description'] as String? ?? ''),
          const SizedBox(height: 12),
          const Text('Licensed text has not been added for this Ziyarah yet.'),
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
        return _ZiyarahLine(
          line: line,
          readerLine: readerLine,
          title: title,
        );
      },
    );
  }
}

class _ZiyarahLine extends StatelessWidget {
  final Map<String, dynamic> line;
  final ReaderLine readerLine;
  final String title;

  const _ZiyarahLine({
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
              Text('$number', style: Theme.of(context).textTheme.labelMedium),
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
            Text(transliteration, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
