import 'package:flutter/material.dart';

class FullAudioPlayerScreen extends StatefulWidget {
  const FullAudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<FullAudioPlayerScreen> createState() => _FullAudioPlayerScreenState();
}

class _FullAudioPlayerScreenState extends State<FullAudioPlayerScreen> {
  bool isPlaying = false;
  double progress = 0.3;
  double speed = 1.0;
  double volume = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        backgroundColor: const Color(0xFF1B4D3E),
      ),
      body: Column(
        children: [
          // Artwork Area
          Container(
            color: const Color(0xFF1B4D3E),
            height: 300,
            child: const Center(
              child: Icon(
                Icons.music_note,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Islamic Audio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Professional Recitation',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Slider(
                  value: progress,
                  onChanged: (value) => setState(() => progress = value),
                  min: 0,
                  max: 1,
                  activeColor: const Color(0xFF1B4D3E),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('3:45'),
                    Text('12:30'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Playback Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {},
              ),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B4D3E),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () => setState(() => isPlaying = !isPlaying),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Speed Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Speed'),
                DropdownButton<double>(
                  value: speed,
                  items: [0.75, 1.0, 1.25, 1.5]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text('${e}x'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => speed = value ?? 1.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Volume Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.volume_down),
                Expanded(
                  child: Slider(
                    value: volume,
                    onChanged: (value) => setState(() => volume = value),
                    min: 0,
                    max: 1,
                    activeColor: const Color(0xFF1B4D3E),
                  ),
                ),
                const Icon(Icons.volume_up),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
