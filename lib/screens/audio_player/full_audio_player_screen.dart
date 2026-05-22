import 'package:flutter/material.dart';

import '../../services/reader_audio_service.dart';
import '../../widgets/app_chrome.dart';

class FullAudioPlayerScreen extends StatelessWidget {
  const FullAudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ReaderAudioService.instance;

    return Scaffold(
      appBar: haqaiqAppBar(context, title: 'Audio Player'),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: haqaiqGreen,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child:
                  Icon(Icons.record_voice_over, size: 96, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<String>(
            valueListenable: service.currentTitle,
            builder: (context, title, _) {
              return Text(
                title.isEmpty ? 'No active reading' : title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<int?>(
            valueListenable: service.currentLine,
            builder: (context, line, _) {
              return Text(
                line == null
                    ? 'Open any Quran, Dua, Book, or Ziyarat and tap Read aloud.'
                    : 'Reading line $line',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              );
            },
          ),
          const SizedBox(height: 28),
          ValueListenableBuilder<bool>(
            valueListenable: service.isPlaying,
            builder: (context, playing, _) {
              return Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: IconButton.filled(
                    key: ValueKey(playing),
                    style: IconButton.styleFrom(
                      backgroundColor: playing ? haqaiqTeal : Colors.grey,
                      fixedSize: const Size(76, 76),
                    ),
                    onPressed: playing ? service.stop : null,
                    icon: Icon(
                      playing ? Icons.stop : Icons.play_disabled,
                      color: Colors.white,
                      size: 38,
                    ),
                    tooltip: playing ? 'Stop reading' : 'Nothing playing',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 28),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFE8E3D8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.language, color: haqaiqTeal),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Reading language',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
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
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFE0B2)),
            ),
            child: const Text(
              'High-quality scholar/reciter recordings can be added later only from legal public or licensed sources. Empty audio URLs currently use the phone voice so reading works immediately.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
