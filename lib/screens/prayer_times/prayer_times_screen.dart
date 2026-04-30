import 'package:flutter/material.dart';

import '../../services/notification_service.dart';
import '../../services/prayer_times_service.dart';
import '../../widgets/app_chrome.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  final PrayerTimesService _service = PrayerTimesService();
  late Future<PrayerTimesViewData> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchPrayerTimesView();
  }

  void _refresh() {
    setState(() {
      _future = _service.fetchPrayerTimesView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(
        context,
        title: 'Prayer Times',
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
      body: FutureBuilder<PrayerTimesViewData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _PrayerTimesError(
              timeZone: _service.resolveDeviceTimeZone(),
              onRetry: _refresh,
            );
          }

          final data = snapshot.data!;
          final prayerTime = data.prayerTime;

          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LocationCard(data: data),
                const SizedBox(height: 18),
                _NextPrayerCard(data: data),
                const SizedBox(height: 24),
                const Text(
                  'Daily Prayer Times',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Fajr',
                  icon: Icons.wb_twilight,
                  time: prayerTime.fajr,
                  color: const Color(0xFF6A4C93),
                  bgColor: const Color(0xFFF3E5F5),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Sunrise',
                  icon: Icons.wb_sunny_outlined,
                  time: prayerTime.sunrise,
                  color: const Color(0xFFE59A1F),
                  bgColor: const Color(0xFFFFF3E0),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Dhuhr',
                  icon: Icons.wb_sunny,
                  time: prayerTime.dhuhr,
                  color: const Color(0xFFC77D00),
                  bgColor: const Color(0xFFFFF8E1),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Asr',
                  icon: Icons.cloud_outlined,
                  time: prayerTime.asr,
                  color: const Color(0xFFFF6B35),
                  bgColor: const Color(0xFFFFEBEE),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Maghrib',
                  icon: Icons.brightness_3,
                  time: prayerTime.maghrib,
                  color: const Color(0xFF9B6A2F),
                  bgColor: const Color(0xFFFFF4D6),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Isha',
                  icon: Icons.nights_stay,
                  time: prayerTime.isha,
                  color: const Color(0xFF264653),
                  bgColor: const Color(0xFFE0F2F1),
                ),
                const SizedBox(height: 24),
                _IslamicDateCard(data: data),
                const SizedBox(height: 16),
                const _AzanAlertInfoCard(),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final PrayerTimesViewData data;

  const _LocationCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final localDate = data.prayerTime.date;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE8E3D8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: hidayatTeal, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.prayerTime.location,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _MetaLine(
              icon: Icons.schedule,
              label: 'Phone timezone',
              value: data.timeZone,
            ),
            const SizedBox(height: 6),
            _MetaLine(
              icon: Icons.today,
              label: 'Phone date',
              value:
                  '${localDate.day.toString().padLeft(2, '0')}-${localDate.month.toString().padLeft(2, '0')}-${localDate.year}',
            ),
            if (data.calculationMethod.isNotEmpty) ...[
              const SizedBox(height: 6),
              _MetaLine(
                icon: Icons.calculate_outlined,
                label: 'Method',
                value: data.calculationMethod,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NextPrayerCard extends StatelessWidget {
  final PrayerTimesViewData data;

  const _NextPrayerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = _PrayerVisualTheme.forPrayer(data.nextPrayerName);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: theme.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            top: -24,
            child: Icon(
              theme.icon,
              size: 108,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(theme.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Prayer',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.nextPrayerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${data.nextPrayerTime}${_remainingLabel(data.nextPrayerRemaining)}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      theme.caption,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _remainingLabel(Duration? duration) {
    if (duration == null) return '';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours <= 0) return ' • in $minutes min';
    return ' • in ${hours}h ${minutes}m';
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

/*
              children: [
                const Text(
                  'Next Prayer',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  data.nextPrayerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${data.nextPrayerTime}${_remainingLabel(data.nextPrayerRemaining)}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _remainingLabel(Duration? duration) {
    if (duration == null) return '';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours <= 0) return ' • in $minutes min';
    return ' • in ${hours}h ${minutes}m';
  }
}

*/
class _IslamicDateCard extends StatelessWidget {
  final PrayerTimesViewData data;

  const _IslamicDateCard({required this.data});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Islamic Date',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              data.hijriDate.isEmpty ? 'Not available' : data.hijriDate,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: hidayatTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _AzanAlertInfoCard extends StatelessWidget {
  const _AzanAlertInfoCard();

  Future<void> _testAzanSound(BuildContext context) async {
    await NotificationService().showAzanNow(
      id: 2099,
      prayerName: 'Test',
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Azan test alert sent. Phone volume/settings check karein.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8EFEB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notifications_active, color: hidayatTeal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prayer alerts are scheduled for Fajr, Dhuhr, Asr, Maghrib, and Isha. Shia azan sound alert ke sath chalegi.',
                  style: TextStyle(fontSize: 13, height: 1.45),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _testAzanSound(context),
                  icon: const Icon(Icons.volume_up_rounded, size: 18),
                  label: const Text('Test Azan Sound'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: hidayatTeal,
                    side: const BorderSide(color: hidayatTeal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerTimesError extends StatelessWidget {
  final String timeZone;
  final VoidCallback onRetry;

  const _PrayerTimesError({
    required this.timeZone,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 42, color: hidayatTeal),
            const SizedBox(height: 12),
            const Text(
              'Prayer timings could not be loaded',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone timezone detected as $timeZone. Please check internet and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerTimeItemCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String time;
  final Color color;
  final Color bgColor;

  const _PrayerTimeItemCard({
    required this.name,
    required this.icon,
    required this.time,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: hidayatTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
