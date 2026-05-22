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

  Future<void> _useCurrentLocation() async {
    await _service.useAutomaticLocation();
    _refresh();
  }

  Future<void> _useManualLocation(PrayerLocationPreset preset) async {
    await _service.useManualLocation(preset);
    _refresh();
  }

  Future<void> _setCalculationMethod(String methodId) async {
    await _service.setCalculationMethod(methodId);
    _refresh();
  }

  Future<void> _setMadhab(String madhab) async {
    await _service.setMadhab(madhab);
    _refresh();
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
              timeZone: _service.resolveDeviceTimeZoneSync(),
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
                const SizedBox(height: 12),
                _PrayerSettingsCard(
                  data: data,
                  onUseCurrentLocation: _useCurrentLocation,
                  onManualLocationSelected: _useManualLocation,
                  onCalculationMethodChanged: _setCalculationMethod,
                  onMadhabChanged: _setMadhab,
                ),
                const SizedBox(height: 18),
                _NextPrayerCard(data: data),
                const SizedBox(height: 24),
                const Text(
                  'Daily Prayer Times',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _PrayerTimeItemCard(
                  name: 'Fajar',
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
                  name: 'Zuhr',
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
                const SizedBox(height: 16),
                _PrayerDebugCard(data: data),
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

class _PrayerSettingsCard extends StatelessWidget {
  final PrayerTimesViewData data;
  final Future<void> Function() onUseCurrentLocation;
  final Future<void> Function(PrayerLocationPreset preset)
      onManualLocationSelected;
  final Future<void> Function(String methodId) onCalculationMethodChanged;
  final Future<void> Function(String madhab) onMadhabChanged;

  const _PrayerSettingsCard({
    required this.data,
    required this.onUseCurrentLocation,
    required this.onManualLocationSelected,
    required this.onCalculationMethodChanged,
    required this.onMadhabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentPreset = PrayerTimesService.manualLocationPresets.any(
      (preset) => preset.label == data.prayerTime.location,
    )
        ? data.prayerTime.location
        : null;
    final calculationValue = PrayerTimesService.calculationOptions
        .firstWhere(
          (option) => option.label == data.calculationMethod,
          orElse: () => PrayerTimesService.calculationOptions.first,
        )
        .id;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE8E3D8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onUseCurrentLocation,
                    icon: const Icon(Icons.my_location, size: 18),
                    label: const Text('Use Current Location'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: currentPreset,
              decoration: const InputDecoration(
                labelText: 'Manual city fallback',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: PrayerTimesService.manualLocationPresets
                  .map(
                    (preset) => DropdownMenuItem(
                      value: preset.label,
                      child: Text(preset.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) async {
                final preset = PrayerTimesService.manualLocationPresets
                    .firstWhere((item) => item.label == value);
                await onManualLocationSelected(preset);
              },
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: calculationValue,
              decoration: const InputDecoration(
                labelText: 'Calculation method',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: PrayerTimesService.calculationOptions
                  .map(
                    (option) => DropdownMenuItem(
                      value: option.id,
                      child: Text(option.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) async {
                if (value != null) await onCalculationMethodChanged(value);
              },
            ),
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
    if (hours <= 0) return ' - in $minutes min';
    return ' - in ${hours}h ${minutes}m';
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
    if (key.contains('fajr') || key.contains('fajar')) {
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
    if (key.contains('dhuhr') || key.contains('zuhr')) {
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
    if (hours <= 0) return ' - in $minutes min';
    return ' - in ${hours}h ${minutes}m';
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
                  'Prayer alerts are scheduled for Fajar, Zuhr, Asr, Maghrib, and Isha. Shia azan sound alert ke sath chalegi.',
                  style: TextStyle(fontSize: 13, height: 1.45),
                ),
                FutureBuilder<NotificationRuntimeStatus>(
                  future: NotificationService().getRuntimeStatus(),
                  builder: (context, snapshot) {
                    final status = snapshot.data;
                    if (status == null ||
                        (status.notificationsEnabled &&
                            status.exactAlarmsEnabled)) {
                      return const SizedBox.shrink();
                    }
                    final messages = [
                      if (!status.notificationsEnabled)
                        'Notifications are disabled in Android settings.',
                      if (!status.exactAlarmsEnabled)
                        'Exact alarm permission is disabled; Azan may be delayed.',
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        messages.join(' '),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
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

class _PrayerDebugCard extends StatelessWidget {
  final PrayerTimesViewData data;

  const _PrayerDebugCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final scheduled = data.scheduledNotifications.take(10).toList();

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: const Icon(Icons.bug_report_outlined, color: hidayatTeal),
      title: const Text('Prayer Time Debug'),
      children: [
        _DebugLine(label: 'Device time', value: _formatDateTime(now)),
        _DebugLine(label: 'App timezone', value: data.timeZone),
        _DebugLine(
          label: 'Location',
          value:
              '${data.prayerTime.location} (${data.latitude.toStringAsFixed(5)}, ${data.longitude.toStringAsFixed(5)})',
        ),
        _DebugLine(label: 'Method', value: data.calculationMethod),
        _DebugLine(label: 'Asr method', value: data.madhab),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Today',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _DebugLine(label: 'Fajar', value: data.prayerTime.fajr),
        _DebugLine(label: 'Sunrise', value: data.prayerTime.sunrise),
        _DebugLine(label: 'Zuhr', value: data.prayerTime.dhuhr),
        _DebugLine(label: 'Asr', value: data.prayerTime.asr),
        _DebugLine(label: 'Maghrib', value: data.prayerTime.maghrib),
        _DebugLine(label: 'Isha', value: data.prayerTime.isha),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Scheduled',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (scheduled.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('No upcoming prayer notifications found.'),
            ),
          ),
        for (final item in scheduled)
          _DebugLine(
            label: '${item.id} ${item.pendingInOs ? 'OS' : 'Missing'}',
            value: '${item.title} - ${_formatDateTime(item.scheduledTime)}',
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class _DebugLine extends StatelessWidget {
  final String label;
  final String value;

  const _DebugLine({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
