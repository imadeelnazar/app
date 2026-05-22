import 'package:flutter/material.dart';
import '../../services/islamic_event_calendar_service.dart' as calendar;
import '../../widgets/app_chrome.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedMonth = calendar.IslamicEventCalendarService.instance
      .hijriFromGregorian(DateTime.now())
      .month;
  String _eventType = 'all';

  Future<List<calendar.IslamicCalendarEvent>> _loadEvents() =>
      calendar.IslamicEventCalendarService.instance.loadEvents();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Islamic Events'),
          backgroundColor: primary,
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
        bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
        body: FutureBuilder<List<calendar.IslamicCalendarEvent>>(
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
  final List<calendar.IslamicCalendarEvent> events;

  const _TodayEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    final today = calendar.IslamicEventCalendarService.instance
        .hijriFromGregorian(DateTime.now());
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
          'No event for ${calendar.islamicMonthName(today.month)} ${today.day}',
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
  final List<calendar.IslamicCalendarEvent> events;

  const _UpcomingEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final upcoming = events
        .map(
          (event) => _UpcomingEvent(
            event,
            calendar.IslamicEventCalendarService.instance
                .nextGregorianDate(event),
          ),
        )
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
  final List<calendar.IslamicCalendarEvent> events;
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
                        child: Text(calendar.islamicMonthName(month)),
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
  final calendar.IslamicCalendarEvent event;
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
                        calendar.islamicMonthShortName(
                          event.hijriMonthNumber,
                        ),
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

class _UpcomingEvent {
  final calendar.IslamicCalendarEvent event;
  final DateTime date;

  const _UpcomingEvent(this.event, this.date);
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
