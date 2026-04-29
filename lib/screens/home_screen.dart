import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/prayer_times_service.dart';
import '../widgets/app_chrome.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 240,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF1BA098),
            flexibleSpace: FlexibleSpaceBar(
              background: _MasoomeenHeroBackground(),
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
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
    );
  }
}

class _PrayerTimeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PrayerTimesViewData>(
      future: PrayerTimesService().fetchPrayerTimesView(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        return _PrayerTimeCardBody(
          nextPrayer: data?.nextPrayerName ?? (isLoading ? 'Loading' : 'Open'),
          nextTime:
              data?.nextPrayerTime ?? (isLoading ? '--:--' : 'Prayer Times'),
          remaining: data?.nextPrayerRemaining,
          fajr: data?.prayerTime.fajr ?? '--:--',
          dhuhr: data?.prayerTime.dhuhr ?? '--:--',
          asr: data?.prayerTime.asr ?? '--:--',
          maghrib: data?.prayerTime.maghrib ?? '--:--',
          isha: data?.prayerTime.isha ?? '--:--',
        );
      },
    );
  }
}

class _PrayerTimeCardBody extends StatelessWidget {
  final String nextPrayer;
  final String nextTime;
  final Duration? remaining;
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  const _PrayerTimeCardBody({
    required this.nextPrayer,
    required this.nextTime,
    required this.remaining,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _PrayerVisualTheme.forPrayer(nextPrayer);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: theme.colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -22,
              top: -28,
              child: Icon(
                theme.icon,
                size: 128,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(theme.icon, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        const Text(
                          'Next Prayer',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatRemaining(remaining),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  nextPrayer,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  nextTime,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  theme.caption,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _PrayerMiniCard(name: 'Fajr', time: fajr),
                    _PrayerMiniCard(name: 'Dhuhr', time: dhuhr),
                    _PrayerMiniCard(name: 'Asr', time: asr),
                    _PrayerMiniCard(name: 'Maghrib', time: maghrib),
                    _PrayerMiniCard(name: 'Isha', time: isha),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatRemaining(Duration? duration) {
    if (duration == null) return 'Today';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours <= 0) return '${minutes}min';
    return '${hours}h ${minutes}m';
  }
}

class _PrayerVisualTheme {
  final List<Color> colors;
  final IconData icon;
  final String caption;

  const _PrayerVisualTheme({
    required this.colors,
    required this.icon,
    required this.caption,
  });

  factory _PrayerVisualTheme.forPrayer(String prayer) {
    final key = prayer.toLowerCase();
    if (key.contains('fajr')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFF172A4A), Color(0xFF7D8CC4)],
        icon: Icons.wb_twilight,
        caption: 'Quiet dawn atmosphere',
      );
    }
    if (key.contains('sunrise')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFFFF8A3D), Color(0xFFFFD166)],
        icon: Icons.wb_sunny_outlined,
        caption: 'Sunrise glow',
      );
    }
    if (key.contains('dhuhr')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFF0F8A82), Color(0xFF67C7B8)],
        icon: Icons.wb_sunny,
        caption: 'Bright midday prayer',
      );
    }
    if (key.contains('asr')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFFB96D2B), Color(0xFFE0A458)],
        icon: Icons.cloud_outlined,
        caption: 'Soft afternoon light',
      );
    }
    if (key.contains('maghrib')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFF5A2A5D), Color(0xFFD46A6A)],
        icon: Icons.brightness_3,
        caption: 'Sunset prayer time',
      );
    }
    if (key.contains('isha')) {
      return const _PrayerVisualTheme(
        colors: [Color(0xFF101828), Color(0xFF264653)],
        icon: Icons.nights_stay,
        caption: 'Calm night recitation',
      );
    }
    return const _PrayerVisualTheme(
      colors: [Color(0xFF1BA098), Color(0xFFD4A574)],
      icon: Icons.mosque,
      caption: 'Prayer time',
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
            fontSize: 12,
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
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.08,
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
              icon: Icons.live_tv,
              label: 'Live',
              onTap: () => context.go('/live-ziyaraat'),
            ),
            _FeatureButton(
              icon: Icons.event,
              label: 'Events',
              onTap: () => context.go('/events'),
            ),
          ],
        ),
      ],
    );
  }
}

class _MasoomeenHeroBackground extends StatefulWidget {
  const _MasoomeenHeroBackground();

  @override
  State<_MasoomeenHeroBackground> createState() =>
      _MasoomeenHeroBackgroundState();
}

