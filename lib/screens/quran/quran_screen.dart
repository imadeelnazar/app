import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      appBar: AppBar(
        title: const Text('Quran'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadSurahs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load Quran: ${snapshot.error}'));
          }

          final query = _query.toLowerCase();
          final surahs = (snapshot.data ?? []).where((surah) {
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
              for (final surah in surahs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _SurahCard(
                    surah: surah,
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

class _SurahCard extends StatelessWidget {
  final Map<String, dynamic> surah;
  final VoidCallback onTap;

  const _SurahCard({required this.surah, required this.onTap});

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
        trailing: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            surah['nameArabic'] as String,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
