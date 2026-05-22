import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

import '../../widgets/app_chrome.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  static const double _kaabaLatitude = 21.4225;
  static const double _kaabaLongitude = 39.8262;

  StreamSubscription<CompassEvent>? _compassSubscription;
  StreamSubscription<Position>? _positionSubscription;

  Position? _position;
  double? _heading;
  double? _qiblaBearing;
  double? _distanceKm;
  bool _loadingLocation = true;
  String? _statusMessage;
  String _locationSource = 'Waiting for phone GPS';

  @override
  void initState() {
    super.initState();
    _listenToCompass();
    _loadLocation();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  void _listenToCompass() {
    final events = FlutterCompass.events;
    if (events == null) {
      setState(() {
        _statusMessage = 'Compass sensor is not available on this device.';
      });
      return;
    }

    _compassSubscription = events.listen((event) {
      final heading = event.heading;
      if (heading == null || !mounted) return;
      setState(() => _heading = _normalize360(heading));
    });
  }

  Future<void> _loadLocation() async {
    setState(() {
      _loadingLocation = true;
      _statusMessage = null;
    });

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      setState(() {
        _loadingLocation = false;
        _statusMessage = 'Location permission is required for Qibla direction.';
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _loadingLocation = false;
        _statusMessage =
            'Location permission is permanently denied. Open app settings to allow it.';
      });
      return;
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _loadingLocation = false;
        _statusMessage =
            'Turn on phone Location/GPS. Internet is not required for Qibla.';
      });
      return;
    }

    try {
      final lastKnown = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager:
            defaultTargetPlatform == TargetPlatform.android,
      );
      if (lastKnown != null) {
        _updatePosition(lastKnown, source: 'Offline phone location');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: _offlineLocationSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 12),
        ),
      );
      _updatePosition(position, source: 'Live GPS compass mode');
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: _offlineLocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((position) {
        _updatePosition(position, source: 'Live GPS compass mode');
      });
    } catch (error) {
      if (_position != null) {
        setState(() {
          _loadingLocation = false;
          _statusMessage =
              'Using last phone location. Go outside for a fresh GPS fix.';
        });
        return;
      }

      setState(() {
        _loadingLocation = false;
        _statusMessage =
            'Unable to get GPS location. Internet is not needed, but phone Location/GPS must be enabled.';
      });
    }
  }

  void _updatePosition(Position position, {required String source}) {
    if (!mounted) return;
    setState(() {
      _position = position;
      _qiblaBearing = _calculateBearing(
        position.latitude,
        position.longitude,
      );
      _distanceKm = _calculateDistanceKm(
        position.latitude,
        position.longitude,
      );
      _loadingLocation = false;
      _statusMessage = null;
      _locationSource = source;
    });
  }

  LocationSettings _offlineLocationSettings({
    required LocationAccuracy accuracy,
    int distanceFilter = 0,
    Duration? timeLimit,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 2),
        timeLimit: timeLimit,
      );
    }

    return LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeLimit: timeLimit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final qiblaBearing = _qiblaBearing;
    final heading = _heading;
    final turnAngle = qiblaBearing != null && heading != null
        ? _shortestDelta(qiblaBearing - heading)
        : null;
    final aligned = turnAngle != null && turnAngle.abs() <= 3;

    return Scaffold(
      appBar: haqaiqAppBar(
        context,
        title: 'Qibla Finder',
        actions: [
          IconButton(
            tooltip: 'Refresh location',
            onPressed: _loadLocation,
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
      body: RefreshIndicator(
        onRefresh: _loadLocation,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _QiblaCompassCard(
              heading: heading,
              qiblaBearing: qiblaBearing,
              turnAngle: turnAngle,
              aligned: aligned,
              loading: _loadingLocation,
              statusMessage: _statusMessage,
              locationSource: _locationSource,
              onRetry: _loadLocation,
            ),
            const SizedBox(height: 24),
            const Text(
              'Qibla Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _QiblaInfoCard(
              position: _position,
              qiblaBearing: qiblaBearing,
              distanceKm: _distanceKm,
              heading: heading,
            ),
            const SizedBox(height: 16),
            _QiblaTipCard(aligned: aligned, hasCompass: heading != null),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  double _calculateBearing(double latitude, double longitude) {
    final lat1 = _degreesToRadians(latitude);
    final lat2 = _degreesToRadians(_kaabaLatitude);
    final deltaLng = _degreesToRadians(_kaabaLongitude - longitude);

    final y = math.sin(deltaLng);
    final x =
        math.cos(lat1) * math.tan(lat2) - math.sin(lat1) * math.cos(deltaLng);

    return _normalize360(_radiansToDegrees(math.atan2(y, x)));
  }

  double _calculateDistanceKm(double latitude, double longitude) {
    const earthRadiusKm = 6371.0;
    final dLat = _degreesToRadians(_kaabaLatitude - latitude);
    final dLon = _degreesToRadians(_kaabaLongitude - longitude);
    final lat1 = _degreesToRadians(latitude);
    final lat2 = _degreesToRadians(_kaabaLatitude);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) => degrees * math.pi / 180;
  double _radiansToDegrees(double radians) => radians * 180 / math.pi;
  double _normalize360(double degrees) => (degrees % 360 + 360) % 360;
  double _shortestDelta(double degrees) => (degrees + 540) % 360 - 180;
}

class _QiblaCompassCard extends StatelessWidget {
  final double? heading;
  final double? qiblaBearing;
  final double? turnAngle;
  final bool aligned;
  final bool loading;
  final String? statusMessage;
  final String locationSource;
  final VoidCallback onRetry;

  const _QiblaCompassCard({
    required this.heading,
    required this.qiblaBearing,
    required this.turnAngle,
    required this.aligned,
    required this.loading,
    required this.statusMessage,
    required this.locationSource,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final arrowTurns = (turnAngle ?? 0) / 360;
    final message = _directionMessage();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size.square(300),
                    painter: _CompassPainter(heading: heading ?? 0),
                  ),
                  AnimatedRotation(
                    turns: arrowTurns,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: _KaabaDirectionIndicator(
                      aligned: aligned,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 48,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: const _KaabaIcon(size: 58),
                    ),
                  ),
                  Positioned(
                    bottom: 22,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        heading == null
                            ? 'Compass waiting'
                            : 'Heading ${heading!.round()} deg',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              qiblaBearing == null ? '-- deg' : '${qiblaBearing!.round()} deg',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1BA098),
              ),
            ),
            const Text(
              'Qibla direction from phone GPS, offline ready',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              locationSource,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: aligned ? const Color(0xFF1BA098) : Colors.grey.shade700,
              ),
            ),
            if (loading) ...[
              const SizedBox(height: 18),
              const LinearProgressIndicator(),
            ],
            if (statusMessage != null) ...[
              const SizedBox(height: 18),
              Text(
                statusMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _directionMessage() {
    if (qiblaBearing == null) {
      return 'Allow phone Location/GPS to calculate Qibla offline.';
    }
    if (heading == null) {
      return 'Move the phone gently until compass heading appears.';
    }
    if (turnAngle == null) return 'Calculating direction...';
    if (aligned) return 'You are facing Qibla.';

    final amount = turnAngle!.abs().round();
    final side = turnAngle! > 0 ? 'right' : 'left';
    return 'Rotate the phone $amount deg to the $side.';
  }
}

class _KaabaDirectionIndicator extends StatelessWidget {
  final bool aligned;

  const _KaabaDirectionIndicator({required this.aligned});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 218,
      height: 218,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(206),
            painter: _QiblaNeedlePainter(aligned: aligned),
          ),
          Container(
            width: aligned ? 16 : 12,
            height: aligned ? 16 : 12,
            decoration: BoxDecoration(
              color: aligned ? const Color(0xFF1BA098) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF222222), width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

class _KaabaIcon extends StatelessWidget {
  final double size;

  const _KaabaIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _KaabaIconPainter(),
    );
  }
}

class _KaabaIconPainter extends CustomPainter {
  const _KaabaIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.18, size.width * 0.8,
          size.height * 0.7),
      Radius.circular(size.width * 0.08),
    );
    final blackPaint = Paint()..color = const Color(0xFF111111);
    final sidePaint = Paint()..color = const Color(0xFF262626);
    final goldPaint = Paint()..color = const Color(0xFFD4A574);
    final doorPaint = Paint()..color = const Color(0xFFE1B866);

    canvas.drawRRect(body, blackPaint);
    final sidePath = Path()
      ..moveTo(size.width * 0.7, size.height * 0.18)
      ..lineTo(size.width * 0.9, size.height * 0.3)
      ..lineTo(size.width * 0.9, size.height * 0.88)
      ..lineTo(size.width * 0.7, size.height * 0.88)
      ..close();
    canvas.drawPath(sidePath, sidePaint);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.1,
        size.height * 0.34,
        size.width * 0.8,
        size.height * 0.1,
      ),
      goldPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.49,
        size.height * 0.57,
        size.width * 0.16,
        size.height * 0.31,
      ),
      doorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _KaabaIconPainter oldDelegate) => false;
}