class _MasoomeenHeroBackgroundState extends State<_MasoomeenHeroBackground> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final next = (_index + 1) % _masomeenSlides.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slide = _masomeenSlides[_index];

    return GestureDetector(
      onTap: () => context.go('/live-ziyaraat'),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _index = index),
            itemBuilder: (context, index) {
              final slide = _masomeenSlides[index % _masomeenSlides.length];
              return Image.network(
                slide.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: hidayatGreen,
                  child: const Icon(
                    Icons.mosque,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
              );
            },
            itemCount: _masomeenSlides.length,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.22),
                  Colors.black.withValues(alpha: 0.72),
                ],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 34, 18, 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assalamu Alaikum',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    slide.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    slide.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: hidayatTeal,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.live_tv, color: Colors.white, size: 15),
                            SizedBox(width: 5),
                            Text(
                              'Live Ziyaraat',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              List.generate(_masomeenSlides.length, (dotIndex) {
                            final active = dotIndex == _index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: active ? 16 : 5,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: active
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.42),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MasoomeenSlide {
  final String title;
  final String location;
  final String imageUrl;

  const _MasoomeenSlide({
    required this.title,
    required this.location,
    required this.imageUrl,
  });
}

const String _commons = 'https://commons.wikimedia.org/wiki/Special:FilePath/';
const String _nabawi = '$_commons'
    'Green%20Dome%2C%20Masjid%20Al%20Nabawi.jpg?width=1200';
const String _baqi = '$_commons'
    'Grave%20of%20Ibrahim%20at%20Jannat-ul-Baqi%2C%20Medina.JPG?width=1200';
const String _najaf = '$_commons'
    'Imam%20Ali%20Shrine%20%281%29.jpg?width=1200';
const String _karbala = '$_commons'
    'Imam%20Husayn%20Shrine%202.jpg?width=1200';
const String _mashhad = '$_commons'
    'Imam%20Reza%20shrine.jpg?width=1200';
const String _kadhimiya = '$_commons'
    '%D8%AD%D8%B1%D9%85%20%DA%A9%D8%A7%D8%B8%D9%85%DB%8C%D9%86.jpg?width=1200';
const String _samarra = '$_commons'
    'Al-Askari%20Shrine%20-%20Nov%2015%2C%202018.jpg?width=1200';

const List<_MasoomeenSlide> _masomeenSlides = [
  _MasoomeenSlide(
    title: 'Prophet Muhammad (S.A.W.W)',
    location: 'Masjid al-Nabawi, Madinah',
    imageUrl: _nabawi,
  ),
  _MasoomeenSlide(
    title: 'Janab-e-Fatima Zahra (S.A)',
    location: 'Madinah / Jannat al-Baqi area',
    imageUrl: _baqi,
  ),
  _MasoomeenSlide(
    title: 'Imam Ali (A.S)',
    location: 'Najaf al-Ashraf',
    imageUrl: _najaf,
  ),
  _MasoomeenSlide(
    title: 'Imam Hasan (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    imageUrl: _baqi,
  ),
  _MasoomeenSlide(
    title: 'Imam Hussain (A.S)',
    location: 'Karbala al-Mualla',
    imageUrl: _karbala,
  ),
  _MasoomeenSlide(
    title: 'Imam Sajjad (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    imageUrl: _baqi,
  ),
  _MasoomeenSlide(
    title: 'Imam Baqir (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    imageUrl: _baqi,
  ),
  _MasoomeenSlide(
    title: 'Imam Sadiq (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    imageUrl: _baqi,
  ),
  _MasoomeenSlide(
    title: 'Imam Kazim (A.S)',
    location: 'Kadhimiya, Baghdad',
    imageUrl: _kadhimiya,
  ),
  _MasoomeenSlide(
    title: 'Imam Reza (A.S)',
    location: 'Mashhad, Iran',
    imageUrl: _mashhad,
  ),
  _MasoomeenSlide(
    title: 'Imam Taqi (A.S)',
    location: 'Kadhimiya, Baghdad',
    imageUrl: _kadhimiya,
  ),
  _MasoomeenSlide(
    title: 'Imam Naqi (A.S)',
    location: 'Samarra, Iraq',
    imageUrl: _samarra,
  ),
  _MasoomeenSlide(
    title: 'Imam Hasan Askari (A.S)',
    location: 'Samarra, Iraq',
    imageUrl: _samarra,
  ),
  _MasoomeenSlide(
    title: 'Imam Mahdi (A.S)',
    location: 'Associated holy sites in Samarra',
    imageUrl: _samarra,
  ),
];

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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1BA098),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
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
    return FutureBuilder<PrayerTimesViewData>(
      future: PrayerTimesService().fetchPrayerTimesView(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        return _NextPrayerSectionBody(
          title: data == null
              ? 'Next Prayer'
              : 'Next Prayer: ${data.nextPrayerName}',
          subtitle: data == null
              ? 'Using phone timezone'
              : _formatRemaining(data.nextPrayerRemaining),
        );
      },
    );
  }

  String _formatRemaining(Duration? duration) {
    if (duration == null) return 'Later today';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours <= 0) return 'in $minutes minutes';
    return 'in $hours hours $minutes minutes';
  }
}

class _NextPrayerSectionBody extends StatelessWidget {
  final String title;
  final String subtitle;

  const _NextPrayerSectionBody({
    required this.title,
    required this.subtitle,
  });

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
              color: const Color(0xFFFFA500).withValues(alpha: 0.2),
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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
              const Color(0xFFD4A574).withValues(alpha: 0.1),
              const Color(0xFF1BA098).withValues(alpha: 0.05),
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
