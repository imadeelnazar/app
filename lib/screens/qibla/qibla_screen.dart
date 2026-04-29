import 'package:flutter/material.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Finder'),
        backgroundColor: const Color(0xFF1BA098),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFD4A574).withOpacity(0.1),
                              const Color(0xFF1BA098).withOpacity(0.05),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFFD4A574),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Positioned(
                              top: 10,
                              child: Text(
                                'N',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 10,
                              child: Text(
                                'E',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 10,
                              child: Text(
                                'S',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 10,
                              child: Text(
                                'W',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Transform.rotate(
                              angle: 0.5,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1BA098),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '257°',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1BA098),
                        ),
                      ),
                      const Text(
                        'Device\'s angle to qibla',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Rotate the phone 135° to the left',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Qibla Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE8E3D8)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Distance to Kaaba',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '7927 KM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1BA098),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
