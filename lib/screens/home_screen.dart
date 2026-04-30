import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/masoomeen_shrines.dart';
import '../services/prayer_times_service.dart';
import '../widgets/app_chrome.dart';
import '../widgets/sawab_ticker_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: hidayatGreen,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  expandedHeight: 240,
                  collapsedHeight: 0,
                  toolbarHeight: 0,
                  floating: false,
                  pinned: true,
                  backgroundColor: hidayatGreen,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: hidayatGreen,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _MasoomeenHeroBackground(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SawabTickerBar(),
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
            if (statusBarHeight > 0)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: statusBarHeight,
                    color: hidayatGreen,
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
      ),
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
    final features = [
      _FeatureAction(
        icon: Icons.menu_book_rounded,
        label: 'Quran',
        subtitle: 'Tilawat & Surahs',
        colors: const [Color(0xFF0F766E), Color(0xFF22C55E)],
        onTap: () => context.go('/quran'),
      ),
      _FeatureAction(
        icon: Icons.favorite_rounded,
        label: 'Duas',
        subtitle: 'Daily duas',
        colors: const [Color(0xFF9D174D), Color(0xFFFB7185)],
        onTap: () => context.go('/duas'),
      ),
      _FeatureAction(
        icon: Icons.explore_rounded,
        label: 'Qibla',
        subtitle: 'Direction finder',
        colors: const [Color(0xFF1D4ED8), Color(0xFF38BDF8)],
        onTap: () => context.go('/qibla'),
      ),
      _FeatureAction(
        icon: Icons.location_on_rounded,
        label: 'Ziyaraat',
        subtitle: 'Sacred readings',
        colors: const [Color(0xFF7C2D12), Color(0xFFF59E0B)],
        onTap: () => context.go('/ziyaraat'),
      ),
      _FeatureAction(
        icon: Icons.live_tv_rounded,
        label: 'Live',
        subtitle: 'Live ziyaraat',
        colors: const [Color(0xFF6D28D9), Color(0xFFA78BFA)],
        onTap: () => context.go('/live-ziyaraat'),
      ),
      _FeatureAction(
        icon: Icons.radio_button_checked_rounded,
        label: 'Tasbeeh',
        subtitle: 'Digital counter',
        colors: const [Color(0xFF166534), Color(0xFF84CC16)],
        onTap: () => context.go('/tasbeeh'),
      ),
      _FeatureAction(
        icon: Icons.schedule_rounded,
        label: 'Namaz',
        subtitle: 'Prayer timings',
        colors: const [Color(0xFF334155), Color(0xFF06B6D4)],
        onTap: () => context.go('/prayer-times'),
      ),
      _FeatureAction(
        icon: Icons.auto_stories_rounded,
        label: 'Books',
        subtitle: 'Islamic library',
        colors: const [Color(0xFF92400E), Color(0xFFFBBF24)],
        onTap: () => context.go('/books'),
      ),
      _FeatureAction(
        icon: Icons.volunteer_activism_rounded,
        label: 'Isal-e-Sawab',
        subtitle: 'Marhoomeen names',
        colors: const [Color(0xFF115E59), Color(0xFFD4A574)],
        onTap: () => context.push('/isal-e-sawab'),
      ),
      _FeatureAction(
        icon: Icons.event_available_rounded,
        label: 'Events',
        subtitle: 'Islamic dates',
        colors: const [Color(0xFF7F1D1D), Color(0xFFF97316)],
        onTap: () => context.go('/events'),
      ),
      _FeatureAction(
        icon: Icons.bookmark_rounded,
        label: 'Bookmarks',
        subtitle: 'Saved items',
        colors: const [Color(0xFF3730A3), Color(0xFF818CF8)],
        onTap: () => context.go('/bookmarks'),
      ),
      _FeatureAction(
        icon: Icons.admin_panel_settings_rounded,
        label: 'Admin',
        subtitle: 'Manage content',
        colors: const [Color(0xFF1F2937), Color(0xFF64748B)],
        onTap: () => context.go('/admin'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'All Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              'Explore',
              style: TextStyle(
                color: Color(0xFF1BA098),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 112,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return _FeatureButton(action: features[index]);
          },
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
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _goToSlide(_index + 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goToSlide(int index) {
    if (!mounted) return;
    setState(() => _index = index % masoomeenShrines.length);
  }

  void _handleSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 160) return;
    if (velocity < 0) {
      _goToSlide(_index + 1);
    } else {
      _goToSlide(_index - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = masoomeenShrines[_index];

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => context.push('/shrine-view/${slide.id}'),
          onHorizontalDragEnd: _handleSwipe,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 720),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              final scale = Tween<double>(begin: 1.03, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: scale, child: child),
              );
            },
            child: Hero(
              key: ValueKey(slide.id),
              tag: 'shrine_${slide.id}',
              child: Image.asset(
                slide.assetPath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, __, ___) => Container(
                  color: hidayatGreen,
                  child: const Icon(
                    Icons.mosque,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: DecoratedBox(
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
                    _HeroActionChip(
                      icon: Icons.view_in_ar,
                      label: '3D View',
                      onTap: () => context.push('/shrine-view/${slide.id}'),
                    ),
                    const SizedBox(width: 8),
                    _HeroActionChip(
                      icon: Icons.live_tv,
                      label: 'Live Ziyaraat',
                      onTap: () => context.go('/live-ziyaraat'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeroActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: hidayatTeal,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 15),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureAction {
  final IconData icon;
  final String label;
  final String subtitle;
  final List<Color> colors;
  final VoidCallback onTap;

  const _FeatureAction({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.colors,
    required this.onTap,
  });
}

class _FeatureButton extends StatelessWidget {
  final _FeatureAction action;

  const _FeatureButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 0,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: action.colors.last.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: action.colors.first.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -24,
                top: 12,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Container(
                    width: 84,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: action.colors.last.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _AnimatedFeatureIcon(action: action),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            action.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF172D27),
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            action.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              height: 1.15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: action.colors.first.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedFeatureIcon extends StatefulWidget {
  final _FeatureAction action;

  const _AnimatedFeatureIcon({required this.action});

  @override
  State<_AnimatedFeatureIcon> createState() => _AnimatedFeatureIconState();
}

class _AnimatedFeatureIconState extends State<_AnimatedFeatureIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final pulse = 0.92 +
              (_controller.value < 0.5
                  ? _controller.value * 0.16
                  : (1 - _controller.value) * 0.16);

          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _controller.value * 6.28318,
                child: CustomPaint(
                  size: const Size(52, 52),
                  painter: _FeatureOrbitPainter(colors: widget.action.colors),
                ),
              ),
              Transform.scale(
                scale: pulse,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: widget.action.colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            widget.action.colors.last.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.action.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FeatureOrbitPainter extends CustomPainter {
  final List<Color> colors;

  const _FeatureOrbitPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          colors.first.withValues(alpha: 0),
          colors.last.withValues(alpha: 0.52),
          colors.first.withValues(alpha: 0),
        ],
      ).createShader(rect);

    final arcRect = rect.deflate(4);
    canvas.drawArc(arcRect, -0.5, 4.4, false, stroke);

    final sparkPaint = Paint()
      ..color = colors.last.withValues(alpha: 0.72)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final sparkCenter = Offset(size.width * 0.82, size.height * 0.2);
    canvas.drawLine(
      sparkCenter.translate(-3, 0),
      sparkCenter.translate(3, 0),
      sparkPaint,
    );
    canvas.drawLine(
      sparkCenter.translate(0, -3),
      sparkCenter.translate(0, 3),
      sparkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FeatureOrbitPainter oldDelegate) {
    return oldDelegate.colors != colors;
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
