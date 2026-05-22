import 'package:flutter/material.dart';

import '../services/reader_audio_service.dart';
import 'app_chrome.dart';

class ReaderAudioBar extends StatelessWidget {
  final String title;
  final List<ReaderLine> lines;

  const ReaderAudioBar({
    super.key,
    required this.title,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    final service = ReaderAudioService.instance;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7ECE8)),
      ),
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: service.isPlaying,
            builder: (context, playing, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: IconButton.filled(
                  key: ValueKey(playing),
                  style: IconButton.styleFrom(backgroundColor: haqaiqTeal),
                  onPressed: lines.isEmpty
                      ? null
                      : () {
                          if (playing) {
                            service.stop();
                          } else {
                            service.playLines(title: title, lines: lines);
                          }
                        },
                  icon: Icon(playing ? Icons.stop : Icons.play_arrow),
                  tooltip: playing ? 'Stop reading' : 'Read aloud',
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: service.statusMessage,
              builder: (context, status, _) {
                return ValueListenableBuilder<int?>(
                  valueListenable: service.currentLine,
                  builder: (context, line, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lines.isEmpty ? 'No readable text yet' : 'Read aloud',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: Text(
                            line == null ? status : 'Reading line $line',
                            key: ValueKey('$line-$status'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder<ReaderLanguage>(
            valueListenable: service.language,
            builder: (context, language, _) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<ReaderLanguage>(
                  value: language,
                  borderRadius: BorderRadius.circular(12),
                  items: ReaderLanguage.values
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.label),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) service.setLanguage(value);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ReaderLineHighlight extends StatelessWidget {
  final int lineNumber;
  final Widget child;

  const ReaderLineHighlight({
    super.key,
    required this.lineNumber,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: ReaderAudioService.instance.currentLine,
      builder: (context, currentLine, _) {
        final active = currentLine == lineNumber;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFE8F7F4) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: active
                ? Border.all(color: haqaiqTeal.withValues(alpha: 0.35))
                : null,
          ),
          child: child,
        );
      },
    );
  }
}
