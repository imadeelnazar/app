import 'dart:math';

import 'package:dio/dio.dart';

import '../data/models/models.dart';
import 'notification_service.dart';

class PrayerTimesViewData {
  final PrayerTime prayerTime;
  final String hijriDate;
  final String timeZone;
  final String calculationMethod;
  final String nextPrayerName;
  final String nextPrayerTime;
  final Duration? nextPrayerRemaining;

  const PrayerTimesViewData({
    required this.prayerTime,
    required this.hijriDate,
    required this.timeZone,
    required this.calculationMethod,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.nextPrayerRemaining,
  });
}

class PrayerTimesService {
  PrayerTimesService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const double defaultLatitude = 31.5204;
  static const double defaultLongitude = 74.3587;
  static const String defaultLocation = 'Lahore, Pakistan';
  static const String urduPointShiaLahoreUrl =
      'https://www.urdupoint.com/islam/shia/lahore-prayer-timings.html';
  static const int rollingNotificationDays = 14;

  Future<PrayerTimesViewData> fetchPrayerTimesView({
    double latitude = defaultLatitude,
    double longitude = defaultLongitude,
    String location = defaultLocation,
    String? timeZone,
  }) async {
    final resolvedTimeZone = timeZone ?? resolveDeviceTimeZone();
    final today = DateTime.now();

    try {
      return await _fetchUrduPointPrayerTimesView(
        today: today,
        latitude: latitude,
        longitude: longitude,
        location: location,
        resolvedTimeZone: resolvedTimeZone,
      );
    } catch (_) {
      return _fetchAladhanPrayerTimesView(
        today: today,
        latitude: latitude,
        longitude: longitude,
        location: location,
        resolvedTimeZone: resolvedTimeZone,
      );
    }
  }

  Future<PrayerTimesViewData> _fetchUrduPointPrayerTimesView({
    required DateTime today,
    required double latitude,
    required double longitude,
    required String location,
    required String resolvedTimeZone,
  }) async {
    final response = await _dio.get<String>(
      urduPointShiaLahoreUrl,
      options: Options(responseType: ResponseType.plain),
    );
    final html = response.data ?? '';
    final timings = _parseUrduPointTimes(html, today);
    if (timings == null) {
      throw StateError('UrduPoint prayer timings were not found.');
    }

    final prayerTime = PrayerTime()
      ..date = today
      ..fajr = timings.fajr
      ..sunrise = timings.sunrise
      ..dhuhr = timings.dhuhr
      ..asr = timings.asr
      ..maghrib = timings.maghrib
      ..isha = timings.isha
      ..location = location
      ..lastUpdated = DateTime.now()
      ..dateIndex = DateTime(today.year, today.month, today.day);

    await _scheduleRollingPrayerNotifications(
      seedPrayerTime: prayerTime,
      latitude: latitude,
      longitude: longitude,
      location: location,
      resolvedTimeZone: resolvedTimeZone,
    );

    final next = _findNextPrayer(prayerTime, today);
    final hijriDate = await _fetchHijriDate(today, resolvedTimeZone);

    return PrayerTimesViewData(
      prayerTime: prayerTime,
      hijriDate: hijriDate,
      timeZone: resolvedTimeZone,
      calculationMethod: 'UrduPoint Shia Ithna-Ashari, Leva Institute, Qum',
      nextPrayerName: next.name,
      nextPrayerTime: next.time,
      nextPrayerRemaining: next.remaining,
    );
  }

  Future<PrayerTimesViewData> _fetchAladhanPrayerTimesView({
    required DateTime today,
    required double latitude,
    required double longitude,
    required String location,
    required String resolvedTimeZone,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'https://api.aladhan.com/v1/timings/${_formatApiDate(today)}',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'method': 1,
        'school': 1,
        'timezonestring': resolvedTimeZone,
      },
    );

