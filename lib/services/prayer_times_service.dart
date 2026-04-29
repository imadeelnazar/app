import 'package:dio/dio.dart';
import 'dart:math';
import '../data/models/models.dart';

class PrayerTimesService {
  static final PrayerTimesService _instance = PrayerTimesService._internal();
  late Dio _dio;

  factory PrayerTimesService() {
    return _instance;
  }

  PrayerTimesService._internal() {
    _dio = Dio();
  }

  Future<PrayerTime?> fetchPrayerTimes({
    required double latitude,
    required double longitude,
    required String location,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.aladhan.com/v1/timings',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': 2, // ISNA method
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data']['timings'];
        return PrayerTime()
          ..date = DateTime.now()
          ..dateIndex = DateTime.now()
          ..fajr = data['Fajr'] ?? ''
          ..sunrise = data['Sunrise'] ?? ''
          ..dhuhr = data['Dhuhr'] ?? ''
          ..asr = data['Asr'] ?? ''
          ..maghrib = data['Maghrib'] ?? ''
          ..isha = data['Isha'] ?? ''
          ..location = location
          ..lastUpdated = DateTime.now();
      }
    } catch (e) {
      print('Error fetching prayer times: $e');
    }
    return null;
  }

  String? getNextPrayerTime(PrayerTime prayerTime) {
    final now = DateTime.now();
    final prayers = [
      ('Fajr', prayerTime.fajr),
      ('Sunrise', prayerTime.sunrise),
      ('Dhuhr', prayerTime.dhuhr),
      ('Asr', prayerTime.asr),
      ('Maghrib', prayerTime.maghrib),
      ('Isha', prayerTime.isha),
    ];

    for (var prayer in prayers) {
      final prayerTime = _parseTime(prayer.$2);
      if (prayerTime != null && prayerTime.isAfter(now)) {
        return '${prayer.$1}: ${prayer.$2}';
      }
    }
    return null;
  }

  double calculateQiblaDirection(double latitude, double longitude) {
    // Kaaba coordinates (Makkah)
    const double makkahLat = 21.4225;
    const double makkahLng = 39.8262;

    final dLng = makkahLng - longitude;
    final y = sin(dLng * pi / 180) *
        cos(makkahLat * pi / 180);
    final x = cos(latitude * pi / 180) * sin(makkahLat * pi / 180) -
        sin(latitude * pi / 180) * cos(makkahLat * pi / 180) * cos(dLng * pi / 180);

    var qibla = atan2(y, x) * 180 / pi;
    qibla = (qibla + 360) % 360;
    return qibla;
  }

  String getIslamicDate(DateTime gregorianDate) {
    // Simplified Islamic date conversion
    // For accurate conversion, use a proper library
    final jd = _toJulianDay(gregorianDate);
    final n = jd - 1948440.5;
    final q = (n / 30.6001).floor();
    final k = (q / 11).floor();
    final year = k + 1;
    final month = q - 11 * k;
    final day = n - (30.6001 * q).floor();

    return '$day/$month/$year AH';
  }

  int _toJulianDay(DateTime date) {
    final a = (14 - date.month) ~/ 12;
    final y = date.year + 4800 - a;
    final m = date.month + 12 * a - 3;
    return date.day +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045;
  }

  DateTime? _parseTime(String timeString) {
    try {
      final parts = timeString.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    } catch (e) {
      return null;
    }
  }
}
