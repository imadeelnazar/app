import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ZiyaaratScreen extends StatelessWidget {
  const ZiyaaratScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ziyaraat = [
      'Ziyarat Ashura',
      'Ziyarat Warisa',
      'Ziyarat Arbaeen',
      'Ziyarat Imam Ali',
      'Ziyarat Imam Hassan',
      'Ziyarat Imam Hussain',
      'Ziyarat Imam Zain ul Abideen',
      'Ziyarat Rajab',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ziyaraat'),
        backgroundColor: const Color(0xFF1B4D3E),
      ),
      body: ListView.builder(
        itemCount: ziyaraat.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ziyaraat[index]),
            subtitle: const Text('Pilgrimage Prayer'),
            onTap: () => context.push('/ziyarah/${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
