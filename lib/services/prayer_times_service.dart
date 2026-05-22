import 'dart:convert';
import 'dart:math';

import 'package:adhan/adhan.dart' as adhan;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/models/models.dart';
import 'notification_service.dart';

class PrayerTimesViewData {
  final PrayerTime prayerTime;
  final PrayerTime tomorrowPrayerTime;
  final String hijriDate;
  final String timeZone;
  final String calculationMethod;
  final String madhab;
  final double latitude;
  final double longitude;
  final String nextPrayerName;
  final String nextPrayerTime;
  final Duration? nextPrayerRemaining;
  final List<PrayerScheduleDebugItem> scheduledNotifications;

  const PrayerTimesViewData({
    required this.prayerTime,
    required this.tomorrowPrayerTime,
    required this.hijriDate,
    required this.timeZone,
    required this.calculationMethod,
    required this.madhab,
    required this.latitude,
    required this.longitude,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.nextPrayerRemaining,
    required this.scheduledNotifications,
  });
}

class PrayerScheduleDebugItem {
  final int id;
  final String title;
  final DateTime scheduledTime;
  final bool pendingInOs;

  const PrayerScheduleDebugItem({
    required this.id,
    required this.title,
    required this.scheduledTime,
    required this.pendingInOs,
  });
}

class PrayerLocationPreset {
  final String label;
  final double latitude;
  final double longitude;
  final String timeZone;

  const PrayerLocationPreset({
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
  });
}

class PrayerCalculationOption {
  final String id;
  final String label;

  const PrayerCalculationOption(this.id, this.label);
}

class PrayerTimesService {
  static const double defaultLatitude = 24.8607;
  static const double defaultLongitude = 67.0011;
  static const String defaultLocation = 'Karachi, Pakistan';
  static const String defaultTimeZone = 'Asia/Karachi';
  static const String defaultCalculationMethod = 'jafari_qum';
  static const String defaultMadhab = 'jafari';
  static const int rollingNotificationDays = 30;

  static const String _configPrefsKey = 'prayer_times_config_v3';
  static const String _todayCachePrefsKey = 'prayer_times_today_cache_v3';
  static const String _tomorrowCachePrefsKey = 'prayer_times_tomorrow_cache_v3';

  static const List<PrayerLocationPreset> manualLocationPresets = [
    PrayerLocationPreset(
      label: 'Karachi, Pakistan',
      latitude: 24.8607,
      longitude: 67.0011,
      timeZone: 'Asia/Karachi',
    ),
    PrayerLocationPreset(
      label: 'Lahore, Pakistan',
      latitude: 31.5204,
      longitude: 74.3587,
      timeZone: 'Asia/Karachi',
    ),
    PrayerLocationPreset(
      label: 'Islamabad, Pakistan',
      latitude: 33.6844,
      longitude: 73.0479,
      timeZone: 'Asia/Karachi',
    ),
    PrayerLocationPreset(
      label: 'Najaf, Iraq',
      latitude: 32.0259,
      longitude: 44.3463,
      timeZone: 'Asia/Baghdad',
    ),
    PrayerLocationPreset(
      label: 'Karbala, Iraq',
      latitude: 32.6160,
      longitude: 44.0249,
      timeZone: 'Asia/Baghdad',
    ),
    PrayerLocationPreset(
      label: 'Mashhad, Iran',
      latitude: 36.2605,
      longitude: 59.6168,
      timeZone: 'Asia/Tehran',
    ),
    PrayerLocationPreset(
      label: 'London, United Kingdom',
      latitude: 51.5072,
      longitude: -0.1276,
      timeZone: 'Europe/London',
    ),
    PrayerLocationPreset(
      label: 'New York, United States',
      latitude: 40.7128,
      longitude: -74.0060,
      timeZone: 'America/New_York',
    ),
  ];

  static const List<PrayerCalculationOption> calculationOptions = [
    PrayerCalculationOption(
      'jafari_qum',
      'Jafari / Shia Ithna-Ashari',
    ),
  ];

