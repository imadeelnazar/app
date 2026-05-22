import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../widgets/app_chrome.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _selectedIndex = 0;
  int _count = 0;
  int _sessionTotal = 0;

  _TasbeehPreset get _preset => _jafriyaTasbeehPresets[_selectedIndex];

  void _increment() {
    setState(() {
      _count++;
      _sessionTotal++;
    });
  }

  void _undo() {
    if (_count == 0) return;
    setState(() {
      _count--;
      if (_sessionTotal > 0) _sessionTotal--;
    });
  }

  void _reset() {
    setState(() => _count = 0);
  }

  void _selectPreset(int index) {
    setState(() {
      _selectedIndex = index;
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final preset = _preset;
    final progress = preset.target == null
        ? 0.0
        : (_count / preset.target!).clamp(0.0, 1.0).toDouble();
    final remaining =
        preset.target == null ? null : math.max(preset.target! - _count, 0);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2EA),
      appBar: haqaiqAppBar(context, title: 'Tasbeeh'),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _TasbeehHeroCard(
            preset: preset,
            count: _count,
            progress: progress,
            remaining: remaining,
            onTap: _increment,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _SmallActionButton(
                  icon: Icons.undo,
                  label: 'Undo',
                  onTap: _undo,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SmallActionButton(
                  icon: Icons.refresh,
                  label: 'Reset',
                  onTap: _reset,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SessionSummary(total: _sessionTotal),
          const SizedBox(height: 22),
          const Text(
            'Fiqa Jafriya Tasbeeh',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF163E36),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(_jafriyaTasbeehPresets.length, (index) {
            final item = _jafriyaTasbeehPresets[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PresetTile(
                preset: item,
                selected: index == _selectedIndex,
                onTap: () => _selectPreset(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TasbeehHeroCard extends StatelessWidget {
  final _TasbeehPreset preset;
  final int count;
  final double progress;
  final int? remaining;
  final VoidCallback onTap;

  const _TasbeehHeroCard({
    required this.preset,
    required this.count,
    required this.progress,
    required this.remaining,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF102D28),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1BA098).withValues(alpha: 0.24),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(preset.icon, color: preset.accent, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        preset.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        preset.note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size.square(250),
                      painter: _ProgressRingPainter(
                        progress: progress,
                        color: preset.accent,
                      ),
                    ),
                    Container(
                      width: 184,
                      height: 184,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            preset.accent.withValues(alpha: 0.92),
                            const Color(0xFF1BA098),
                            const Color(0xFF0E4039),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: preset.accent.withValues(alpha: 0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 120),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              '$count',
                              key: ValueKey(count),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 58,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            preset.target == null
                                ? 'Tap to count'
                                : 'of ${preset.target}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              preset.arabic,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 1.35,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              preset.transliteration,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (remaining != null) ...[
              const SizedBox(height: 14),
              Text(
                remaining == 0
                    ? 'Target complete'
                    : '$remaining remaining for this tasbeeh',
                style: TextStyle(
                  color: remaining == 0 ? preset.accent : Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SmallActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: haqaiqTeal, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF163E36),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionSummary extends StatelessWidget {
  final int total;

  const _SessionSummary({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5DDD0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFD4A574)),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Session total',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
          ),
          Text(
            '$total',
            style: const TextStyle(
              color: Color(0xFF1BA098),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  final _TasbeehPreset preset;
  final bool selected;
  final VoidCallback onTap;

  const _PresetTile({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFE7F6F3) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? haqaiqTeal : const Color(0xFFE5DDD0),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: preset.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(preset.icon, color: preset.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      preset.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF163E36),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      preset.arabic,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                preset.target == null ? '--' : '${preset.target}',
                style: TextStyle(
                  color: selected ? haqaiqTeal : Colors.grey.shade500,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _ProgressRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 10;
    final background = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final foreground = Paint()
      ..shader = SweepGradient(
        colors: [color, const Color(0xFFD4A574), color],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, background);
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        progress * math.pi * 2,
        false,
        foreground,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _TasbeehPreset {
  final String title;
  final String arabic;
  final String transliteration;
  final String note;
  final int? target;
  final IconData icon;
  final Color accent;

  const _TasbeehPreset({
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.note,
    required this.target,
    required this.icon,
    required this.accent,
  });
}

const List<_TasbeehPreset> _jafriyaTasbeehPresets = [
  _TasbeehPreset(
    title: 'Tasbih-e-Fatima Zahra S.A',
    arabic: 'الله أكبر ٣٤ • الحمد لله ٣٣ • سبحان الله ٣٣',
    transliteration: 'Allahu Akbar 34, Alhamdulillah 33, Subhanallah 33',
    note: 'Recommended after wajib prayers',
    target: 100,
    icon: Icons.brightness_5,
    accent: Color(0xFFD4A574),
  ),
  _TasbeehPreset(
    title: 'Salawat',
    arabic: 'اللهم صل على محمد وآل محمد',
    transliteration: 'Allahumma salli ala Muhammad wa Aale Muhammad',
    note: 'Blessings upon Muhammad and Aal-e-Muhammad',
    target: 100,
    icon: Icons.favorite,
    accent: Color(0xFFE95B7A),
  ),
  _TasbeehPreset(
    title: 'Istighfar',
    arabic: 'أستغفر الله ربي وأتوب إليه',
    transliteration: 'Astaghfirullaha Rabbi wa atubu ilayh',
    note: 'For forgiveness and return to Allah',
    target: 100,
    icon: Icons.water_drop,
    accent: Color(0xFF4DB6E8),
  ),
  _TasbeehPreset(
    title: 'Subhanallah',
    arabic: 'سبحان الله',
    transliteration: 'Subhanallah',
    note: 'Glory be to Allah',
    target: 33,
    icon: Icons.auto_awesome,
    accent: Color(0xFF8E7BF2),
  ),
  _TasbeehPreset(
    title: 'Alhamdulillah',
    arabic: 'الحمد لله',
    transliteration: 'Alhamdulillah',
    note: 'All praise belongs to Allah',
    target: 33,
    icon: Icons.wb_sunny,
    accent: Color(0xFFFFA726),
  ),
  _TasbeehPreset(
    title: 'Allahu Akbar',
    arabic: 'الله أكبر',
    transliteration: 'Allahu Akbar',
    note: 'Allah is the Greatest',
    target: 34,
    icon: Icons.expand_less,
    accent: Color(0xFF1BA098),
  ),
  _TasbeehPreset(
    title: 'La ilaha illa Allah',
    arabic: 'لا إله إلا الله',
    transliteration: 'La ilaha illa Allah',
    note: 'There is no god but Allah',
    target: 100,
    icon: Icons.circle_outlined,
    accent: Color(0xFF607D8B),
  ),
  _TasbeehPreset(
    title: 'Free Tasbeeh',
    arabic: 'ذكر مفتوح',
    transliteration: 'Open dhikr counter',
    note: 'Count any dua or dhikr',
    target: null,
    icon: Icons.touch_app,
    accent: Color(0xFF1BA098),
  ),
];
