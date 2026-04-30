import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/content_import_service.dart';
import '../../widgets/app_chrome.dart';

class AudioManagerScreen extends StatefulWidget {
  const AudioManagerScreen({super.key});

  @override
  State<AudioManagerScreen> createState() => _AudioManagerScreenState();
}

class _AudioManagerScreenState extends State<AudioManagerScreen> {
  late Future<List<UploadedContent>> _itemsFuture;
  UploadedContent? _selected;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _itemsFuture = ContentImportService.instance.loadAll();
  }

  Future<void> _pickAudio() async {
    final selected = _selected;
    if (selected == null) return;

    setState(() => _busy = true);
    try {
      final files = await ContentImportService.instance.pickFiles(
        extensions: const ['mp3'],
        allowMultiple: true,
      );
      for (final PlatformFile file in files) {
        await ContentImportService.instance.addAudioFile(file, selected.id);
      }
      final refreshed = await ContentImportService.instance.load(selected.id);
      if (!mounted) return;
      setState(() {
        _selected = refreshed ?? selected;
        _reload();
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _deleteAudio(AudioFileEntry audio) async {
    final selected = _selected;
    if (selected == null) return;
    await ContentImportService.instance
        .deleteAudioFile(selected.id, audio.file);
    final refreshed = await ContentImportService.instance.load(selected.id);
    if (!mounted) return;
    setState(() {
      _selected = refreshed ?? selected;
      _reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(context, title: 'Audio Manager'),
      body: FutureBuilder<List<UploadedContent>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? const <UploadedContent>[];
          if (items.isEmpty) {
            return const _NoContentForAudio();
          }

          final selected = _selected ?? items.first;
          if (_selected == null) _selected = selected;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Content',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: selected.id,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: items
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.id,
                        child: Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (id) {
                  final match =
                      items.where((item) => item.id == id).firstOrNull;
                  if (match != null) setState(() => _selected = match);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _busy ? null : _pickAudio,
                  icon: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.audiotrack),
                  label: Text(_busy ? 'Adding audio...' : 'Add MP3 Files'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hidayatTeal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${selected.audioFiles.length} audio files',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (selected.audioFiles.isEmpty)
                const _EmptyAudioList()
              else
                ...selected.audioFiles.map(
                  (audio) => Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.music_note, color: hidayatTeal),
                      title: Text(audio.file),
                      subtitle: Text(
                        audio.localPath,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _deleteAudio(audio),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _NoContentForAudio extends StatelessWidget {
  const _NoContentForAudio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Upload content first, then attach MP3 files here.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _EmptyAudioList extends StatelessWidget {
  const _EmptyAudioList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'No audio attached to this content yet.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