  Future<PrayerTimesViewData> fetchPrayerTimesView({
    double? latitude,
    double? longitude,
    String? location,
    String? timeZone,
    String? calculationMethod,
    String? madhab,
    bool refreshLocation = false,
    bool scheduleNotifications = true,
  }) async {
    tzdata.initializeTimeZones();

    final config = await _resolveConfig(
      latitude: latitude,
      longitude: longitude,
      location: location,
      timeZone: timeZone,
      calculationMethod: calculationMethod,
      madhab: madhab,
      refreshLocation: refreshLocation,
    );

    final today = _dateOnly(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));
    final todayPrayerTime = _calculatePrayerTime(config, today);
    final tomorrowPrayerTime = _calculatePrayerTime(config, tomorrow);
    final rollingPrayerTimes = List<PrayerTime>.generate(
      rollingNotificationDays,
      (index) => _calculatePrayerTime(
        config,
        today.add(Duration(days: index)),
      ),
    );

    await _persistConfig(config);
    await _persistPrayerCache(todayPrayerTime, _todayCachePrefsKey, config);
    await _persistPrayerCache(
        tomorrowPrayerTime, _tomorrowCachePrefsKey, config);

    if (scheduleNotifications) {
      try {
        await NotificationService().schedulePrayerNotificationsForDays(
          rollingPrayerTimes,
          timeZoneName: config.timeZone,
        );
      } catch (_) {
        // Timings must remain visible and cached even if Android permissions
        // temporarily block OS-level alarm scheduling.
      }
    }

    final next = _findNextPrayer(todayPrayerTime, tomorrowPrayerTime);
    final scheduled = await _safePrayerScheduleDebug();

