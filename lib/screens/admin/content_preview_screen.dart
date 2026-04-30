import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/content_import_service.dart';
import '../../widgets/app_chrome.dart';

class ContentPreviewScreen extends StatefulWidget {
  final UploadedContent content;

  const ContentPreviewScreen({super.key, required this.content});

  @override
  State<ContentPreviewScreen> createState() => _ContentPreviewScreenState();
}

class _ContentPreviewScreenState extends State<ContentPreviewScreen> {
  late UploadedContent _content;
  bool _saving = false;

  // Inline editing of a single item
  int? _editingIndex;
  final _arabicCtrl = TextEditingController();
  final _englishCtrl = TextEditingController();
  final _urduCtrl = TextEditingController();
  final _farsiCtrl = TextEditingController();
  final _chapterCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _content = widget.content;
  }

  @override
  void dispose() {
    _arabicCtrl.dispose();
    _englishCtrl.dispose();
    _urduCtrl.dispose();
    _farsiCtrl.dispose();
    _chapterCtrl.dispose();
    super.dispose();
  }

  void _startEdit(int index) {
    final item = _content.content[index];
    _arabicCtrl.text = item.textArabic;
    _englishCtrl.text = item.textEnglish;
    _urduCtrl.text = item.textUrdu;
    _farsiCtrl.text = item.textFarsi;
    _chapterCtrl.text = item.chapterTitle;
    setState(() => _editingIndex = index);
  }

  void _saveEdit(int index) {
    final original = _content.content[index];
    final updated = ContentItem(
      number: original.number,
      chapterTitle: _chapterCtrl.text.trim(),
      sectionTitle: original.sectionTitle,
      textArabic: _arabicCtrl.text.trim(),
      textEnglish: _englishCtrl.text.trim(),
      textUrdu: _urduCtrl.text.trim(),
      textFarsi: _farsiCtrl.text.trim(),
      reference: original.reference,
      audioUrl: original.audioUrl,
      audioStartTime: original.audioStartTime,
      audioEndTime: original.audioEndTime,
    );

    final newContent = [..._content.content];
    newContent[index] = updated;
    setState(() {
      _content = _content.copyWith(content: newContent);
      _editingIndex = null;
    });
  }

  void _cancelEdit() => setState(() => _editingIndex = null);

  void _deleteItem(int index) {
    final newContent = [..._content.content];
    newContent.removeAt(index);
    // Re-number
    final renumbered = newContent.asMap().entries.map((e) {
      final item = e.value;
      return ContentItem(
        number: e.key + 1,
        chapterTitle: item.chapterTitle,
        sectionTitle: item.sectionTitle,
        textArabic: item.textArabic,
        textEnglish: item.textEnglish,
        textUrdu: item.textUrdu,
        textFarsi: item.textFarsi,
        reference: item.reference,
        audioUrl: item.audioUrl,
        audioStartTime: item.audioStartTime,
        audioEndTime: item.audioEndTime,
      );
    }).toList();
    setState(() => _content = _content.copyWith(content: renumbered));
  }

  Future<void> _saveDraft() async {
    setState(() => _saving = true);
    try {
      await ContentImportService.instance.save(_content);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved as draft')),
      );
      context.go('/admin/library');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _publish() async {
    setState(() => _saving = true);
    try {
      final published = _content.copyWith(status: 'published');
      await ContentImportService.instance.save(published);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Published: ${_content.title}'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/admin/library');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _exportJson() async {
    late final String json;
    try {
      json = await ContentImportService.instance.exportJson(_content.id);
    } catch (_) {
      // Not saved yet, so export the in-memory preview.
      json = const JsonEncoder.withIndent('  ').convert(_content.toJson());
    }
    if (!mounted) return;
    await Clipboard.setData(ClipboardData(text: json));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('JSON copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(
        context,
        title: 'Preview & Edit',
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            tooltip: 'Export JSON',
            onPressed: _exportJson,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header info
          _HeaderCard(content: _content),

          // Item count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Text(
                  '${_content.content.length} content items',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Text(
                  'Tap item to edit',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Content list
          Expanded(
            child: _content.content.isEmpty
                ? _EmptyContentNotice()
                : ListView.separated(
                    itemCount: _content.content.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      if (_editingIndex == i) {
                        return _EditItemCard(
                          arabicCtrl: _arabicCtrl,
                          englishCtrl: _englishCtrl,
                          urduCtrl: _urduCtrl,
                          farsiCtrl: _farsiCtrl,
                          chapterCtrl: _chapterCtrl,
                          onSave: () => _saveEdit(i),
                          onCancel: _cancelEdit,
                        );
                      }
                      return _ContentItemTile(
                        item: _content.content[i],
                        onEdit: () => _startEdit(i),
                        onDelete: () => _deleteItem(i),
                      );
                    },
                  ),
          ),

          // Bottom actions
          _BottomBar(
            saving: _saving,
            onDraft: _saveDraft,
            onPublish: _publish,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _HeaderCard extends StatelessWidget {
  final UploadedContent content;
  const _HeaderCard({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: hidayatGreen,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _TypeBadge(content.type),
              const SizedBox(width: 8),
              _StatusBadge(content.status),
              const SizedBox(width: 8),
              _CopyrightBadge(content.copyrightStatus),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (content.author.isNotEmpty)
            Text(
              content.author,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          if (content.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                content.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final isPublished = status == 'published';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isPublished
            ? Colors.green.withValues(alpha: 0.8)
            : Colors.orange.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CopyrightBadge extends StatelessWidget {
  final String status;
  const _CopyrightBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final isAllowed = status == 'allowed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isAllowed
            ? Colors.teal.withValues(alpha: 0.8)
            : Colors.red.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isAllowed ? 'ALLOWED' : 'META ONLY',
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ContentItemTile extends StatelessWidget {
  final ContentItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ContentItemTile({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Number badge
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hidayatTeal.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${item.number}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: hidayatTeal,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.chapterTitle.isNotEmpty)
                    Text(
                      item.chapterTitle,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: hidayatTeal,
                      ),
                    ),
                  if (item.textArabic.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        item.textArabic,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15, height: 1.6),
                      ),
                    ),
                  if (item.textEnglish.isNotEmpty)
                    Text(
                      item.textEnglish,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon:
                  const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Delete item',
            ),
          ],
        ),
      ),
    );
  }
}

class _EditItemCard extends StatelessWidget {
  final TextEditingController arabicCtrl;
  final TextEditingController englishCtrl;
  final TextEditingController urduCtrl;
  final TextEditingController farsiCtrl;
  final TextEditingController chapterCtrl;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _EditItemCard({
    required this.arabicCtrl,
    required this.englishCtrl,
    required this.urduCtrl,
    required this.farsiCtrl,
    required this.chapterCtrl,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: hidayatTeal),
        borderRadius: BorderRadius.circular(10),
        color: hidayatTeal.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Item',
            style: TextStyle(fontWeight: FontWeight.bold, color: hidayatTeal),
          ),
          const SizedBox(height: 10),
          _EditField(ctrl: chapterCtrl, label: 'Chapter Title', rtl: false),
          _EditField(ctrl: arabicCtrl, label: 'Arabic Text', rtl: true),
          _EditField(
              ctrl: englishCtrl, label: 'English Translation', rtl: false),
          _EditField(ctrl: urduCtrl, label: 'Urdu Translation', rtl: true),
          _EditField(ctrl: farsiCtrl, label: 'Farsi Translation', rtl: true),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hidayatTeal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EditField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final bool rtl;

  const _EditField({
    required this.ctrl,
    required this.label,
    required this.rtl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Directionality(
        textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
        child: TextField(
          controller: ctrl,
          maxLines: 3,
          textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 12),
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ),
    );
  }
}

class _EmptyContentNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.article_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          const Text(
            'No content items extracted.',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const SizedBox(height: 8),
          const Text(
            'This may be a metadata-only record.\nYou can still save and publish the metadata.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool saving;
  final VoidCallback onDraft;
  final VoidCallback onPublish;

  const _BottomBar({
    required this.saving,
    required this.onDraft,
    required this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: saving ? null : onDraft,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Draft'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: hidayatTeal),
                foregroundColor: hidayatTeal,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: saving ? null : onPublish,
              icon: saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.publish),
              label: const Text('Publish'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: hidayatTeal,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
