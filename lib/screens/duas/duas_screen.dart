import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/reader_audio_service.dart';
import '../../widgets/app_chrome.dart';

class DuasScreen extends StatefulWidget {
  const DuasScreen({super.key});

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  Future<List<Map<String, dynamic>>> _loadDuas() async {
    final jsonString =
        await rootBundle.loadString('assets/json/duas/index.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(data['items'] as List? ?? []);
  }

  Future<void> _readDua(Map<String, dynamic> dua) async {
    final file = dua['file'] as String? ?? '';
    if (file.isEmpty) return;

    final jsonString = await rootBundle.loadString('assets/json/duas/$file');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final lines = List<Map<String, dynamic>>.from(data['lines'] as List? ?? [])
        .map(ReaderLine.fromJson)
        .toList();
    await ReaderAudioService.instance.playLines(
      title: data['title'] as String? ?? dua['title'] as String? ?? 'Dua',
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
      appBar: haqaiqAppBar(context, title: 'Duas'),
      bottomNavigationBar: const HaqaiqBottomNav(currentIndex: 2),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadDuas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load duas: ${snapshot.error}'));
          }

          final duas = (snapshot.data ?? []).where((dua) {
            final searchText = dua['searchText'] as String? ?? '';
            return _query.isEmpty || searchText.contains(_query.toLowerCase());
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: HaqaiqSearchField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  hintText: 'Search duas',
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: duas.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final dua = duas[index];
                    final titleArabic = dua['titleArabic'] as String? ?? '';
                    final lineCount = dua['lineCount'] as int? ?? 0;

                    return ListTile(
                      title: Text(dua['title'] as String? ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (titleArabic.isNotEmpty)
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(titleArabic),
                            ),
                          Text('${dua['category']} - $lineCount lines'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.volume_up_outlined),
                            tooltip: 'Read aloud',
                            onPressed: () => _readDua(dua),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push('/dua/${dua['id']}'),
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