    return PrayerTimesViewData(
      prayerTime: todayPrayerTime,
      tomorrowPrayerTime: tomorrowPrayerTime,
      hijriDate: _formatHijriDate(_hijriFromGregorian(today)),
      timeZone: config.timeZone,
      calculationMethod: _calculationLabel(config.calculationMethod),
      madhab: _madhabLabel(config.madhab),
      latitude: config.latitude,
      longitude: config.longitude,
      nextPrayerName: next.name,
      nextPrayerTime: next.time,
      nextPrayerRemaining: next.remaining,
      scheduledNotifications: scheduled
          .map(
            (item) => PrayerScheduleDebugItem(
              id: item.id,
              title: item.title,
              scheduledTime: item.scheduledTime,
              pendingInOs: item.pendingInOs,
            ),
          )
          .toList(),
    );
  }

  Future<void> ensurePrayerNotificationsScheduled() async {
    await fetchPrayerTimesView(
      refreshLocation: false,
      scheduleNotifications: true,
    );
  }

  Future<void> useManualLocation(PrayerLocationPreset preset) async {
    final config = await loadConfig();
    final deviceTimeZone = await resolveDeviceTimeZone();
    await _persistConfig(
      config.copyWith(
        latitude: preset.latitude,
        longitude: preset.longitude,
        location: preset.label,
        timeZone: deviceTimeZone,
        automaticLocation: false,
      ),
    );
    await ensurePrayerNotificationsScheduled();
  }

  Future<void> useAutomaticLocation() async {
    final config = await _resolveConfig(refreshLocation: true);
    await _persistConfig(config.copyWith(automaticLocation: true));
    await ensurePrayerNotificationsScheduled();
  }

  Future<void> setCalculationMethod(String methodId) async {
    final config = await loadConfig();
    await _persistConfig(config.copyWith(calculationMethod: methodId));
    await ensurePrayerNotificationsScheduled();
  }

  Future<void> setMadhab(String madhab) async {
    final config = await loadConfig();
    await _persistConfig(config.copyWith(madhab: madhab));
    await ensurePrayerNotificationsScheduled();
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

  Future<PrayerTime> calculatePrayerTimeForDate({
    required DateTime date,
    double latitude = defaultLatitude,
    double longitude = defaultLongitude,
    String location = defaultLocation,
    String timeZone = defaultTimeZone,
    String calculationMethod = defaultCalculationMethod,
    String madhab = defaultMadhab,
  }) async {
    tzdata.initializeTimeZones();
    return _calculatePrayerTime(
      PrayerConfig(
        latitude: latitude,
        longitude: longitude,
        location: location,
        timeZone: timeZone,
        calculationMethod: _normalizeCalculationMethod(calculationMethod),
        madhab: _normalizeMadhab(madhab),
        automaticLocation: false,
      ),
      date,
    );
  }

  Future<PrayerConfig> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_configPrefsKey);
    if (raw == null) return PrayerConfig.defaults(resolveDeviceTimeZoneSync());
    try {
      return PrayerConfig.fromJson(json.decode(raw) as Map<String, dynamic>);
    } catch (_) {
      return PrayerConfig.defaults(resolveDeviceTimeZoneSync());
    }
  }

  Future<String> resolveDeviceTimeZone() async {
    try {
      return (await FlutterTimezone.getLocalTimezone()).identifier;
    } catch (_) {
      return resolveDeviceTimeZoneSync();
    }
  }

  String resolveDeviceTimeZoneSync() {
    final now = DateTime.now();
    final abbreviation = now.timeZoneName.toUpperCase();
    final minutes = now.timeZoneOffset.inMinutes;

    if (abbreviation == 'PKT' || minutes == 300) return 'Asia/Karachi';
    if (abbreviation == 'IST' && minutes == 330) return 'Asia/Kolkata';
    if (abbreviation == 'BST' && minutes == 360) return 'Asia/Dhaka';
    if (abbreviation == 'GST' && minutes == 240) return 'Asia/Dubai';
    if (abbreviation == 'AST' && minutes == 180) return 'Asia/Riyadh';
    if (abbreviation == 'CET' && minutes == 60) return 'Europe/Paris';
    if (abbreviation == 'CEST' && minutes == 120) return 'Europe/Paris';
    if (abbreviation == 'GMT' && minutes == 0) return 'Europe/London';
    if (abbreviation == 'BST' && minutes == 60) return 'Europe/London';
    if (abbreviation == 'EST' && minutes == -300) return 'America/New_York';
    if (abbreviation == 'EDT' && minutes == -240) return 'America/New_York';
    if (abbreviation == 'CST' && minutes == -360) return 'America/Chicago';
    if (abbreviation == 'CDT' && minutes == -300) return 'America/Chicago';
    if (abbreviation == 'MST' && minutes == -420) return 'America/Denver';
    if (abbreviation == 'MDT' && minutes == -360) return 'America/Denver';
    if (abbreviation == 'PST' && minutes == -480) return 'America/Los_Angeles';
    if (abbreviation == 'PDT' && minutes == -420) return 'America/Los_Angeles';
    return minutes == 300 ? defaultTimeZone : 'UTC';
  }

  String getNextPrayerTime(PrayerTime prayerTime) {
    return _findNextPrayer(prayerTime, prayerTime).name;
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
    return _formatHijriDate(_hijriFromGregorian(gregorianDate));
  }

  Future<PrayerConfig> _resolveConfig({
    double? latitude,
    double? longitude,
    String? location,
    String? timeZone,
    String? calculationMethod,
    String? madhab,
    bool refreshLocation = false,
  }) async {
    var config = await loadConfig();
    final deviceTimeZone = timeZone ?? await resolveDeviceTimeZone();

    config = config.copyWith(
      latitude: latitude,
      longitude: longitude,
      location: location,
      timeZone: deviceTimeZone,
      calculationMethod: calculationMethod,
      madhab: madhab,
    );

    if (refreshLocation && config.automaticLocation) {
      final position = await _tryGetCurrentPosition();
      if (position != null) {
        config = config.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
          location: 'Current location',
          timeZone: deviceTimeZone,
          automaticLocation: true,
        );
      }
    }

    return config;
  }

  Future<Position?> _tryGetCurrentPosition() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 8),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  PrayerTime _calculatePrayerTime(PrayerConfig config, DateTime date) {
    if (config.calculationMethod == defaultCalculationMethod) {
      return _calculateJafariaPrayerTime(config, date);
    }

    final location = _timeZoneLocation(config.timeZone);
    final offset = tz.TZDateTime(
      location,
      date.year,
      date.month,
      date.day,
      12,
    ).timeZoneOffset;
    final coordinates = adhan.Coordinates(config.latitude, config.longitude);
    final parameters = _calculationParameters(config);
    final prayerTimes = adhan.PrayerTimes.utcOffset(
      coordinates,
      adhan.DateComponents(date.year, date.month, date.day),
      parameters,
      offset,
    );

    return PrayerTime()
      ..date = _dateOnly(date)
      ..fajr = _formatTime(prayerTimes.fajr)
      ..sunrise = _formatTime(prayerTimes.sunrise)
      ..dhuhr = _formatTime(prayerTimes.dhuhr)
      ..asr = _formatTime(prayerTimes.asr)
      ..maghrib = _formatTime(prayerTimes.maghrib)
      ..isha = _formatTime(prayerTimes.isha)
      ..location = config.location
      ..lastUpdated = DateTime.now()
      ..dateIndex = _dateOnly(date);
  }

  PrayerTime _calculateJafariaPrayerTime(PrayerConfig config, DateTime date) {
    final location = _timeZoneLocation(config.timeZone);
    final offset = tz.TZDateTime(
          location,
          date.year,
          date.month,
          date.day,
          12,
        ).timeZoneOffset.inMinutes /
        60;
    final times = _calculateJafariaCore(
      date: date,
      latitude: config.latitude,
      longitude: config.longitude,
      timeZoneOffsetHours: offset,
      asrFactor: config.madhab == 'hanafi' ? 2 : 1,
    );

    return PrayerTime()
      ..date = _dateOnly(date)
      ..fajr = _formatDecimalHour(times.fajr)
      ..sunrise = _formatDecimalHour(times.sunrise)
      ..dhuhr = _formatDecimalHour(times.dhuhr)
      ..asr = _formatDecimalHour(times.asr)
      ..maghrib = _formatDecimalHour(times.maghrib)
      ..isha = _formatDecimalHour(times.isha)
      ..location = config.location
      ..lastUpdated = DateTime.now()
      ..dateIndex = _dateOnly(date);
  }

  adhan.CalculationParameters _calculationParameters(PrayerConfig config) {
    final parameters = switch (config.calculationMethod) {
      'karachi' => adhan.CalculationMethod.karachi.getParameters(),
      'muslim_world_league' =>
        adhan.CalculationMethod.muslim_world_league.getParameters(),
      'moon_sighting_committee' =>
        adhan.CalculationMethod.moon_sighting_committee.getParameters(),
      'umm_al_qura' => adhan.CalculationMethod.umm_al_qura.getParameters(),
      _ => adhan.CalculationParameters(
          fajrAngle: 16.0,
          ishaAngle: 14.0,
          maghribAngle: 4.0,
          method: adhan.CalculationMethod.other,
        ),
    };
    parameters.madhab =
        config.madhab == 'hanafi' ? adhan.Madhab.hanafi : adhan.Madhab.shafi;
    return parameters;
  }

  _JafariaDecimalTimes _calculateJafariaCore({
    required DateTime date,
    required double latitude,
    required double longitude,
    required double timeZoneOffsetHours,
    required int asrFactor,
  }) {
    final jd =
        _julianDay(date.year, date.month, date.day) - longitude / (15 * 24);

    double midDay(double time) {
      final sun = _sunPosition(jd + time);
      return _fixHour(12 - sun.equation);
    }

    double sunAngleTime(
      double angle,
      double time, {
      bool counterClockwise = false,
    }) {
      final sun = _sunPosition(jd + time);
      final declination = sun.declination;
      final noon = midDay(time);
      final x = (-_sinDeg(angle) - _sinDeg(latitude) * _sinDeg(declination)) /
          (_cosDeg(latitude) * _cosDeg(declination));
      if (x < -1 || x > 1 || x.isNaN) return double.nan;
      final t = _acosDeg(x) / 15;
      return noon + (counterClockwise ? -t : t);
    }

    double asrTime(int factor, double time) {
      final sun = _sunPosition(jd + time);
      final angle = -_atan2Deg(
        1,
        factor + _tanDeg((latitude - sun.declination).abs()),
      );
      return sunAngleTime(angle, time);
    }

    var times = const _JafariaDecimalTimes(
      fajr: 5,
      sunrise: 6,
      dhuhr: 12,
      asr: 13,
      sunset: 18,
      maghrib: 18,
      isha: 18,
    );

    for (var i = 0; i < 2; i++) {
      times = _JafariaDecimalTimes(
        fajr: sunAngleTime(16, times.fajr / 24, counterClockwise: true),
        sunrise:
            sunAngleTime(0.833, times.sunrise / 24, counterClockwise: true),
        dhuhr: midDay(times.dhuhr / 24),
        asr: asrTime(asrFactor, times.asr / 24),
        sunset: sunAngleTime(0.833, times.sunset / 24),
        maghrib: sunAngleTime(4, times.maghrib / 24),
        isha: sunAngleTime(14, times.isha / 24),
      );
    }

    final adjustment = timeZoneOffsetHours - longitude / 15;
    return _JafariaDecimalTimes(
      fajr: _adjustDecimalHour(times.fajr, adjustment),
      sunrise: _adjustDecimalHour(times.sunrise, adjustment),
      dhuhr: _adjustDecimalHour(times.dhuhr, adjustment),
      asr: _adjustDecimalHour(times.asr, adjustment),
      sunset: _adjustDecimalHour(times.sunset, adjustment),
      maghrib: _adjustDecimalHour(times.maghrib, adjustment),
      isha: _adjustDecimalHour(times.isha, adjustment),
    );
  }

  double _adjustDecimalHour(double hour, double adjustment) {
    if (!hour.isFinite) return double.nan;
    return _fixHour(hour + adjustment);
  }

  double _julianDay(int year, int month, int day) {
    var y = year;
    var m = month;
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day +
        b -
        1524.5;
  }

  _SunPosition _sunPosition(double julianDay) {
    final days = julianDay - 2451545.0;
    final meanAnomaly = _fixAngle(357.529 + 0.98560028 * days);
    final meanLongitude = _fixAngle(280.459 + 0.98564736 * days);
    final eclipticLongitude = _fixAngle(
      meanLongitude +
          1.915 * _sinDeg(meanAnomaly) +
          0.020 * _sinDeg(2 * meanAnomaly),
    );
    final obliquity = 23.439 - 0.00000036 * days;

    var rightAscension = _atan2Deg(
          _cosDeg(obliquity) * _sinDeg(eclipticLongitude),
          _cosDeg(eclipticLongitude),
        ) /
        15;
    rightAscension = _fixHour(rightAscension);

    final declination = _asinDeg(
      _sinDeg(obliquity) * _sinDeg(eclipticLongitude),
    );
    var equation = meanLongitude / 15 - rightAscension;
    if (equation > 12) equation -= 24;
    if (equation < -12) equation += 24;
    return _SunPosition(declination: declination, equation: equation);
  }

  String _formatDecimalHour(double decimalHour) {
    if (!decimalHour.isFinite) return 'N/A';
    final fixed = _fixHour(decimalHour);
    var hour = fixed.floor();
    var minute = ((fixed - hour) * 60).round();
    if (minute == 60) {
      minute = 0;
      hour = (hour + 1) % 24;
    }
    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }

  double _fixAngle(double angle) => ((angle % 360) + 360) % 360;

  double _fixHour(double hour) => ((hour % 24) + 24) % 24;

  double _sinDeg(double degree) => sin(degree * pi / 180);

  double _cosDeg(double degree) => cos(degree * pi / 180);

  double _tanDeg(double degree) => tan(degree * pi / 180);

  double _asinDeg(double value) => asin(value) * 180 / pi;

  double _acosDeg(double value) => acos(value) * 180 / pi;

  double _atan2Deg(double y, double x) => atan2(y, x) * 180 / pi;

  tz.Location _timeZoneLocation(String name) {
    try {
      return tz.getLocation(name);
    } catch (_) {
      return tz.getLocation('UTC');
    }
  }

  Future<void> _persistConfig(PrayerConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_configPrefsKey, json.encode(config.toJson()));
  }

  Future<void> _persistPrayerCache(
    PrayerTime prayerTime,
    String key,
    PrayerConfig config,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      key,
      json.encode({
        'date': prayerTime.date.toIso8601String(),
        'fajr': prayerTime.fajr,
        'sunrise': prayerTime.sunrise,
        'dhuhr': prayerTime.dhuhr,
        'asr': prayerTime.asr,
        'maghrib': prayerTime.maghrib,
        'isha': prayerTime.isha,
        'location': prayerTime.location,
        'timeZone': config.timeZone,
        'calculationMethod': config.calculationMethod,
        'madhab': config.madhab,
        'latitude': config.latitude,
        'longitude': config.longitude,
      }),
    );
  }

  _NextPrayer _findNextPrayer(PrayerTime today, PrayerTime tomorrow) {
    final now = DateTime.now();
    final prayers = <_PrayerCandidate>[
      _PrayerCandidate('Fajar', today.fajr, today.date),
      _PrayerCandidate('Sunrise', today.sunrise, today.date),
      _PrayerCandidate('Zuhr', today.dhuhr, today.date),
      _PrayerCandidate('Asr', today.asr, today.date),
      _PrayerCandidate('Maghrib', today.maghrib, today.date),
      _PrayerCandidate('Isha', today.isha, today.date),
      _PrayerCandidate('Fajar', tomorrow.fajr, tomorrow.date),
    ];

    for (final prayer in prayers) {
      final dateTime = _dateTimeForDisplayTime(prayer.time, prayer.date);
      if (dateTime != null && dateTime.isAfter(now)) {
        return _NextPrayer(
          prayer.name,
          prayer.time,
          dateTime.difference(now),
        );
      }
    }

    return _NextPrayer('Fajar', tomorrow.fajr, null);
  }

  DateTime? _dateTimeForDisplayTime(String time, DateTime date) {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _calculationLabel(String id) {
    return calculationOptions
        .firstWhere(
          (option) => option.id == id,
          orElse: () => calculationOptions.first,
        )
        .label;
  }

  String _madhabLabel(String id) {
    return 'Jafari Asr';
  }

  String _formatHijriDate(_HijriDate hijri) {
    return '${hijri.day} ${_monthName(hijri.month)} ${hijri.year} H';
  }
}

