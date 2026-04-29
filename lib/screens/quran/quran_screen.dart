import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      appBar: AppBar(
        title: const Text('QURAN'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4A574).withOpacity(0.3),
                    const Color(0xFF1BA098).withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Last Read',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4A574),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Al-Fatiha',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'The Opener - 7 Ayahs',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Al Quran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _FilterTab(label: 'Surah', isActive: true),
              const SizedBox(width: 8),
              _FilterTab(label: 'Juz', isActive: false),
              const SizedBox(width: 8),
              _FilterTab(label: 'Page', isActive: false),
            ],
          ),
          const SizedBox(height: 12),
          ...[
            ('Al Fatiha', '7 Ayahs', '1'),
            ('Al Baqarah', '286 Ayahs', '2'),
            ('Ali Imran', '200 Ayahs', '3'),
            ('An Nisa', '176 Ayahs', '4'),
            ('Al Maidah', '120 Ayahs', '5'),
          ].map((surah) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => context.go('/surah/${surah.$3}'),
                child: _SurahCard(
                  name: surah.$1,
                  ayahs: surah.$2,
                  number: surah.$3,
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFD4A574),
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Quran',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Qibla',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Tasbih',
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterTab({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFD4A574) : Colors.white,
        border: Border.all(
          color: isActive ? const Color(0xFFD4A574) : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

class _SurahCard extends StatelessWidget {
  final String name;
  final String ayahs;
  final String number;

  const _SurahCard({
    required this.name,
    required this.ayahs,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4A574), Color(0xFF1BA098)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ayahs,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