class _QiblaNeedlePainter extends CustomPainter {
  final bool aligned;

  const _QiblaNeedlePainter({required this.aligned});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final tip = Offset(center.dx, size.height * 0.08);
    final tail = Offset(center.dx, size.height * 0.86);
    final left = Offset(center.dx - size.width * 0.18, center.dy + 18);
    final right = Offset(center.dx + size.width * 0.18, center.dy + 18);
    final headLeft = Offset(center.dx - size.width * 0.09, center.dy + 14);
    final headRight = Offset(center.dx + size.width * 0.09, center.dy + 14);
    final tailLeft = Offset(center.dx - size.width * 0.08, center.dy + 16);
    final tailRight = Offset(center.dx + size.width * 0.08, center.dy + 16);
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    final tailPaint = Paint()..color = const Color(0xFF82CBE0);
    final tailDarkPaint = Paint()..color = const Color(0xFF5BAAC7);
    final headLightPaint = Paint()
      ..color = aligned ? const Color(0xFF25B9A9) : const Color(0xFF1D78A8);
    final headDarkPaint = Paint()
      ..color = aligned ? const Color(0xFF1BA098) : const Color(0xFF0A527D);

    final shadowPath = Path()
      ..moveTo(tip.dx + 3, tip.dy + 4)
      ..lineTo(headRight.dx + 3, headRight.dy + 4)
      ..lineTo(tail.dx + 3, tail.dy + 4)
      ..lineTo(headLeft.dx + 3, headLeft.dy + 4)
      ..close();
    canvas.drawPath(shadowPath, shadowPaint);

