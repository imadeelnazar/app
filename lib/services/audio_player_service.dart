import 'dart:developer' as developer;

import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();

  late AudioPlayer _audioPlayer;
  bool _isInitialized = false;
  String? _currentAssetPath;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _audioPlayer = AudioPlayer();
    _isInitialized = true;
  }

  Future<void> play(String url) async {
    try {
      await initialize();
      _currentAssetPath = null;
      await _audioPlayer.setLoopMode(LoopMode.off);
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      developer.log('Error playing audio',
          error: e, name: 'AudioPlayerService');
    }
  }

  Future<void> playAsset(String assetPath) async {
    try {
      await initialize();
      if (_audioPlayer.playing && _currentAssetPath == assetPath) return;

      await _audioPlayer.stop();
      _currentAssetPath = assetPath;
      await _audioPlayer.setLoopMode(LoopMode.off);
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.play();
    } catch (e) {
      developer.log(
        'Error playing asset audio',
        error: e,
        name: 'AudioPlayerService',
      );
    }
  }

  Future<void> playAssetLooping(String assetPath) async {
    try {
      await initialize();
      if (_audioPlayer.playing && _currentAssetPath == assetPath) return;

      await _audioPlayer.stop();
      _currentAssetPath = assetPath;
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.play();
    } catch (e) {
      developer.log(
        'Error playing looping asset audio',
        error: e,
        name: 'AudioPlayerService',
      );
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    _currentAssetPath = null;
    await _audioPlayer.setLoopMode(LoopMode.off);
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> setSpeed(double speed) async {
    // Clamp speed between 0.5 and 1.5
    final clampedSpeed = speed.clamp(0.5, 1.5);
    await _audioPlayer.setSpeed(clampedSpeed);
  }

  Future<void> setVolume(double volume) async {
    // Clamp volume between 0 and 1
    final clampedVolume = volume.clamp(0.0, 1.0);
    await _audioPlayer.setVolume(clampedVolume);
  }

  Stream<Duration?> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<double> get speedStream => _audioPlayer.speedStream;
  Stream<double> get volumeStream => _audioPlayer.volumeStream;

  Duration? get position => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
  double get speed => _audioPlayer.speed;
  double get volume => _audioPlayer.volume;
  PlayerState get playerState => _audioPlayer.playerState;
  bool get isPlaying => _audioPlayer.playing;

  Future<void> loadPlaylist(List<String> urls) async {
    try {
      await initialize();
      _currentAssetPath = null;
      await _audioPlayer.setLoopMode(LoopMode.off);
      final playlist = ConcatenatingAudioSource(
        children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
      );
      await _audioPlayer.setAudioSource(playlist);
    } catch (e) {
      developer.log(
        'Error loading playlist',
        error: e,
        name: 'AudioPlayerService',
      );
    }
  }

  Future<void> skipToNext() async {
    await _audioPlayer.seekToNext();
  }

  Future<void> skipToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  Future<void> skipToIndex(int index) async {
    final audioSource = _audioPlayer.audioSource;
    if (audioSource is ConcatenatingAudioSource) {
      await _audioPlayer.seek(Duration.zero, index: index);
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    _isInitialized = false;
  }

  // Helper methods for common patterns
  Future<void> playAtLine({
    required String url,
    required int startTimeMs,
    required int endTimeMs,
  }) async {
    try {
      await play(url);
      if (startTimeMs > 0) {
        await seek(Duration(milliseconds: startTimeMs));
      }
    } catch (e) {
      developer.log(
        'Error playing at line',
        error: e,
        name: 'AudioPlayerService',
      );
    }
  }

  Future<void> repeatLine({
    required String url,
    required int startTimeMs,
    required int endTimeMs,
  }) async {
    try {
      await setSpeed(0.75); // Slow down for clarity
      await playAtLine(
          url: url, startTimeMs: startTimeMs, endTimeMs: endTimeMs);
    } catch (e) {
      developer.log(
        'Error repeating line',
        error: e,
        name: 'AudioPlayerService',
      );
    }
  }
}