class PrayerConfig {
  final double latitude;
  final double longitude;
  final String location;
  final String timeZone;
  final String calculationMethod;
  final String madhab;
  final bool automaticLocation;

  const PrayerConfig({
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.timeZone,
    required this.calculationMethod,
    required this.madhab,
    required this.automaticLocation,
  });

  factory PrayerConfig.defaults(String timeZone) {
    return PrayerConfig(
      latitude: PrayerTimesService.defaultLatitude,
      longitude: PrayerTimesService.defaultLongitude,
      location: PrayerTimesService.defaultLocation,
      timeZone: timeZone,
      calculationMethod: PrayerTimesService.defaultCalculationMethod,
      madhab: PrayerTimesService.defaultMadhab,
      automaticLocation: false,
    );
  }

  factory PrayerConfig.fromJson(Map<String, dynamic> json) {
    return PrayerConfig(
      latitude: (json['latitude'] as num?)?.toDouble() ??
          PrayerTimesService.defaultLatitude,
      longitude: (json['longitude'] as num?)?.toDouble() ??
          PrayerTimesService.defaultLongitude,
      location:
          json['location'] as String? ?? PrayerTimesService.defaultLocation,
      timeZone:
          json['timeZone'] as String? ?? PrayerTimesService.defaultTimeZone,
      calculationMethod:
          _normalizeCalculationMethod(json['calculationMethod'] as String?),
      madhab: _normalizeMadhab(json['madhab'] as String?),
      automaticLocation: json['automaticLocation'] as bool? ?? false,
    );
  }

