import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duas'),
        backgroundColor: const Color(0xFF1B4D3E),
      ),
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
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search duas',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _query = value.trim()),
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
                      trailing: const Icon(Icons.chevron_right),
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
