import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/content_import_service.dart';
import '../../widgets/app_chrome.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late Future<Map<String, int>> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = ContentImportService.instance.stats();
  }

  void _refresh() => setState(() {
        _statsFuture = ContentImportService.instance.stats();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(
        context,
        title: 'Content Manager',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: FutureBuilder<Map<String, int>>(
        future: _statsFuture,
        builder: (context, snap) {
          final stats = snap.data ?? {};
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatsRow(stats: stats),
              const SizedBox(height: 24),
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _ActionGrid(),
              const SizedBox(height: 24),
              _ImportSourcesCard(),
              const SizedBox(height: 24),
              _PythonToolsCard(),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stats row
// ---------------------------------------------------------------------------
class _StatsRow extends StatelessWidget {
  final Map<String, int> stats;
  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          label: 'Total',
          value: stats['total'] ?? 0,
          icon: Icons.library_books,
          color: hidayatTeal,
        ),
        const SizedBox(width: 10),
        _StatCard(
          label: 'Published',
          value: stats['published'] ?? 0,
          icon: Icons.check_circle_outline,
          color: Colors.green,
        ),
        const SizedBox(width: 10),
        _StatCard(
          label: 'Draft',
          value: stats['draft'] ?? 0,
          icon: Icons.edit_note,
          color: Colors.orange,
        ),
        const SizedBox(width: 10),
        _StatCard(
          label: 'With Audio',
          value: stats['withAudio'] ?? 0,
          icon: Icons.audiotrack,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action grid
// ---------------------------------------------------------------------------
class _ActionGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _AdminActionTile(
          icon: Icons.upload_file,
          label: 'Upload Content',
          subtitle: 'Add book, dua, ziyarat',
          color: hidayatTeal,
          onTap: () => context.push('/admin/upload'),
        ),
        _AdminActionTile(
          icon: Icons.collections_bookmark,
          label: 'My Library',
          subtitle: 'Browse uploaded content',
          color: const Color(0xFF5C6BC0),
          onTap: () => context.push('/admin/library'),
        ),
        _AdminActionTile(
          icon: Icons.audiotrack,
          label: 'Audio Manager',
          subtitle: 'Manage MP3 files',
          color: Colors.purple,
          onTap: () => context.push('/admin/audio'),
        ),
        _AdminActionTile(
          icon: Icons.link,
          label: 'Source Import',
          subtitle: 'Metadata from web',
          color: Colors.orange,
          onTap: () => _showSourceImportInfo(context),
        ),
      ],
    );
  }

  void _showSourceImportInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Source Import'),
        content: const Text(
          'To import metadata from Duas.org or Al-Islam.org, use the Python tool '
          'on your development machine:\n\n'
          'python tools/import_sources.py --source duas_org '
          '--url "https://..." --type dua\n\n'
          'Full content is only imported when reuse permission is confirmed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _AdminActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AdminActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: color.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Import sources card
// ---------------------------------------------------------------------------
class _ImportSourcesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.policy_outlined, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  'Copyright Policy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Duas.org and Al-Islam.org are treated as reference sources only. '
              'Full content import is permitted only when the source\'s licence '
              'explicitly allows redistribution, or written permission is obtained.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 10),
            _SourceRow(
              title: 'Duas.org',
              url: 'https://www.duas.org/',
              color: hidayatTeal,
            ),
            const SizedBox(height: 6),
            _SourceRow(
              title: 'Al-Islam.org',
              url: 'https://www.al-islam.org/',
              color: const Color(0xFF5C6BC0),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceRow extends StatelessWidget {
  final String title;
  final String url;
  final Color color;

  const _SourceRow({
    required this.title,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.link, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            url,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Python tools card
// ---------------------------------------------------------------------------
class _PythonToolsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: hidayatGreen.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: hidayatGreen.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.terminal, color: hidayatGreen),
                const SizedBox(width: 8),
                const Text(
                  'Development Tools',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: hidayatGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _CodeLine('python tools/import_sources.py --list-sources'),
            _CodeLine('python tools/process_upload.py process --file my_dua.txt --type dua'),
            _CodeLine('python tools/process_upload.py audio --file audio.mp3 --content-id <id>'),
            _CodeLine('python tools/process_upload.py list'),
          ],
        ),
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String code;
  const _CodeLine(this.code);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: hidayatGreen,
          ),
        ),
      ),
    );
  }
}