  PrayerConfig copyWith({
    double? latitude,
    double? longitude,
    String? location,
    String? timeZone,
    String? calculationMethod,
    String? madhab,
    bool? automaticLocation,
  }) {
    return PrayerConfig(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
      timeZone: timeZone ?? this.timeZone,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      automaticLocation: automaticLocation ?? this.automaticLocation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'timeZone': timeZone,
      'calculationMethod': calculationMethod,
      'madhab': madhab,
      'automaticLocation': automaticLocation,
    };
  }
}

Future<List<NotificationScheduleDebugEntry>> _safePrayerScheduleDebug() async {
  try {
    return await NotificationService().getPrayerScheduleDebug();
  } catch (_) {
    return const [];
  }
}

String _normalizeCalculationMethod(String? raw) {
  return PrayerTimesService.defaultCalculationMethod;
}

String _normalizeMadhab(String? raw) {
  return PrayerTimesService.defaultMadhab;
}

class _PrayerCandidate {
  final String name;
  final String time;
  final DateTime date;

  const _PrayerCandidate(this.name, this.time, this.date);
}

class _JafariaDecimalTimes {
  final double fajr;
  final double sunrise;
  final double dhuhr;
  final double asr;
  final double sunset;
  final double maghrib;
  final double isha;

  const _JafariaDecimalTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
  });
}