    final tailLightPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(tailLeft.dx, tailLeft.dy)
      ..lineTo(tail.dx, tail.dy)
      ..close();
    canvas.drawPath(tailLightPath, tailPaint);

    final tailDarkPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(tailRight.dx, tailRight.dy)
      ..lineTo(tail.dx, tail.dy)
      ..close();
    canvas.drawPath(tailDarkPath, tailDarkPaint);

    final headLightPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(tip.dx, tip.dy)
      ..close();
    canvas.drawPath(headLightPath, headLightPaint);

    final headDarkPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(right.dx, right.dy)
      ..lineTo(tip.dx, tip.dy)
      ..close();
    canvas.drawPath(headDarkPath, headDarkPaint);
  }

  @override
  bool shouldRepaint(covariant _QiblaNeedlePainter oldDelegate) {
    return oldDelegate.aligned != aligned;
  }
}

class _QiblaInfoCard extends StatelessWidget {
  final Position? position;
  final double? qiblaBearing;
  final double? distanceKm;
  final double? heading;

  const _QiblaInfoCard({
    required this.position,
    required this.qiblaBearing,
    required this.distanceKm,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE8E3D8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(
              label: 'Distance to Kaaba',
              value: distanceKm == null
                  ? '--'
                  : '${distanceKm!.round().toString()} km',
            ),
            const Divider(height: 24),
            _InfoRow(
              label: 'Qibla bearing',
              value:
                  qiblaBearing == null ? '--' : '${qiblaBearing!.round()} deg',
            ),
            const Divider(height: 24),
            _InfoRow(
              label: 'Compass heading',
              value: heading == null ? '--' : '${heading!.round()} deg',
            ),
            const Divider(height: 24),
            _InfoRow(
              label: 'Current location',
              value: position == null
                  ? '--'
                  : '${position!.latitude.toStringAsFixed(4)}, '
                      '${position!.longitude.toStringAsFixed(4)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _QiblaTipCard extends StatelessWidget {
  final bool aligned;
  final bool hasCompass;

  const _QiblaTipCard({
    required this.aligned,
    required this.hasCompass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: aligned ? const Color(0xFFE8F7F4) : const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: aligned ? const Color(0xFFBCE5DE) : const Color(0xFFFFE0B2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            aligned ? Icons.check_circle : Icons.explore,
            color: aligned ? const Color(0xFF1BA098) : const Color(0xFFE59A1F),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hasCompass
                  ? 'For best accuracy, keep the phone flat and away from metal objects.'
                  : 'If the compass does not move, your device may need sensor calibration.',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1BA098),
          ),
        ),
      ],
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double heading;

  const _CompassPainter({required this.heading});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final outerShadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
    final outerRedPaint = Paint()..color = const Color(0xFFFF3B45);
    final innerRedPaint = Paint()..color = const Color(0xFFD72C34);
    final facePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFF1F1F1)],
      ).createShader(Offset.zero & size);
    final starPaint = Paint()..color = const Color(0xFFC7CBD0);
    final innerPaint = Paint()
      ..color = const Color(0xFFE2E2E2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final tickPaint = Paint()
      ..color = const Color(0xFF0D3876)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    final majorTickPaint = Paint()
      ..color = const Color(0xFF0D3876)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center.translate(7, 8), radius - 20, outerShadow);
    canvas.drawCircle(center, radius - 18, outerRedPaint);
    canvas.drawCircle(center, radius - 29, innerRedPaint);
    canvas.drawCircle(center, radius - 39, facePaint);
    canvas.drawCircle(center, radius - 50, innerPaint);
    _drawCompassRose(canvas, center, radius - 72, starPaint);

    for (var i = 0; i < 360; i += 15) {
      final adjusted = i - heading;
      final angle = (adjusted - 90) * math.pi / 180;
      final isCardinal = i % 90 == 0;
      final outer = Offset(
        center.dx + math.cos(angle) * (radius - 58),
        center.dy + math.sin(angle) * (radius - 58),
      );
      final inner = Offset(
        center.dx + math.cos(angle) * (radius - (isCardinal ? 90 : 78)),
        center.dy + math.sin(angle) * (radius - (isCardinal ? 90 : 78)),
      );
      canvas.drawLine(inner, outer, isCardinal ? majorTickPaint : tickPaint);
    }
  }

  void _drawCompassRose(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    for (var i = 0; i < 8; i++) {
      final angle = (i * 45 - heading - 90) * math.pi / 180;
      final long = i.isEven;
      final tip = Offset(
        center.dx + math.cos(angle) * (long ? radius : radius * 0.68),
        center.dy + math.sin(angle) * (long ? radius : radius * 0.68),
      );
      final left = Offset(
        center.dx + math.cos(angle + 0.12) * 10,
        center.dy + math.sin(angle + 0.12) * 10,
      );
      final right = Offset(
        center.dx + math.cos(angle - 0.12) * 10,
        center.dy + math.sin(angle - 0.12) * 10,
      );
      final path = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(left.dx, left.dy)
        ..lineTo(right.dx, right.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) {
    return oldDelegate.heading != heading;
  }
}
