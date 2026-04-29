import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahId;

  const SurahDetailScreen({required this.surahId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      appBar: AppBar(
        title: const Text('Al-Fatiha'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'السورة الفاتحة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'The Opener - 7 Ayahs',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...[1, 2, 3, 4, 5, 6, 7].map((ayah) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AyahCard(
                ayahNumber: ayah,
                arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                transliteration: 'Bismillah ar-Rahman ar-Rahim',
                englishTranslation:
                    'In the name of Allah, the Most Gracious, the Most Merciful',
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AyahCard extends StatelessWidget {
  final int ayahNumber;
  final String arabicText;
  final String transliteration;
  final String englishTranslation;

  const _AyahCard({
    required this.ayahNumber,
    required this.arabicText,
    required this.transliteration,
    required this.englishTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD4A574).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Ayah $ayahNumber',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4A574),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              arabicText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 20,
                height: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              transliteration,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              englishTranslation,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AyahActionButton(
                  icon: Icons.play_circle_outlined,
                  label: 'Listen',
                  onTap: () {},
                ),
                _AyahActionButton(
                  icon: Icons.bookmark_border,
                  label: 'Bookmark',
                  onTap: () {},
                ),
                _AyahActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AyahActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AyahActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD4A574), size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD4A574),
            ),
          ),
        ],
      ),
    );
  }
}
