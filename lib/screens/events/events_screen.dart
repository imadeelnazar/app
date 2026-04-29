import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_chrome.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedMonth = _hijriFromGregorian(DateTime.now()).month;
  String _eventType = 'all';

  Future<List<IslamicEvent>> _loadEvents() async {
    final indexString =
        await rootBundle.loadString('assets/json/events/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final files = items.map((item) => item['file'] as String).toSet();
    final events = <IslamicEvent>[];

    for (final file in files) {
      final fileString =
          await rootBundle.loadString('assets/json/events/$file');
      final data = json.decode(fileString) as Map<String, dynamic>;
      final monthEvents =
          List<Map<String, dynamic>>.from(data['events'] as List? ?? []);
      events.addAll(monthEvents.map(IslamicEvent.fromJson));
    }

    events.sort((a, b) {
      final monthCompare = a.hijriMonthNumber.compareTo(b.hijriMonthNumber);
      return monthCompare != 0
          ? monthCompare
          : a.hijriDay.compareTo(b.hijriDay);
    });
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Islamic Events'),
          backgroundColor: hidayatGreen,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Month'),
            ],
          ),
        ),
        bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
        body: FutureBuilder<List<IslamicEvent>>(
          future: _loadEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Unable to load events: ${snapshot.error}'));
            }

            final events = snapshot.data ?? [];
            return TabBarView(
              children: [
                _TodayEvents(events: events),
                _UpcomingEvents(events: events),
                _MonthEvents(
                  events: events,
                  selectedMonth: _selectedMonth,
                  eventType: _eventType,
                  onMonthChanged: (value) =>
                      setState(() => _selectedMonth = value),
                  onEventTypeChanged: (value) =>
                      setState(() => _eventType = value),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TodayEvents extends StatelessWidget {
  final List<IslamicEvent> events;

  const _TodayEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    final today = _hijriFromGregorian(DateTime.now());
    final todaysEvents = events
        .where(
          (event) =>
              event.hijriMonthNumber == today.month &&
              event.hijriDay == today.day,
        )
        .toList();

    if (todaysEvents.isEmpty) {
      return Center(
        child: Text(
          'No event for ${_monthName(today.month)} ${today.day}',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: todaysEvents.map(_EventCard.new).toList(),
    );
  }
}

class _UpcomingEvents extends StatelessWidget {
  final List<IslamicEvent> events;

  const _UpcomingEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final currentHijri = _hijriFromGregorian(today);
    final upcoming = events
        .map((event) =>
            _UpcomingEvent(event, _nextGregorianDate(event, currentHijri)))
        .where((item) =>
            !item.date.isBefore(DateTime(today.year, today.month, today.day)))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return ListView(
      padding: const EdgeInsets.all(12),
      children: upcoming.take(30).map((item) {
        return _EventCard(
          item.event,
          trailingText: _formatGregorian(item.date),
        );
      }).toList(),
    );
  }
}

class _MonthEvents extends StatelessWidget {
  final List<IslamicEvent> events;
  final int selectedMonth;
  final String eventType;
  final ValueChanged<int> onMonthChanged;
  final ValueChanged<String> onEventTypeChanged;

  const _MonthEvents({
    required this.events,
    required this.selectedMonth,
    required this.eventType,
    required this.onMonthChanged,
    required this.onEventTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final eventTypes = [
      'all',
      ...events.map((event) => event.eventType).toSet().toList()..sort()
    ];
    final filtered = events.where((event) {
      final monthMatches = event.hijriMonthNumber == selectedMonth;
      final typeMatches = eventType == 'all' || event.eventType == eventType;
      return monthMatches && typeMatches;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: selectedMonth,
                  decoration: const InputDecoration(
                    labelText: 'Hijri month',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (var month = 1; month <= 12; month++)
                      DropdownMenuItem(
                        value: month,
                        child: Text(_monthName(month)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) onMonthChanged(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: eventType,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final type in eventTypes)
                      DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) onEventTypeChanged(value);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            children: filtered.map(_EventCard.new).toList(),
          ),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final IslamicEvent event;
  final String? trailingText;

  const _EventCard(this.event, {this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B4D3E).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${event.hijriDay}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _monthShortName(event.hijriMonthNumber),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (event.titleUrdu.isNotEmpty)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(event.titleUrdu),
                        ),
                      Text('${event.eventType} - ${event.category}'),
                      if (event.relatedPersonality.isNotEmpty)
                        Text(event.relatedPersonality),
                    ],
                  ),
                ),
                if (trailingText != null) Text(trailingText!),
              ],
            ),
            if (event.recommendedDuas.isNotEmpty ||
                event.recommendedZiyaraat.isNotEmpty ||
                event.recommendedAamaal.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final id in event.recommendedAamaal)
                    Chip(label: Text(id), visualDensity: VisualDensity.compact),
                  for (final id in event.recommendedDuas)
                    Chip(label: Text(id), visualDensity: VisualDensity.compact),
                  for (final id in event.recommendedZiyaraat)
                    Chip(label: Text(id), visualDensity: VisualDensity.compact),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class IslamicEvent {
  final String id;
  final String title;
  final String titleUrdu;
  final String category;
  final int hijriMonthNumber;
  final int hijriDay;
  final String eventType;
  final String relatedPersonality;
  final List<String> recommendedAamaal;
  final List<String> recommendedDuas;
  final List<String> recommendedZiyaraat;

  const IslamicEvent({
    required this.id,
    required this.title,
    required this.titleUrdu,
    required this.category,
    required this.hijriMonthNumber,
    required this.hijriDay,
    required this.eventType,
    required this.relatedPersonality,
    required this.recommendedAamaal,
    required this.recommendedDuas,
    required this.recommendedZiyaraat,
  });

  factory IslamicEvent.fromJson(Map<String, dynamic> json) {
    return IslamicEvent(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleUrdu: json['titleUrdu'] as String? ?? '',
      category: json['category'] as String? ?? '',
      hijriMonthNumber: json['hijriMonthNumber'] as int? ?? 0,
      hijriDay: json['hijriDay'] as int? ?? 0,
      eventType: json['eventType'] as String? ?? '',
      relatedPersonality: json['relatedPersonality'] as String? ?? '',
      recommendedAamaal:
          List<String>.from(json['recommendedAamaal'] as List? ?? []),
      recommendedDuas:
          List<String>.from(json['recommendedDuas'] as List? ?? []),
      recommendedZiyaraat:
          List<String>.from(json['recommendedZiyaraat'] as List? ?? []),
    );
  }
}

class _HijriDate {
  final int year;
  final int month;
  final int day;

  const _HijriDate(this.year, this.month, this.day);
}

class _UpcomingEvent {
  final IslamicEvent event;
  final DateTime date;

  const _UpcomingEvent(this.event, this.date);
}

DateTime _nextGregorianDate(IslamicEvent event, _HijriDate currentHijri) {
  var hijriYear = currentHijri.year;
  var date =
      _gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  if (date.isBefore(todayDate)) {
    hijriYear += 1;
    date =
        _gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
  }
  return date;
}

_HijriDate _hijriFromGregorian(DateTime date) {
  final jd = _gregorianToJulianDay(date.year, date.month, date.day);
  final year = ((30 * (jd - 1948439.5) + 10646) / 10631).floor();
  final month = math.min(
    12,
    ((jd - (29 + _islamicToJulianDay(year, 1, 1))) / 29.5).ceil() + 1,
  );
  final day = (jd - _islamicToJulianDay(year, month, 1) + 1).floor();
  return _HijriDate(year, month, day);
}

DateTime _gregorianFromHijri(int year, int month, int day) {
  final jd = _islamicToJulianDay(year, month, day).floor();
  return _julianDayToGregorian(jd);
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

DateTime _julianDayToGregorian(int jd) {
  final a = jd + 32044;
  final b = ((4 * a + 3) / 146097).floor();
  final c = a - ((146097 * b) / 4).floor();
  final d = ((4 * c + 3) / 1461).floor();
  final e = c - ((1461 * d) / 4).floor();
  final m = ((5 * e + 2) / 153).floor();
  final day = e - ((153 * m + 2) / 5).floor() + 1;
  final month = m + 3 - 12 * (m / 10).floor();
  final year = 100 * b + d - 4800 + (m / 10).floor();
  return DateTime(year, month, day);
}

String _formatGregorian(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]}';
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
  return months[month - 1];
}

String _monthShortName(int month) {
  const months = [
    'Muh',
    'Saf',
    'Rab I',
    'Rab II',
    'Jam I',
    'Jam II',
    'Raj',
    'Sha',
    'Ram',
    'Shaw',
    'Ziq',
    'Zih',
  ];
  return months[month - 1];
}
