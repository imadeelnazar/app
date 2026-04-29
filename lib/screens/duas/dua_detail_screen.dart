import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      return Center(child: Text('Unable to load dua: ${snapshot.error}'));
    }

    final dua = snapshot.data ?? {};
    final lines = List<Map<String, dynamic>>.from(dua['lines'] as List? ?? []);
    final titleArabic = dua['titleArabic'] as String? ?? '';

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
      itemCount: lines.length,
      itemBuilder: (context, index) => _DuaLineView(line: lines[index]),
    );
  }
}

class _DuaLineView extends StatelessWidget {
  final Map<String, dynamic> line;

  const _DuaLineView({required this.line});

  @override
  Widget build(BuildContext context) {
    final arabic = line['textArabic'] as String? ?? '';
    final urdu = line['textUrdu'] as String? ?? '';
    final farsi = line['textFarsi'] as String? ?? '';
    final english = line['textEnglish'] as String? ?? '';
    final transliteration = line['transliteration'] as String? ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
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