class _SunPosition {
  final double declination;
  final double equation;

  const _SunPosition({
    required this.declination,
    required this.equation,
  });
}

class _NextPrayer {
  final String name;
  final String time;
  final Duration? remaining;

  const _NextPrayer(this.name, this.time, this.remaining);
}

class _HijriDate {
  final int year;
  final int month;
  final int day;

  const _HijriDate(this.year, this.month, this.day);
}

_HijriDate _hijriFromGregorian(DateTime date) {
  final jd = _gregorianToJulianDay(date.year, date.month, date.day);
  final year = ((30 * (jd - 1948439.5) + 10646) / 10631).floor();
  final month = min(
    12,
    ((jd - (29 + _islamicToJulianDay(year, 1, 1))) / 29.5).ceil() + 1,
  );
  final day = (jd - _islamicToJulianDay(year, month, 1) + 1).floor();
  return _HijriDate(year, month, day);
}

double _islamicToJulianDay(int year, int month, int day) {
  return day +
      (29.5 * (month - 1)).ceil() +
      (year - 1) * 354 +
      ((3 + 11 * year) / 30).floor() +
      1948439.5 -
      1;
}

double _gregorianToJulianDay(int year, int month, int day) {
  final a = ((14 - month) / 12).floor();
  final y = year + 4800 - a;
  final m = month + 12 * a - 3;
  return day +
      ((153 * m + 2) / 5).floor() +
      365 * y +
      (y / 4).floor() -
      (y / 100).floor() +
      (y / 400).floor() -
      32045;
}

String _monthName(int month) {
  const months = [
    'Muharram',
    'Safar',
    'Rabi ul Awwal',
    'Rabi us Sani',
    'Jamadi ul Awwal',
    'Jamadi us Sani',
    'Rajab',
    'Shaban',
    'Ramadhan',
    'Shawwal',
    'Zilqad',
    'Zilhajj',
  ];
  if (month < 1 || month > months.length) return '';
  return months[month - 1];
}
