import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<String> sawabTickerNames = [
  'Molana Sadiq Ali Najafi',
  "Syeda hajira Khatoon",
  'Syed Muhammad Tahir Naqvi',
  'Syeda Farhat Tahir',
  'Syed Afzal Hussain Rizvi',
  'Zakira Syeda Kalsoom',
  'Syeda Rahat Kalsoom',
  'Syed Shahid Hassan Rizvi',
  'Syed Zahid Hassan Rizvi',
  'Syed Zahid Abbas Naqvi',
  'Dr Muhammad Ali Naqvi (Shaheed)',
  'Ama Bashiran',
  'Khala Bano',
  'Molana Hassan Zaheer Najfi',
  'Syeda Kaneez Fizza',
  'Syed Mazhar Abbas Naqvi',
  'Zakir Syed Hassan Askari',
  'Syeda Atiya Batool',
  'Zakir Syed Fakhar Abbas Naqvi',
  'Syeda Nayyar Zahra',
  'Syed Shoukat Rizvi',
  'Syed Zulfiqar Rizvi',
  'Syed Jaffar Abbas',
  'Syeda Fatima Shabbar',
  '',
  'Gulam ALi',
  'Nazar Ali',
  'Ijaz Hussain',
  'Fazal Ali',
  'Akram Ali',
  'Nimat Ali',
  'Mohammad Aslam'
];

String cleanSawabName(String name) {
  final cleaned = name
      .replaceAll(RegExp(r'[^A-Za-z0-9 .()\-]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  if (cleaned.toLowerCase() == 'syeda hajira khatoon') {
    return "Syeda Hajira Khatoon";
  }

  return cleaned;
}

final List<String> sawabDisplayNames =
    List.unmodifiable(sawabTickerNames.map(cleanSawabName));

class SawabTickerBar extends StatefulWidget {
  final bool showCloseButton;
  final VoidCallback? onClose;

  const SawabTickerBar({
    super.key,
    this.showCloseButton = false,
    this.onClose,
  });

  @override
  State<SawabTickerBar> createState() => _SawabTickerBarState();
}

class SawabTickerPageShell extends StatefulWidget {
  final Widget child;

  const SawabTickerPageShell({super.key, required this.child});

  @override
  State<SawabTickerPageShell> createState() => _SawabTickerPageShellState();
}

class _SawabTickerPageShellState extends State<SawabTickerPageShell> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            child: _visible
                ? SawabTickerBar(
                    key: const ValueKey('sawab-ticker-visible'),
                    showCloseButton: true,
                    onClose: () => setState(() => _visible = false),
                  )
                : const SizedBox.shrink(
                    key: ValueKey('sawab-ticker-hidden'),
                  ),
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

class _SawabTickerBarState extends State<SawabTickerBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final String _tickerText;

  static const TextStyle _tickerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    height: 1.2,
    decoration: TextDecoration.none,
  );

  @override
  void initState() {
    super.initState();
    _tickerText = sawabDisplayNames.join('     ');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 86),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF102E28), Color(0xFF1BA098)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  final currentPath = GoRouterState.of(context).uri.path;
                  if (currentPath != '/isal-e-sawab') {
                    context.push('/isal-e-sawab');
                  }
                },
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFD4A574).withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Isal-e-Sawab',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _NewsMarquee(
                  controller: _controller,
                  text: _tickerText,
                  textStyle: _tickerTextStyle,
                ),
              ),
              const SizedBox(width: 10),
              const _SponsorBadge(),
              if (widget.showCloseButton) ...[
                const SizedBox(width: 4),
                _CloseButton(onClose: widget.onClose),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsMarquee extends StatelessWidget {
  final Animation<double> controller;
  final String text;
  final TextStyle textStyle;

  const _NewsMarquee({
    required this.controller,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textDirection = Directionality.of(context);
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          maxLines: 1,
          textDirection: textDirection,
        )..layout();
        const gap = 36.0;
        final textWidth = textPainter.width;
        final distance = textWidth + gap;

        return ClipRect(
          child: SizedBox(
            height: 24,
            width: constraints.maxWidth,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-controller.value * distance, 0),
                  child: child,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TickerText(text: text, textStyle: textStyle),
                  const SizedBox(width: gap),
                  _TickerText(text: text, textStyle: textStyle),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TickerText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _TickerText({required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.visible,
      style: textStyle,
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback? onClose;

  const _CloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: IconButton(
        padding: EdgeInsets.zero,
        tooltip: 'Hide',
        onPressed: onClose,
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class _SponsorBadge extends StatelessWidget {
  const _SponsorBadge();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 104),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Sponsored by',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 9,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
          const Text(
            'Ali Hadi',
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: Color(0xFFFFE0A8),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
