import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/app_chrome.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  Future<List<Map<String, dynamic>>> _loadSurahs() async {
    final jsonString =
        await rootBundle.loadString('assets/json/quran/quran_surahs.json');
    return List<Map<String, dynamic>>.from(json.decode(jsonString) as List);
  }

  Future<List<Map<String, dynamic>>> _loadAyahs() async {
    final jsonString =
        await rootBundle.loadString('assets/json/quran/quran_ayahs.json');
    return List<Map<String, dynamic>>.from(json.decode(jsonString) as List);
  }

  Future<void> _readSurah(Map<String, dynamic> surah) async {
    final number = surah['surahNumber'] as int;
    final jsonString = await rootBundle.loadString(
      'assets/json/quran/surahs/surah_$number.json',
    );
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final ayahs = List<Map<String, dynamic>>.from(data['ayahs'] as List? ?? []);
    await ReaderAudioService.instance.playLines(
      title: data['nameEnglish'] as String? ?? surah['nameEnglish'] as String,
      lines: ayahs.map(ReaderLine.fromJson).toList(),
    );
  }

  Future<void> _readAyah(
    Map<String, dynamic> ayah,
    Map<String, dynamic> surah,
  ) async {
    await ReaderAudioService.instance.playSingle(
      title: '${surah['nameEnglish']} ${ayah['ayahNumber']}',
      line: ReaderLine.fromJson(ayah),
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
      backgroundColor: const Color(0xFFFBF8F3),
      appBar: hidayatAppBar(context, title: 'Quran'),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 1),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([_loadSurahs(), _loadAyahs()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load Quran: ${snapshot.error}'));
          }

          final data = snapshot.data ?? const [];
          final allSurahs =
              data.isNotEmpty ? data[0] as List<Map<String, dynamic>> : [];
          final allAyahs =
              data.length > 1 ? data[1] as List<Map<String, dynamic>> : [];
          final surahsByNumber = {
            for (final surah in allSurahs) surah['surahNumber'] as int: surah,
          };
          final query = _query.toLowerCase();
          final surahs = allSurahs.where((surah) {
            final searchText = [
              surah['nameArabic'],
              surah['nameEnglish'],
              surah['nameUrdu'],
              surah['nameFarsi'],
              surah['transliteration'],
              surah['surahNumber'].toString(),
            ].join(' ').toLowerCase();
            return query.isEmpty || searchText.contains(query);
          }).toList();
          final ayahResults = query.isEmpty
              ? <Map<String, dynamic>>[]
              : allAyahs
                  .where((ayah) {
                    final surah = surahsByNumber[ayah['surahNumber']];
                    final searchText = [
                      ayah['id'],
                      ayah['textArabic'],
                      ayah['textEnglish'],
                      ayah['textUrdu'],
                      ayah['textFarsi'],
                      ayah['transliteration'],
                      surah?['nameArabic'],
                      surah?['nameEnglish'],
                      surah?['nameUrdu'],
                      surah?['nameFarsi'],
                    ].join(' ').toLowerCase();
                    return searchText.contains(query);
                  })
                  .take(80)
                  .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Surah',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _query = value.trim()),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (query.isNotEmpty && ayahResults.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Ayah Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                for (final ayah in ayahResults)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _AyahSearchCard(
                      ayah: ayah,
                      surah: surahsByNumber[ayah['surahNumber']]!,
                      onPlay: () => _readAyah(
                        ayah,
                        surahsByNumber[ayah['surahNumber']]!,
                      ),
                      onTap: () => context.go('/surah/${ayah['surahNumber']}'),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
              if (surahs.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    query.isEmpty ? 'All Surahs' : 'Surah Results',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              for (final surah in surahs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _SurahCard(
                    surah: surah,
                    onPlay: () => _readSurah(surah),
                    onTap: () => context.go('/surah/${surah['surahNumber']}'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AyahSearchCard extends StatelessWidget {
  final Map<String, dynamic> ayah;
  final Map<String, dynamic> surah;
  final VoidCallback onPlay;
  final VoidCallback onTap;

  const _AyahSearchCard({
    required this.ayah,
    required this.surah,
    required this.onPlay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text('${surah['nameEnglish']} ${ayah['ayahNumber']}'),
        subtitle: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            ayah['textArabic'] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, height: 1.6),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              tooltip: 'Read aloud',
              onPressed: onPlay,
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _SurahCard extends StatelessWidget {
  final Map<String, dynamic> surah;
  final VoidCallback onPlay;
  final VoidCallback onTap;

  const _SurahCard({
    required this.surah,
    required this.onPlay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final number = surah['surahNumber'] as int;
    final ayahs = surah['totalAyahs'] as int;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFD4A574).withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Color(0xFFD4A574),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          surah['nameEnglish'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${surah['revelationType']} - $ayahs ayahs'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 82),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  surah['nameArabic'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              tooltip: 'Read aloud',
              onPressed: onPlay,
            ),
          ],
        ),
      ),
    );
  }
}
