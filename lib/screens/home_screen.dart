import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1BA098),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1BA098),
                      const Color(0xFF0F8A82),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/mosque_pattern.png'),
                    opacity: 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Assalamu Alaikum',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome back to Hidayat',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PrayerTimeCard(),
                  const SizedBox(height: 24),
                  _QuickActionsSection(),
                  const SizedBox(height: 24),
                  _NextPrayerSection(),
                  const SizedBox(height: 24),
                  const Text(
                    'Daily Dua',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _DailyDuaCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'Continue Reading',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ContinueReadingCard(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _PrayerTimeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1BA098), Color(0xFFD4A574)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Next Prayer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '2h 30min',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Dhuhr',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              '12:45 PM',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _PrayerMiniCard(name: 'Fajr', time: '05:30'),
                _PrayerMiniCard(name: 'Asr', time: '04:15'),
                _PrayerMiniCard(name: 'Maghrib', time: '07:30'),
                _PrayerMiniCard(name: 'Isha', time: '09:00'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerMiniCard extends StatelessWidget {
  final String name;
  final String time;

  const _PrayerMiniCard({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Features',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _FeatureButton(
              icon: Icons.menu_book,
              label: 'Quran',
              onTap: () => context.go('/quran'),
            ),
            _FeatureButton(
              icon: Icons.favorite,
              label: 'Duas',
              onTap: () => context.go('/duas'),
            ),
            _FeatureButton(
              icon: Icons.compass_calibration,
              label: 'Qibla',
              onTap: () => context.go('/qibla'),
            ),
            _FeatureButton(
              icon: Icons.location_on,
              label: 'Ziyaraat',
              onTap: () => context.go('/ziyaraat'),
            ),
            _FeatureButton(
              icon: Icons.more_horiz,
              label: 'More',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF1BA098),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _NextPrayerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFA500).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wb_sunny,
              color: Color(0xFFFFA500),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Next Prayer: Dhuhr',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'in 2 hours 30 minutes',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFFFFA500),
          ),
        ],
      ),
    );
  }
}

class _DailyDuaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dua Kumail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'اللَّهُمَّ إِنِّي أَسْأَلُكَ بِرَحْمَتِكَ',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18, height: 1.8),
            ),
            const SizedBox(height: 12),
            const Text(
              'O Allah, I ask You by Your mercy that encompasses all things',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.play_circle_filled,
                  label: 'Listen',
                  onTap: () {},
                ),
                _ActionButton(
                  icon: Icons.bookmark_border,
                  label: 'Bookmark',
                  onTap: () {},
                ),
                _ActionButton(
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
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
          Icon(icon, color: const Color(0xFF1BA098), size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1BA098),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueReadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFD4A574).withOpacity(0.1),
              const Color(0xFF1BA098).withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4A574), Color(0xFF1BA098)],
                ),
              ),
              child: const Icon(Icons.menu_book, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Surah Al-Fatiha',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ayah 1 of 7',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF1BA098),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1BA098),
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
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
