import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Duration openingClipDuration = Duration(seconds: 12);
const String _karbalaAsset = 'assets/images/masoomeen/karbala_imam_hussain.jpg';
const String _arabicSalaam =
    '\u0627\u0644\u0633\u0644\u0627\u0645 \u0639\u0644\u064a\u0643 \u064a\u0627 \u0623\u0628\u0627 \u0639\u0628\u062f \u0627\u0644\u0644\u0647';

class OpeningClipScreen extends StatefulWidget {
  const OpeningClipScreen({super.key});

  @override
  State<OpeningClipScreen> createState() => _OpeningClipScreenState();
}

class _OpeningClipScreenState extends State<OpeningClipScreen>
    with TickerProviderStateMixin {
  late final AnimationController _storyController;
  late final AnimationController _ambientController;

  @override
  void initState() {
    super.initState();
    _storyController = AnimationController(
      vsync: this,
      duration: openingClipDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          context.go('/home');
        }
      });

    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _storyController.forward();
  }

  @override
  void dispose() {
    _storyController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: Listenable.merge([_storyController, _ambientController]),
        builder: (context, _) {
          final story = _storyController.value;
          final ambient = _ambientController.value;

          return Stack(
            fit: StackFit.expand,
            children: [
              _ShrineReveal(progress: story),
              _CinematicShade(progress: story),
              _NoorGlow(progress: story, ambient: ambient),
              _LightRays(progress: story, ambient: ambient),
              CustomPaint(
                painter: _ParticlesPainter(progress: story, drift: ambient),
                size: Size.infinite,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
                  child: Column(
                    children: [
                      const Spacer(),
                      _ArabicMoment(progress: story),
                      const SizedBox(height: 28),
                      _BrandReveal(progress: story),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              _FadeToBlack(progress: story),
            ],
          );
        },
      ),
    );
  }
}

class _ShrineReveal extends StatelessWidget {
  final double progress;

  const _ShrineReveal({required this.progress});

  @override
  Widget build(BuildContext context) {
    final reveal = _easeInterval(progress, 0.16, 0.42);
    final zoom = 1.08 + (_easeInterval(progress, 0.16, 0.92) * 0.15);
    final verticalShift = -18 * _easeInterval(progress, 0.30, 0.88);

    return Opacity(
      opacity: reveal,
      child: Transform.translate(
        offset: Offset(0, verticalShift),
        child: Transform.scale(
          scale: zoom,
          child: Image.asset(
            _karbalaAsset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

class _CinematicShade extends StatelessWidget {
  final double progress;

  const _CinematicShade({required this.progress});

  @override
  Widget build(BuildContext context) {
    final lift = _easeInterval(progress, 0.16, 0.42);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.88 - (lift * 0.20)),
            Colors.black.withValues(alpha: 0.42 - (lift * 0.16)),
            Colors.black.withValues(alpha: 0.94),
          ],
        ),
      ),
    );
  }
}

class _NoorGlow extends StatelessWidget {
  final double progress;
  final double ambient;

  const _NoorGlow({
    required this.progress,
    required this.ambient,
  });

  @override
  Widget build(BuildContext context) {
    final opening = _easeInterval(progress, 0.00, 0.22);
    final reveal = _easeInterval(progress, 0.18, 0.48);
    final pulse = 0.72 + (math.sin(ambient * math.pi * 2) * 0.08);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.18 + reveal * -0.16),
          radius: 0.18 + (opening * 0.62),
          colors: [
            const Color(0xFFD4AF37).withValues(alpha: 0.36 * opening * pulse),
            const Color(0xFFD4AF37).withValues(alpha: 0.14 * opening),
            const Color(0xFF0B3B2E).withValues(alpha: 0.12 * reveal),
            Colors.transparent,
          ],
          stops: const [0, 0.28, 0.55, 1],
        ),
      ),
    );
  }
}

class _LightRays extends StatelessWidget {
  final double progress;
  final double ambient;

  const _LightRays({
    required this.progress,
    required this.ambient,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = _easeInterval(progress, 0.38, 0.66) *
        (1 - _easeInterval(progress, 0.82, 0.98));

    return Opacity(
      opacity: opacity,
      child: CustomPaint(
        painter: _LightRaysPainter(ambient),
        size: Size.infinite,
      ),
    );
  }
}

class _LightRaysPainter extends CustomPainter {
  final double drift;

