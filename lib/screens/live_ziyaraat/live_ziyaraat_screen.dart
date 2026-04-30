import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/app_chrome.dart';

class LiveZiyaraatScreen extends StatefulWidget {
  const LiveZiyaraatScreen({super.key});

  @override
  State<LiveZiyaraatScreen> createState() => _LiveZiyaraatScreenState();
}

class _LiveZiyaraatScreenState extends State<LiveZiyaraatScreen> {
  VideoPlayerController? _controller;
  WebViewController? _webViewController;
  int _selectedIndex = 0;
  bool _isLoading = true;
  bool _isMuted = false;
  String? _errorMessage;

  _LiveZiyaratStream get _selectedStream => _streams[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _loadStream(0);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadStream(int index) async {
    final previousController = _controller;
    final stream = _streams[index];

    setState(() {
      _selectedIndex = index;
      _controller = null;
      _webViewController = null;
      _isLoading = true;
      _errorMessage = null;
    });

    await previousController?.pause();
    await previousController?.dispose();

    if (stream.webPlayerUrl != null && stream.webPlayerUrl!.isNotEmpty) {
      await _loadWebPlayer(stream);
      return;
    }

    if (stream.streamUrl == null || stream.streamUrl!.isEmpty) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Direct live video URL is not publicly available for this camera yet.';
      });
      return;
    }

    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(stream.streamUrl!),
        formatHint: VideoFormat.hls,
        httpHeaders: const {
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 Hidayat',
          'Referer': 'https://www.alharamlive.com/',
        },
      );

      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(_isMuted ? 0 : 1);
      await controller.play();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
        _isLoading = false;
      });
    } catch (_) {
      if (stream.webPlayerUrl != null && stream.webPlayerUrl!.isNotEmpty) {
        await _loadWebPlayer(stream);
        return;
      }
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Live stream is not responding right now. Please try refresh.';
      });
    }
  }

  Future<void> _loadWebPlayer(_LiveZiyaratStream stream) async {
    final webPlayerUrl = stream.webPlayerUrl;
    if (webPlayerUrl == null || webPlayerUrl.isEmpty) return;

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            }
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame == false) return;
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _errorMessage =
                  'Live player is not responding right now. Please try refresh.';
            });
          },
        ),
      );

    if (controller.platform is AndroidWebViewController) {
      final androidController = controller.platform as AndroidWebViewController;
      await androidController.setMediaPlaybackRequiresUserGesture(false);
      await androidController.setMixedContentMode(MixedContentMode.alwaysAllow);
    }

    await controller.loadRequest(
      Uri.parse(webPlayerUrl),
      headers: const {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 Hidayat',
      },
    );

    if (!mounted) return;
    setState(() {
      _webViewController = controller;
      _controller = null;
    });
  }

  Future<void> _retryCurrentStream() => _loadStream(_selectedIndex);

  Future<void> _togglePlayPause() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (controller.value.isPlaying) {
      await controller.pause();
    } else {
      await controller.play();
    }
    if (mounted) setState(() {});
  }

  Future<void> _toggleMute() async {
    final controller = _controller;
    final muted = !_isMuted;
    setState(() => _isMuted = muted);
    await controller?.setVolume(muted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(
        context,
        title: 'Live Ziyaraat',
        actions: [
          IconButton(
            tooltip: 'Refresh stream',
            onPressed: _retryCurrentStream,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 4),
      body: Column(
        children: [
          _LiveStreamSelector(
            streams: _streams,
            selectedIndex: _selectedIndex,
            onSelected: _loadStream,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: _LiveStreamHeader(stream: _selectedStream),
          ),
          Expanded(
            child: _NativeLivePlayer(
              controller: _controller,
              webViewController: _webViewController,
              isLoading: _isLoading,
              errorMessage: _errorMessage,
              isMuted: _isMuted,
              onRetry: _retryCurrentStream,
              onPlayPause: _togglePlayPause,
              onMute: _toggleMute,
            ),
          ),
        ],
      ),
    );
  }
}

class _NativeLivePlayer extends StatelessWidget {
  final VideoPlayerController? controller;
  final WebViewController? webViewController;
  final bool isLoading;
  final bool isMuted;
  final String? errorMessage;
  final VoidCallback onRetry;
  final VoidCallback onPlayPause;
  final VoidCallback onMute;

  const _NativeLivePlayer({
    required this.controller,
    required this.webViewController,
    required this.isLoading,
    required this.isMuted,
    required this.errorMessage,
    required this.onRetry,
    required this.onPlayPause,
    required this.onMute,
  });

  @override
  Widget build(BuildContext context) {
    final videoController = controller;
    final webController = webViewController;
    final isReady = videoController?.value.isInitialized ?? false;
    final isWebReady = webController != null;

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isReady)
            Center(
              child: AspectRatio(
                aspectRatio: videoController!.value.aspectRatio,
                child: VideoPlayer(videoController),
              ),
            ),
          if (isWebReady)
            Positioned.fill(
              child: WebViewWidget(controller: webController),
            ),
          if (isLoading)
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 14),
                Text(
                  'Loading live camera...',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          if (errorMessage != null && !isLoading)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.live_tv, color: Colors.white70, size: 48),
                  const SizedBox(height: 14),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          if (isWebReady && !isLoading && errorMessage == null)
            Positioned(
              top: 14,
              left: 14,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.58),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _LiveBadge(),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Refresh',
                        visualDensity: VisualDensity.compact,
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh, size: 20),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isReady)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: _PlayerControls(
                isPlaying: videoController!.value.isPlaying,
                isMuted: isMuted,
                onPlayPause: onPlayPause,
                onMute: onMute,
                onRetry: onRetry,
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback onPlayPause;
  final VoidCallback onMute;
  final VoidCallback onRetry;

  const _PlayerControls({
    required this.isPlaying,
    required this.isMuted,
    required this.onPlayPause,
    required this.onMute,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            IconButton(
              tooltip: isPlaying ? 'Pause' : 'Play',
              onPressed: onPlayPause,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              color: Colors.white,
            ),
            IconButton(
              tooltip: isMuted ? 'Unmute' : 'Mute',
              onPressed: onMute,
              icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
              color: Colors.white,
            ),
            const Spacer(),
            const _LiveBadge(),
            IconButton(
              tooltip: 'Refresh',
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'LIVE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _LiveStreamSelector extends StatelessWidget {
  final List<_LiveZiyaratStream> streams;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _LiveStreamSelector({
    required this.streams,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final stream = streams[index];
          final selected = index == selectedIndex;
          final isPlayable =
              stream.streamUrl != null || stream.webPlayerUrl != null;

          return ChoiceChip(
            selected: selected,
            label: Text(stream.shortTitle),
            avatar: Icon(
              isPlayable
                  ? selected
                      ? Icons.radio_button_checked
                      : Icons.play_circle_outline
                  : Icons.block,
              size: 18,
              color: selected ? Colors.white : hidayatTeal,
            ),
            selectedColor: hidayatTeal,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => onSelected(index),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: streams.length,
      ),
    );
  }
}

class _LiveStreamHeader extends StatelessWidget {
  final _LiveZiyaratStream stream;

  const _LiveStreamHeader({required this.stream});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8EFEB)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: hidayatTeal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.videocam, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stream.title,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${stream.sourceLabel} - ${stream.note}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveZiyaratStream {
  final String shortTitle;
  final String title;
  final String sourceLabel;
  final String note;
  final String? streamUrl;
  final String? webPlayerUrl;

  const _LiveZiyaratStream({
    required this.shortTitle,
    required this.title,
    required this.sourceLabel,
    required this.note,
    required this.streamUrl,
    this.webPlayerUrl,
  });
}

const List<_LiveZiyaratStream> _streams = [
  _LiveZiyaratStream(
    shortTitle: 'Karbala',
    title: 'Imam Hussain (A.S) Karbala Live',
    sourceLabel: 'Al Haram Live official player',
    note: 'Active live camera',
    streamUrl: 'https://stream.alkafeel.net/live/alkafeel/playlist.m3u8',
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=4&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Kadhimiya',
    title: 'Kadhimiya Live',
    sourceLabel: 'Al Haram Live official player',
    note: 'Imam Kazim (A.S) and Imam Taqi (A.S)',
    streamUrl: 'https://live.aljawadain.org/live/aljawadaintv/playlist.m3u8',
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=6&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Najaf',
    title: 'Imam Ali (A.S) Najaf Live',
    sourceLabel: 'Al Haram Live embedded player',
    note: 'Official web player inside app',
    streamUrl: null,
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=2&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Mashhad',
    title: 'Imam Reza (A.S) Mashhad Live',
    sourceLabel: 'Al Haram Live official player',
    note: 'Active live camera',
    streamUrl:
        'https://newlive.nasimrezvan.com/hls/Rawzeh-ye-Monavvareh/720p/index.m3u8',
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=5&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Samarra',
    title: 'Samarra Holy Shrines Live',
    sourceLabel: 'Al Haram Live embedded player',
    note: 'Imam Hadi (A.S) and Imam Askari (A.S)',
    streamUrl: null,
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=7&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Abbas',
    title: 'Hazrat Abbas (A.S) Live',
    sourceLabel: 'Al Haram Live official player',
    note: 'Active live camera',
    streamUrl: 'https://stream.alkafeel.net/live/alkafeel/playlist.m3u8',
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=9&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
  _LiveZiyaratStream(
    shortTitle: 'Qom',
    title: 'Bibi Fatima Masumeh (S.A) Qom Live',
    sourceLabel: 'Al Haram Live embedded player',
    note: 'Official web player inside app',
    streamUrl: null,
    webPlayerUrl:
        'https://www.alharamlive.com/index.php?option=com_yendifvideoshare&view=player&id=8&format=raw&autoplay=1&loop=0&volume=50&playbtn=1&controlbar=1&playpause=1&currenttime=0&progress=1&duration=0&volumebtn=1&fullscreen=1&embed=0&share=0',
  ),
];
