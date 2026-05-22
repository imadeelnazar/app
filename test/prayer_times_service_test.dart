import 'package:flutter_test/flutter_test.dart';
import 'package:hidayat/services/prayer_times_service.dart';

void main() {
  test('matches attached HTML calculator for Lahore on 22 May 2026', () async {
    final prayerTime = await PrayerTimesService().calculatePrayerTimeForDate(
      date: DateTime(2026, 5, 22),
      latitude: 31.5204,
      longitude: 74.3587,
      location: 'Lahore, Pakistan',
      timeZone: 'Asia/Karachi',
      calculationMethod: 'jafari_qum',
      madhab: 'jafari',
    );

    expect(prayerTime.fajr, '03:40');
    expect(prayerTime.sunrise, '05:02');
    expect(prayerTime.dhuhr, '11:59');
    expect(prayerTime.asr, '15:39');
    expect(prayerTime.maghrib, '19:13');
    expect(prayerTime.isha, '20:08');
  });

  test('matches attached HTML calculator for Karachi on 22 May 2026', () async {
    final prayerTime = await PrayerTimesService().calculatePrayerTimeForDate(
      date: DateTime(2026, 5, 22),
      latitude: 24.8607,
      longitude: 67.0011,
      location: 'Karachi, Pakistan',
      timeZone: 'Asia/Karachi',
      calculationMethod: 'jafari_qum',
      madhab: 'jafari',
    );

    expect(prayerTime.fajr, '04:30');
    expect(prayerTime.sunrise, '05:45');
    expect(prayerTime.dhuhr, '12:29');
    expect(prayerTime.asr, '15:53');
    expect(prayerTime.maghrib, '19:28');
    expect(prayerTime.isha, '20:18');
  });
}
