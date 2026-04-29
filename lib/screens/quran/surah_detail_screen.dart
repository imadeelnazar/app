import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahId;

  const SurahDetailScreen({super.key, required this.surahId});

  Future<Map<String, dynamic>> _loadSurah() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/quran/surahs/surah_$surahId.json',
    );
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadSurah(),
      builder: (context, snapshot) {
        final title = snapshot.data?['nameEnglish'] as String? ?? 'Surah';

        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F3),
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
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
      return Center(child: Text('Unable to load Surah: ${snapshot.error}'));
    }

    final surah = snapshot.data ?? {};
    final ayahs =
        List<Map<String, dynamic>>.from(surah['ayahs'] as List? ?? []);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    surah['nameArabic'] as String? ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${surah['nameEnglish']} - ${surah['totalAyahs']} ayahs',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final ayah in ayahs)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _AyahCard(ayah: ayah),
          ),
      ],
    );
  }
}

class _AyahCard extends StatelessWidget {
  final Map<String, dynamic> ayah;

  const _AyahCard({required this.ayah});

  @override
  Widget build(BuildContext context) {
    final arabic = ayah['textArabic'] as String? ?? '';
    final english = ayah['textEnglish'] as String? ?? '';
    final urdu = ayah['textUrdu'] as String? ?? '';
    final farsi = ayah['textFarsi'] as String? ?? '';
    final transliteration = ayah['transliteration'] as String? ?? '';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Chip(
                  label: Text('Ayah ${ayah['ayahNumber']}'),
                  visualDensity: VisualDensity.compact,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  tooltip: 'Listen',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  tooltip: 'Bookmark',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                arabic,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 24,
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (urdu.isNotEmpty) ...[
              const SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(urdu),
              ),
            ],
            if (farsi.isNotEmpty) ...[
              const SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(farsi),
              ),
            ],
            if (english.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(english),
            ],
            if (transliteration.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                transliteration,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 8),
            Text(
              'Juz ${ayah['juz']} - Hizb ${ayah['hizb']} - Page ${ayah['page']}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
