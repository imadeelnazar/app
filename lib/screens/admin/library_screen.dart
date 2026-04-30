import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/content_import_service.dart';
import '../../widgets/app_chrome.dart';

class AdminLibraryScreen extends StatefulWidget {
  const AdminLibraryScreen({super.key});

  @override
  State<AdminLibraryScreen> createState() => _AdminLibraryScreenState();
}

class _AdminLibraryScreenState extends State<AdminLibraryScreen> {
  late Future<List<UploadedContent>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _itemsFuture = ContentImportService.instance.loadAll();
  }

  Future<void> _delete(UploadedContent item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete content?'),
        content: Text('Delete "${item.title}" from the imported library?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ContentImportService.instance.delete(item.id);
    if (!mounted) return;
    setState(_reload);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted: ${item.title}')),
    );
  }

  Future<void> _toggleStatus(UploadedContent item) async {
    if (item.status == 'published') {
      await ContentImportService.instance.unpublish(item.id);
    } else {
      await ContentImportService.instance.publish(item.id);
    }
    if (!mounted) return;
    setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(
        context,
        title: 'Imported Library',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => setState(_reload),
          ),
        ],
      ),
      body: FutureBuilder<List<UploadedContent>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? const <UploadedContent>[];
          if (items.isEmpty) {
            return const _EmptyLibrary();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return _LibraryTile(
                item: item,
                onOpen: () => context.push('/admin/preview', extra: item),
                onToggleStatus: () => _toggleStatus(item),
                onDelete: () => _delete(item),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/upload'),
        backgroundColor: hidayatTeal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
    );
  }
}

class _LibraryTile extends StatelessWidget {
  final UploadedContent item;
  final VoidCallback onOpen;
  final VoidCallback onToggleStatus;
  final VoidCallback onDelete;

  const _LibraryTile({
    required this.item,
    required this.onOpen,
    required this.onToggleStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final published = item.status == 'published';
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: hidayatTeal.withValues(alpha: 0.12),
                foregroundColor: hidayatTeal,
                child: Icon(_iconForType(item.type), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.type} | ${item.content.length} items | ${item.audioFiles.length} audio',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  published ? Icons.visibility : Icons.visibility_off_outlined,
                  color: published ? Colors.green : Colors.orange,
                ),
                tooltip: published ? 'Unpublish' : 'Publish',
                onPressed: onToggleStatus,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Delete',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'dua' => Icons.favorite,
      'ziyarat' => Icons.location_on,
      'quran' => Icons.auto_stories,
      'event' => Icons.event,
      'biography' => Icons.person,
      'amaal' => Icons.star,
      _ => Icons.menu_book,
    };
  }
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.library_books_outlined,
              size: 54,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'No imported content yet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Upload a JSON or TXT file to create the first draft.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () => context.push('/admin/upload'),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Content'),
            ),
          ],
        ),
      ),
    );
  }
}
