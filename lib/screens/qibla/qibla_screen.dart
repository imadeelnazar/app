import 'dart:async';
import 'dart:math' as math;

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

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _loadingLocation = false;
        _statusMessage = 'Please turn on phone location to calculate Qibla.';
      });
      return;
    }

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

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _updatePosition(position);
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen(_updatePosition);
    } catch (_) {
      setState(() {
        _loadingLocation = false;
        _statusMessage = 'Unable to get current location. Please try again.';
      });
    }
  }

  void _updatePosition(Position position) {
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
    });
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
      appBar: hidayatAppBar(
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
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
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
  final VoidCallback onRetry;

  const _QiblaCompassCard({
    required this.heading,
    required this.qiblaBearing,
    required this.turnAngle,
    required this.aligned,
    required this.loading,
    required this.statusMessage,
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
              width: 260,
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size.square(260),
                    painter: _CompassPainter(heading: heading ?? 0),
                  ),
                  AnimatedRotation(
                    turns: arrowTurns,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: aligned ? const Color(0xFF1BA098) : hidayatGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.navigation,
                        color: Colors.white,
                        size: 52,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 18,
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
              'Qibla direction from your location',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
    if (qiblaBearing == null) return 'Allow location to calculate Qibla.';
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
    final borderPaint = Paint()
      ..color = const Color(0xFFD4A574)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0x1AD4A574), Color(0x101BA098)],
      ).createShader(Offset.zero & size);
    final tickPaint = Paint()
      ..color = const Color(0xFF806B45)
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 1, fillPaint);
    canvas.drawCircle(center, radius - 1, borderPaint);

    for (var i = 0; i < 360; i += 10) {
      final adjusted = i - heading;
      final angle = (adjusted - 90) * math.pi / 180;
      final isMajor = i % 30 == 0;
      final outer = Offset(
        center.dx + math.cos(angle) * (radius - 13),
        center.dy + math.sin(angle) * (radius - 13),
      );
      final inner = Offset(
        center.dx + math.cos(angle) * (radius - (isMajor ? 28 : 20)),
        center.dy + math.sin(angle) * (radius - (isMajor ? 28 : 20)),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    _drawDirection(canvas, center, radius, 'N', 0);
    _drawDirection(canvas, center, radius, 'E', 90);
    _drawDirection(canvas, center, radius, 'S', 180);
    _drawDirection(canvas, center, radius, 'W', 270);
  }

  void _drawDirection(
    Canvas canvas,
    Offset center,
    double radius,
    String text,
    double degrees,
  ) {
    final adjusted = degrees - heading;
    final angle = (adjusted - 90) * math.pi / 180;
    final position = Offset(
      center.dx + math.cos(angle) * (radius - 46),
      center.dy + math.sin(angle) * (radius - 46),
    );
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset(position.dx - painter.width / 2, position.dy - painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) {
    return oldDelegate.heading != heading;
  }
}
