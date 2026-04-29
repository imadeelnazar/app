import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/app_chrome.dart';

class ZiyaaratScreen extends StatefulWidget {
  const ZiyaaratScreen({super.key});

  @override
  State<ZiyaaratScreen> createState() => _ZiyaaratScreenState();
}

class _ZiyaaratScreenState extends State<ZiyaaratScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  Future<List<Map<String, dynamic>>> _loadZiyaraat() async {
    final jsonString =
        await rootBundle.loadString('assets/json/ziyaraat/index.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(data['items'] as List? ?? []);
  }

  Future<void> _readZiyarat(Map<String, dynamic> item) async {
    final file = item['file'] as String? ?? '';
    if (file.isEmpty) return;

    final jsonString =
        await rootBundle.loadString('assets/json/ziyaraat/$file');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final lines = List<Map<String, dynamic>>.from(data['lines'] as List? ?? [])
        .map(ReaderLine.fromJson)
        .toList();
    await ReaderAudioService.instance.playLines(
      title: data['title'] as String? ?? item['title'] as String? ?? 'Ziyarat',
      lines: lines,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hidayatAppBar(context, title: 'Ziyaraat'),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 4),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadZiyaraat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Unable to load Ziyaraat: ${snapshot.error}'),
            );
          }

          final query = _query.toLowerCase();
          final ziyaraat = (snapshot.data ?? []).where((item) {
            final searchText = [
              item['id'],
              item['title'],
              item['titleArabic'],
              item['titleUrdu'],
              item['category'],
            ].join(' ').toLowerCase();
            return query.isEmpty || searchText.contains(query);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Ziyaraat',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _query = value.trim()),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: ziyaraat.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = ziyaraat[index];
                    final titleArabic = item['titleArabic'] as String? ?? '';

                    return ListTile(
                      title: Text(item['title'] as String? ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (titleArabic.isNotEmpty)
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(titleArabic),
                            ),
                          Text(item['category'] as String? ?? ''),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.volume_up_outlined),
                            tooltip: 'Read aloud',
                            onPressed: () => _readZiyarat(item),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push('/ziyarah/${item['id']}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
