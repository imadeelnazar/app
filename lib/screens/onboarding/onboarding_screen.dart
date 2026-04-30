import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/audio_player_service.dart';

const String onboardingSeenKey = 'hidayat_onboarding_seen';
const String onboardingTrackAsset = 'assets/audio/splash_hussain_nijaat.mp3';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with WidgetsBindingObserver {
  final PageController _controller = PageController();
  int _index = 0;
  bool _trackActive = false;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTrack();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTrack();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    _finishing = true;
    await _stopTrack();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingSeenKey, true);
    if (!mounted) return;
    context.go('/opening');
  }

  Future<void> _startTrack() async {
    if (_trackActive || _finishing) return;
    _trackActive = true;
    await AudioPlayerService().playAssetLooping(onboardingTrackAsset);
  }

  Future<void> _stopTrack() async {
    if (!_trackActive) return;
    _trackActive = false;
    await AudioPlayerService().stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _startTrack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _stopTrack();
        break;
    }
  }

  void _next() {
    if (_index == _pages.length - 1) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: TextButton(
                  onPressed: _finish,
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final currentPage = _controller.hasClients &&
                              _controller.position.haveDimensions
                          ? _controller.page ?? _index.toDouble()
                          : _index.toDouble();
                      final distance = (currentPage - index).abs().clamp(0, 1);
                      final opacity = 1 - (distance * 0.72);
                      final scale = 1.03 - (distance * 0.08);

                      return Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: child,
                        ),
                      );
                    },
                    child: _OnboardingPageView(data: _pages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
              child: Row(
                children: [
                  const Spacer(),
                  FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1BA098),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(isLast ? 'Start Isal-e-Sawab' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageView extends StatelessWidget {
  final _OnboardingPage data;

  const _OnboardingPageView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: _OnboardingVisual(data: data),
            ),
          ),
          Text(
            data.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              height: 1.08,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.description,
            style: const TextStyle(
              color: Color(0xFF9FA4AA),
              fontSize: 15,
              height: 1.38,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _OnboardingVisual extends StatelessWidget {
  final _OnboardingPage data;

  const _OnboardingVisual({required this.data});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _OnboardingGlowPainter(colors: data.colors),
            ),
          ),
          Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  data.colors.last.withValues(alpha: 0.85),
                  data.colors.first.withValues(alpha: 0.28),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: data.colors.last.withValues(alpha: 0.35),
                  blurRadius: 38,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Icon(data.icon, size: 76, color: Colors.white),
          ),
          if (data.arabicLabel != null)
            Positioned(
              top: 28,
              child: Text(
                data.arabicLabel!,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _OnboardingGlowPainter extends CustomPainter {
  final List<Color> colors;

  const _OnboardingGlowPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final horizonRect = Rect.fromLTWH(
      -size.width * 0.12,
      size.height * 0.38,
      size.width * 1.24,
      size.height * 0.58,
    );
    final horizonPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colors.first.withValues(alpha: 0.06),
          colors.last.withValues(alpha: 0.7),
          colors.first.withValues(alpha: 0.15),
        ],
      ).createShader(rect);

    canvas.drawOval(horizonRect, horizonPaint);

    final circlePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          colors.last.withValues(alpha: 0.26),
          colors.first.withValues(alpha: 0.16),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.36, circlePaint);
  }

  @override
  bool shouldRepaint(covariant _OnboardingGlowPainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}

class _OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> colors;
  final String? arabicLabel;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.colors,
    this.arabicLabel,
  });
}

const List<_OnboardingPage> _pages = [
  _OnboardingPage(
    title: 'Isal-e-Sawab',
    description:
        'Read Quran, Surah Fatiha, duas, and ziyaraat with niyyat for your marhoomeen and loved ones.',
    icon: Icons.volunteer_activism,
    colors: [Color(0xFF00324A), Color(0xFF16C7E8)],
    arabicLabel: 'ثواب',
  ),
  _OnboardingPage(
    title: 'Daily Ibadat',
    description:
        'Keep namaz timings, Shia azan alerts, Qibla direction, tasbeeh, and daily duas close to your routine.',
    icon: Icons.mosque,
    colors: [Color(0xFF3B0B2F), Color(0xFFE91E9D)],
    arabicLabel: 'عبادت',
  ),
  _OnboardingPage(
    title: 'Ziyaraat & Ilm',
    description:
        'Explore Quran, books, duas, live ziyaraat, Islamic events, and offline reading in one peaceful place.',
    icon: Icons.menu_book,
    colors: [Color(0xFF002A45), Color(0xFF1BA098)],
    arabicLabel: 'زيارة',
  ),
];