    final data = response.data?['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Prayer timings response was empty.');
    }

    final timings = data['timings'] as Map<String, dynamic>? ?? {};
    final date = data['date'] as Map<String, dynamic>? ?? {};
    final hijri = date['hijri'] as Map<String, dynamic>? ?? {};
    final meta = data['meta'] as Map<String, dynamic>? ?? {};

    final prayerTime = PrayerTime()
      ..date = today
      ..fajr = _displayTime(timings['Fajr']?.toString() ?? '')
      ..sunrise = _displayTime(timings['Sunrise']?.toString() ?? '')
      ..dhuhr = _displayTime(timings['Dhuhr']?.toString() ?? '')
      ..asr = _displayTime(timings['Asr']?.toString() ?? '')
      ..maghrib = _displayTime(timings['Maghrib']?.toString() ?? '')
      ..isha = _displayTime(timings['Isha']?.toString() ?? '')
      ..location = location
      ..lastUpdated = DateTime.now()
      ..dateIndex = DateTime(today.year, today.month, today.day);

    await _scheduleRollingPrayerNotifications(
      seedPrayerTime: prayerTime,
      latitude: latitude,
      longitude: longitude,
      location: location,
      resolvedTimeZone: resolvedTimeZone,
    );

    final next = _findNextPrayer(prayerTime, today);

    return PrayerTimesViewData(
      prayerTime: prayerTime,
      hijriDate: _formatHijriDate(hijri),
      timeZone: meta['timezone']?.toString().isNotEmpty == true
          ? meta['timezone'].toString()
          : resolvedTimeZone,
      calculationMethod:
          meta['method'] is Map ? meta['method']['name']?.toString() ?? '' : '',
      nextPrayerName: next.name,
      nextPrayerTime: next.time,
      nextPrayerRemaining: next.remaining,
    );
  }

  Future<PrayerTime?> fetchPrayerTimes({
    double latitude = defaultLatitude,
    double longitude = defaultLongitude,
    String location = defaultLocation,
    String? timeZone,
  }) async {
    final data = await fetchPrayerTimesView(
      latitude: latitude,
      longitude: longitude,
      location: location,
      timeZone: timeZone,
    );
    return data.prayerTime;
  }

  String resolveDeviceTimeZone() {
    final now = DateTime.now();
    final abbreviation = now.timeZoneName.toUpperCase();
    final minutes = now.timeZoneOffset.inMinutes;

    if (abbreviation == 'PKT' || minutes == 300) return 'Asia/Karachi';
    if (abbreviation == 'UTC' || abbreviation == 'GMT' || minutes == 0) {
      return 'UTC';
    }
    if (abbreviation == 'IST' && minutes == 330) return 'Asia/Kolkata';
    if (abbreviation == 'BST' && minutes == 360) return 'Asia/Dhaka';
    if (abbreviation == 'GST' && minutes == 240) return 'Asia/Dubai';
    if (abbreviation == 'AST' && minutes == 180) return 'Asia/Riyadh';
    if (abbreviation == 'CET' && minutes == 60) return 'Europe/Paris';
    if (abbreviation == 'CEST' && minutes == 120) return 'Europe/Paris';
    if (abbreviation == 'EET' && minutes == 120) return 'Europe/Cairo';
    if (abbreviation == 'EEST' && minutes == 180) return 'Europe/Athens';
    if (abbreviation == 'EST' && minutes == -300) return 'America/New_York';
    if (abbreviation == 'EDT' && minutes == -240) return 'America/New_York';
    if (abbreviation == 'CST' && minutes == -360) return 'America/Chicago';
    if (abbreviation == 'CDT' && minutes == -300) return 'America/Chicago';
    if (abbreviation == 'MST' && minutes == -420) return 'America/Denver';
    if (abbreviation == 'MDT' && minutes == -360) return 'America/Denver';
    if (abbreviation == 'PST' && minutes == -480) return 'America/Los_Angeles';
    if (abbreviation == 'PDT' && minutes == -420) return 'America/Los_Angeles';

    return minutes == 300 ? 'Asia/Karachi' : 'UTC';
  }

  String getNextPrayerTime(PrayerTime prayerTime) {
    return _findNextPrayer(prayerTime, DateTime.now()).name;
  }

  double calculateQiblaDirection(double latitude, double longitude) {
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final lat1 = latitude * pi / 180;
    const lat2 = kaabaLat * pi / 180;
    final deltaLng = (kaabaLng - longitude) * pi / 180;

    final y = sin(deltaLng);
    final x = cos(lat1) * tan(lat2) - sin(lat1) * cos(deltaLng);
    final bearing = atan2(y, x) * 180 / pi;

    return (bearing + 360) % 360;
  }

  String getIslamicDate(DateTime gregorianDate) {
    return _formatApiDate(gregorianDate);
  }

  Future<void> _scheduleRollingPrayerNotifications({
    required PrayerTime seedPrayerTime,
    required double latitude,
    required double longitude,
    required String location,
    required String resolvedTimeZone,
  }) async {
    final prayerTimes = <PrayerTime>[seedPrayerTime];

    try {
      final startDate = DateTime(
        seedPrayerTime.date.year,
        seedPrayerTime.date.month,
        seedPrayerTime.date.day,
      ).add(const Duration(days: 1));
      final endDate =
          startDate.add(const Duration(days: rollingNotificationDays - 2));
      final months = <_CalendarMonth>{};

      var cursor = DateTime(startDate.year, startDate.month);
      final lastMonth = DateTime(endDate.year, endDate.month);
      while (!cursor.isAfter(lastMonth)) {
        months.add(_CalendarMonth(cursor.year, cursor.month));
        cursor = DateTime(cursor.year, cursor.month + 1);
      }

      for (final month in months) {
        final response = await _dio.get<Map<String, dynamic>>(
          'https://api.aladhan.com/v1/calendar/${month.year}/${month.month}',
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'method': 1,
            'school': 1,
            'timezonestring': resolvedTimeZone,
          },
        );
        final data = response.data?['data'] as List<dynamic>? ?? const [];
        for (final item in data.whereType<Map<String, dynamic>>()) {
          final prayerTime = _prayerTimeFromCalendarItem(
            item,
            location: location,
          );
          if (prayerTime == null) continue;

          final date = DateTime(
            prayerTime.date.year,
            prayerTime.date.month,
            prayerTime.date.day,
          );
          if (date.isBefore(startDate) || date.isAfter(endDate)) continue;
          prayerTimes.add(prayerTime);
        }
      }
    } catch (_) {
      // Keep at least today's azan alerts scheduled when the rolling calendar
      // cannot be refreshed because the phone is offline.
    }

    await NotificationService().schedulePrayerNotificationsForDays(prayerTimes);
  }

  PrayerTime? _prayerTimeFromCalendarItem(
    Map<String, dynamic> item, {
    required String location,
  }) {
    final timings = item['timings'] as Map<String, dynamic>? ?? {};
    final date = item['date'] as Map<String, dynamic>? ?? {};
    final gregorian = date['gregorian'] as Map<String, dynamic>? ?? {};
    final rawDate = gregorian['date']?.toString() ?? '';
    final parsedDate = _parseApiDate(rawDate);
    if (parsedDate == null) return null;

    return PrayerTime()
      ..date = parsedDate
      ..fajr = _displayTime(timings['Fajr']?.toString() ?? '')
      ..sunrise = _displayTime(timings['Sunrise']?.toString() ?? '')
      ..dhuhr = _displayTime(timings['Dhuhr']?.toString() ?? '')
      ..asr = _displayTime(timings['Asr']?.toString() ?? '')
      ..maghrib = _displayTime(timings['Maghrib']?.toString() ?? '')
      ..isha = _displayTime(timings['Isha']?.toString() ?? '')
      ..location = location
      ..lastUpdated = DateTime.now()
      ..dateIndex = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
  }

  DateTime? _parseApiDate(String raw) {
    final parts = raw.split('-');
    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;

    return DateTime(year, month, day);
  }

  String _formatApiDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  String _displayTime(String raw) {
    final clean = _cleanTime(raw);
    final parts = clean.split(':');
    if (parts.length < 2) return raw;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return raw;

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }

  String _cleanTime(String raw) {
    return raw.split(' ').first.trim();
  }

  DateTime? _dateTimeForDisplayTime(String time, DateTime date) {
    final match =
        RegExp(r'^(\d{1,2}):(\d{2})(?:\s*(AM|PM))?$', caseSensitive: false)
            .firstMatch(time.trim());
    if (match == null) return null;

    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)?.toUpperCase();
    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;
    if (hour > 23 || minute > 59) return null;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  _UrduPointTimings? _parseUrduPointTimes(String html, DateTime date) {
    final normalized = html
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');

    final rowPattern = RegExp(
      r'(\d{1,2})\s+([A-Za-z]{3,9})\s+(\d{4})\s+'
      r'(\d{1,2}:\d{2})\s+(\d{1,2}:\d{2})\s+(\d{1,2}:\d{2})\s+'
      r'(\d{1,2}:\d{2})\s+(\d{1,2}:\d{2})\s+(\d{1,2}:\d{2})',
      caseSensitive: false,
    );

    for (final match in rowPattern.allMatches(normalized)) {
      final day = int.tryParse(match.group(1)!);
      final month = _monthNumber(match.group(2)!);
      final year = int.tryParse(match.group(3)!);
      if (day == date.day && month == date.month && year == date.year) {
        return _UrduPointTimings(
          fajr: _formatUrduPointTime(match.group(4)!, _PrayerPeriod.am),
          sunrise: _formatUrduPointTime(match.group(5)!, _PrayerPeriod.am),
          dhuhr: _formatUrduPointTime(match.group(6)!, _PrayerPeriod.pm),
          asr: _formatUrduPointTime(match.group(7)!, _PrayerPeriod.pm),
          maghrib: _formatUrduPointTime(match.group(8)!, _PrayerPeriod.pm),
          isha: _formatUrduPointTime(match.group(9)!, _PrayerPeriod.pm),
        );
      }
    }

    final summaryPattern = RegExp(
      r'Fajar\s+(\d{1,2}:\d{2}).*?Sunrise\s+(\d{1,2}:\d{2}).*?'
      r'Zuhr\s+(\d{1,2}:\d{2}).*?Asr\s+(\d{1,2}:\d{2}).*?'
      r'Maghrib\s+(\d{1,2}:\d{2}).*?Isha\s+(\d{1,2}:\d{2})',
      caseSensitive: false,
    );
    final summary = summaryPattern.firstMatch(normalized);
    if (summary == null) return null;

    return _UrduPointTimings(
      fajr: _formatUrduPointTime(summary.group(1)!, _PrayerPeriod.am),
      sunrise: _formatUrduPointTime(summary.group(2)!, _PrayerPeriod.am),
      dhuhr: _formatUrduPointTime(summary.group(3)!, _PrayerPeriod.pm),
      asr: _formatUrduPointTime(summary.group(4)!, _PrayerPeriod.pm),
      maghrib: _formatUrduPointTime(summary.group(5)!, _PrayerPeriod.pm),
      isha: _formatUrduPointTime(summary.group(6)!, _PrayerPeriod.pm),
    );
  }

  int? _monthNumber(String month) {
    switch (month.toLowerCase().substring(0, 3)) {
      case 'jan':
        return 1;
      case 'feb':
        return 2;
      case 'mar':
        return 3;
      case 'apr':
        return 4;
      case 'may':
        return 5;
      case 'jun':
        return 6;
      case 'jul':
        return 7;
      case 'aug':
        return 8;
      case 'sep':
        return 9;
      case 'oct':
        return 10;
      case 'nov':
        return 11;
      case 'dec':
        return 12;
    }
    return null;
  }

  String _formatUrduPointTime(String raw, _PrayerPeriod period) {
    final parts = raw.trim().split(':');
    var hour = int.tryParse(parts.first) ?? 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    if (period == _PrayerPeriod.pm && hour < 12) {
      hour += 12;
    }
    if (period == _PrayerPeriod.am && hour == 12) {
      hour = 0;
    }

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }

  Future<String> _fetchHijriDate(DateTime date, String resolvedTimeZone) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.aladhan.com/v1/gToH/${_formatApiDate(date)}',
        queryParameters: {'timezonestring': resolvedTimeZone},
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      final hijri = data?['hijri'] as Map<String, dynamic>? ?? {};
      return _formatHijriDate(hijri);
    } catch (_) {
      return '';
    }
  }

  _NextPrayer _findNextPrayer(PrayerTime prayerTime, DateTime now) {
    final prayers = <_PrayerCandidate>[
      _PrayerCandidate('Fajr', prayerTime.fajr),
      _PrayerCandidate('Sunrise', prayerTime.sunrise),
      _PrayerCandidate('Dhuhr', prayerTime.dhuhr),
      _PrayerCandidate('Asr', prayerTime.asr),
      _PrayerCandidate('Maghrib', prayerTime.maghrib),
      _PrayerCandidate('Isha', prayerTime.isha),
    ];

    for (final prayer in prayers) {
      final dateTime = _dateTimeForDisplayTime(prayer.time, now);
      if (dateTime != null && dateTime.isAfter(now)) {
        return _NextPrayer(
          prayer.name,
          prayer.time,
          dateTime.difference(now),
        );
      }
    }

    return _NextPrayer('Fajr', prayerTime.fajr, null);
  }

  String _formatHijriDate(Map<String, dynamic> hijri) {
    final day = hijri['day']?.toString() ?? '';
    final year = hijri['year']?.toString() ?? '';
    final monthData = hijri['month'];
    final month = monthData is Map
        ? monthData['en']?.toString() ?? ''
        : monthData?.toString() ?? '';

    final parts = [day, month, year].where((part) => part.isNotEmpty).toList();
    return parts.isEmpty ? '' : '${parts.join(' ')} H';
  }
}

enum _PrayerPeriod { am, pm }

class _PrayerCandidate {
  final String name;
  final String time;

  const _PrayerCandidate(this.name, this.time);
}

class _UrduPointTimings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  const _UrduPointTimings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
}

class _NextPrayer {
  final String name;
  final String time;
  final Duration? remaining;

  const _NextPrayer(this.name, this.time, this.remaining);
}

class _CalendarMonth {
  final int year;
  final int month;

  const _CalendarMonth(this.year, this.month);

  @override
  bool operator ==(Object other) {
    return other is _CalendarMonth &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode => Object.hash(year, month);
}