  const _LightRaysPainter(this.drift);

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width * 0.5, size.height * 0.34);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        colors: [
          Color(0x44D4AF37),
          Color(0x00D4AF37),
        ],
      ).createShader(Offset.zero & size);

    for (var i = 0; i < 7; i++) {
      final spread = -0.52 + (i * 0.17) + math.sin(drift * math.pi * 2) * 0.025;
      final path = Path()
        ..moveTo(origin.dx, origin.dy)
        ..lineTo(
          origin.dx + math.sin(spread) * size.width * 0.56,
          size.height,
        )
        ..lineTo(
          origin.dx + math.sin(spread + 0.08) * size.width * 0.56,
          size.height,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LightRaysPainter oldDelegate) {
    return oldDelegate.drift != drift;
  }
}

class _ParticlesPainter extends CustomPainter {
  final double progress;
  final double drift;

  const _ParticlesPainter({
    required this.progress,
    required this.drift,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final visible = _easeInterval(progress, 0.16, 0.48) *
        (1 - _easeInterval(progress, 0.90, 1.0));
    if (visible <= 0) return;

    final paint = Paint();
    for (var i = 0; i < 34; i++) {
      final seed = i * 37.0;
      final x = ((seed * 13) % 100) / 100;
      final y = ((seed * 29) % 100) / 100;
      final float = (drift + (i * 0.071)) % 1;
      final twinkle = 0.45 + (math.sin((drift * 2 * math.pi) + i) * 0.35);
      final point = Offset(
        size.width * x,
        size.height * ((y + 1 - float * 0.22) % 1),
      );
      paint.color = const Color(0xFFD4AF37)
          .withValues(alpha: visible * (0.10 + twinkle * 0.12));
      canvas.drawCircle(point, 1.2 + (i % 4) * 0.55, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}

class _ArabicMoment extends StatelessWidget {
  final double progress;

  const _ArabicMoment({required this.progress});

  @override
  Widget build(BuildContext context) {
    final fade = _easeInterval(progress, 0.40, 0.60) *
        (1 - _easeInterval(progress, 0.70, 0.82));
    final reveal = _easeInterval(progress, 0.42, 0.68);

    return Opacity(
      opacity: fade,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerRight,
          widthFactor: reveal.clamp(0.001, 1.0),
          child: const Text(
            _arabicSalaam,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Color(0xFFFFE7B6),
              fontSize: 25,
              height: 1.55,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                  color: Color(0xAAD4AF37),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandReveal extends StatelessWidget {
  final double progress;

  const _BrandReveal({required this.progress});

  @override
  Widget build(BuildContext context) {
    final fade = _easeInterval(progress, 0.64, 0.82) *
        (1 - _easeInterval(progress, 0.92, 0.99));
    final scale = 0.94 + (_easeInterval(progress, 0.64, 0.82) * 0.06);

    return Opacity(
      opacity: fade,
      child: Transform.scale(
        scale: scale,
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.82),
                ),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFD4AF37).withValues(alpha: 0.30),
                    const Color(0xFF0B3B2E).withValues(alpha: 0.62),
                    Colors.black.withValues(alpha: 0.15),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.24),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                color: Color(0xFFFFE7B6),
                size: 30,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'HIDAYAT',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                shadows: [
                  Shadow(
                    color: Color(0xAAD4AF37),
                    blurRadius: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Guidance for the Heart',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFFE7B6),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Path to Faith, Knowledge & Peace',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FadeToBlack extends StatelessWidget {
  final double progress;

  const _FadeToBlack({required this.progress});

  @override
  Widget build(BuildContext context) {
    final ending = _easeInterval(progress, 0.90, 1.0);
    final opening = 1 - _easeInterval(progress, 0.00, 0.18);
    final opacity = math.max(opening, ending);

    return IgnorePointer(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: opacity),
      ),
    );
  }
}

double _easeInterval(double value, double begin, double end) {
  if (value <= begin) return 0;
  if (value >= end) return 1;
  final t = ((value - begin) / (end - begin)).clamp(0.0, 1.0);
  return Curves.easeInOutCubic.transform(t);
}
