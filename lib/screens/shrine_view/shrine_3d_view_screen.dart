import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/masoomeen_shrines.dart';

class Shrine3DViewScreen extends StatefulWidget {
  final String shrineId;

  const Shrine3DViewScreen({super.key, required this.shrineId});

  @override
  State<Shrine3DViewScreen> createState() => _Shrine3DViewScreenState();
}

class _Shrine3DViewScreenState extends State<Shrine3DViewScreen> {
  late final PageController _pageController;
  late int _index;
  Offset _tilt = Offset.zero;

  @override
  void initState() {
    super.initState();
    _index = shrineIndexById(widget.shrineId);
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateTilt(Offset position, Size size) {
    final dx = ((position.dx / size.width) - 0.5).clamp(-0.5, 0.5);
    final dy = ((position.dy / size.height) - 0.5).clamp(-0.5, 0.5);
    setState(() => _tilt = Offset(dx.toDouble(), dy.toDouble()));
  }

  void _resetTilt() {
    if (_tilt == Offset.zero) return;
    setState(() => _tilt = Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final shrine = masoomeenShrines[_index];

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: Text(
            shrine.title,
            key: ValueKey(shrine.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: masoomeenShrines.length,
                onPageChanged: (index) {
                  setState(() {
                    _index = index;
                    _tilt = Offset.zero;
                  });
                },
                itemBuilder: (context, index) {
                  final item = masoomeenShrines[index];
                  return _ShrineImageStage(
                    shrine: item,
                    tilt: index == _index ? _tilt : Offset.zero,
                    onPointerMove: (position) => _updateTilt(position, size),
                    onPointerUp: _resetTilt,
                  );
                },
              ),
              IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.78),
                      ],
                      stops: const [0, 0.42, 1],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: Text(
                            shrine.title,
                            key: ValueKey('${shrine.id}_title'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: Text(
                            shrine.location,
                            key: ValueKey('${shrine.id}_location'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Icon(
                              Icons.swipe,
                              color: Colors.white70,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Swipe, pinch, and move finger for 3D view',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '${_index + 1}/${masoomeenShrines.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class _ShrineImageStage extends StatelessWidget {
  final MasoomeenShrine shrine;
  final Offset tilt;
  final ValueChanged<Offset> onPointerMove;
  final VoidCallback onPointerUp;

  const _ShrineImageStage({
    required this.shrine,
    required this.tilt,
    required this.onPointerMove,
    required this.onPointerUp,
  });

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0014)
      ..rotateX(tilt.dy * math.pi * 0.09)
      ..rotateY(-tilt.dx * math.pi * 0.09);

    return Listener(
      onPointerMove: (event) => onPointerMove(event.localPosition),
      onPointerDown: (event) => onPointerMove(event.localPosition),
      onPointerCancel: (_) => onPointerUp(),
      onPointerUp: (_) => onPointerUp(),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          transform: transform,
          child: Transform.translate(
            offset: Offset(tilt.dx * 18, tilt.dy * 18),
            child: Hero(
              tag: 'shrine_${shrine.id}',
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 3.6,
                clipBehavior: Clip.none,
                child: Image.asset(
                  shrine.assetPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (_, __, ___) => const _ImageFallback(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF10251F),
      child: Center(
        child: Icon(Icons.mosque, color: Colors.white, size: 72),
      ),
    );
  }
}
