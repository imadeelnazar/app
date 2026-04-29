import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        backgroundColor: const Color(0xFF1BA098),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                        'Lahore, Pakistan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '9 Ramadhan 1445 H',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Update Location',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1BA098),
                            ),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.shade400,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Daily Prayer Times',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Fajr',
                icon: Icons.wb_twilight,
                time: '05:30 AM',
                color: const Color(0xFF6A4C93),
                bgColor: const Color(0xFFF3E5F5),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Sunrise',
                icon: Icons.wb_sunny_outlined,
                time: '07:15 AM',
                color: const Color(0xFFFFA500),
                bgColor: const Color(0xFFFFF3E0),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Dhuhr',
                icon: Icons.wb_sunny,
                time: '12:45 PM',
                color: const Color(0xFFFFA500),
                bgColor: const Color(0xFFFFF3E0),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Asr',
                icon: Icons.cloud,
                time: '04:15 PM',
                color: const Color(0xFFFF6B35),
                bgColor: const Color(0xFFFFEBEE),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Maghrib',
                icon: Icons.brightness_3,
                time: '07:30 PM',
                color: const Color(0xFFD4A574),
                bgColor: const Color(0xFFFFF8E1),
              ),
              const SizedBox(height: 12),
              _PrayerTimeItemCard(
                name: 'Isha',
                icon: Icons.nights_stay,
                time: '09:00 PM',
                color: const Color(0xFF264653),
                bgColor: const Color(0xFFE0F2F1),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE8E3D8)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Islamic Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '9 Ramadhan 1445 H',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1BA098),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
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
                color: color.withOpacity(0.2),
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
                color: Color(0xFF1BA098),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
