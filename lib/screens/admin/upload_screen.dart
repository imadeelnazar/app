import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/content_import_service.dart';
import '../../widgets/app_chrome.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  // Metadata controllers
  final _titleCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _sourceCtrl = TextEditingController();
  final _sourceUrlCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();

  String _contentType = 'book';
  String _language = 'arabic';

  PlatformFile? _pickedFile;
  bool _processing = false;
  String? _errorMessage;

  static const _languages = [
    ('arabic', 'Arabic'),
    ('urdu', 'Urdu'),
    ('english', 'English'),
    ('farsi', 'Farsi'),
    ('multi', 'Multi-language'),
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _categoryCtrl.dispose();
    _authorCtrl.dispose();
    _sourceCtrl.dispose();
    _sourceUrlCtrl.dispose();
    _descCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    setState(() => _errorMessage = null);
    final files = await ContentImportService.instance.pickFiles(
      extensions: ['json', 'txt'],
      allowMultiple: false,
    );
    if (files.isNotEmpty) {
      setState(() => _pickedFile = files.first);
      if (_titleCtrl.text.isEmpty) {
        final name = files.first.name.replaceAll(RegExp(r'\.\w+$'), '');
        _titleCtrl.text = name.replaceAll(RegExp(r'[_-]'), ' ').trim();
      }
    }
  }

  Future<void> _process() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedFile == null) {
      setState(() => _errorMessage = 'Please select a file to upload.');
      return;
    }

    setState(() {
      _processing = true;
      _errorMessage = null;
    });

    try {
      final tags = _tagsCtrl.text
          .split(',')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      final content = await ContentImportService.instance.processFile(
        _pickedFile!,
        contentType: _contentType,
        title: _titleCtrl.text.trim(),
        category: _categoryCtrl.text.trim(),
        source: _sourceCtrl.text.trim(),
        sourceUrl: _sourceUrlCtrl.text.trim(),
        author: _authorCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        tags: tags,
      );

      if (!mounted) return;
      await context.push('/admin/preview', extra: content);
    } on UnsupportedError catch (e) {
      setState(() => _errorMessage = e.message);
    } on FormatException catch (e) {
      setState(() => _errorMessage = 'Format error: ${e.message}');
    } catch (e) {
      setState(() => _errorMessage = 'Processing failed: $e');
    } finally {
      if (mounted) setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: haqaiqAppBar(context, title: 'Upload Content'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content type
              _SectionLabel('Content Type'),
              const SizedBox(height: 8),
              _ContentTypeSelector(
                selected: _contentType,
                onChanged: (v) => setState(() => _contentType = v),
              ),
              const SizedBox(height: 20),

              // File picker
              _SectionLabel('File'),
              const SizedBox(height: 8),
              _FilePicker(
                picked: _pickedFile,
                onTap: _pickFile,
              ),
              const SizedBox(height: 4),
              const Text(
                'Supported: .json (structured content), .txt (Arabic/English pairs)\n'
                'For PDF/DOCX: extract text first with tools/process_upload.py',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Title
              _SectionLabel('Title *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  hintText: 'e.g. Dua Kumail',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 16),

              // Category & Language row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Category'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _categoryCtrl,
                          decoration: const InputDecoration(
                            hintText: 'e.g. weekly_duas',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Language'),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _language,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: _languages
                              .map((l) => DropdownMenuItem(
                                    value: l.$1,
                                    child: Text(l.$2),
                                  ))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _language = v ?? _language),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Author & Source
              _SectionLabel('Author / Compiler'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _authorCtrl,
                decoration: const InputDecoration(
                  hintText: 'e.g. Imam Ali ibn Husayn A.S.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              _SectionLabel('Source Name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _sourceCtrl,
                decoration: const InputDecoration(
                  hintText: 'e.g. Mafatih al-Jinan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              _SectionLabel('Source URL (optional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _sourceUrlCtrl,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  hintText: 'https://...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              _SectionLabel('Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Brief description of the content...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Tags
              _SectionLabel('Tags (comma-separated)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tagsCtrl,
                decoration: const InputDecoration(
                  hintText: 'ramadhan, thursday, imam_ali',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),

              if (_errorMessage != null) const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _processing ? null : _process,
                  icon: _processing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_fix_high),
                  label:
                      Text(_processing ? 'Processing...' : 'Process & Preview'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: haqaiqTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              _ManualEntryHint(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
    );
  }
}

class _ContentTypeSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  static const _types = [
    ('book', Icons.menu_book, 'Book'),
    ('dua', Icons.favorite, 'Dua'),
    ('ziyarat', Icons.location_on, 'Ziyarat'),
    ('amaal', Icons.star, 'Amaal'),
    ('event', Icons.event, 'Event'),
    ('biography', Icons.person, 'Biography'),
    ('quran', Icons.auto_stories, 'Quran'),
  ];

  const _ContentTypeSelector({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _types.map((t) {
        final isSelected = t.$1 == selected;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(t.$2, size: 14),
              const SizedBox(width: 4),
              Text(t.$3),
            ],
          ),
          selected: isSelected,
          selectedColor: haqaiqTeal.withValues(alpha: 0.2),
          checkmarkColor: haqaiqTeal,
          onSelected: (_) => onChanged(t.$1),
        );
      }).toList(),
    );
  }
}

class _FilePicker extends StatelessWidget {
  final PlatformFile? picked;
  final VoidCallback onTap;

  const _FilePicker({required this.picked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasPicked = picked != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasPicked ? haqaiqTeal : Colors.grey.shade400,
            width: hasPicked ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: hasPicked
              ? haqaiqTeal.withValues(alpha: 0.05)
              : Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Icon(
              hasPicked ? Icons.insert_drive_file : Icons.upload_file,
              color: hasPicked ? haqaiqTeal : Colors.grey,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasPicked ? picked!.name : 'Tap to select file',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: hasPicked ? haqaiqTeal : Colors.grey.shade700,
                    ),
                  ),
                  if (hasPicked && picked!.size > 0)
                    Text(
                      '${(picked!.size / 1024).toStringAsFixed(1)} KB',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    )
                  else
                    const Text(
                      '.json or .txt',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
            if (hasPicked)
              Icon(Icons.check_circle, color: haqaiqTeal)
            else
              Icon(Icons.add_circle_outline, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class _ManualEntryHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.blue, size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'For PDF or DOCX files: use the Python tool on your PC to extract text first, '
              'then upload the generated .txt or .json file here.\n\n'
              'python tools/process_upload.py process --file book.txt --type book',
              style: TextStyle(fontSize: 12, color: Colors.blue, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
