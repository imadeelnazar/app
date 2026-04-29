import 'package:flutter/material.dart';

class ZiyarahDetailScreen extends StatelessWidget {
  final int ziyarahId;

  const ZiyarahDetailScreen({Key? key, required this.ziyarahId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ziyarah $ziyarahId'),
        backgroundColor: const Color(0xFF1B4D3E),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ziyarah $ziyarahId',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Loading content...'),
          ],
        ),
      ),
    );
  }
}
