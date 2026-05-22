import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrentWeather {
  final double temperatureCelsius;
  final DateTime fetchedAt;

  const CurrentWeather({
    required this.temperatureCelsius,
    required this.fetchedAt,
  });

  String get displayTemperature {
    final rounded = temperatureCelsius.round();
    return '$rounded°C';
  }
}

class CurrentWeatherService {
  static const String _cachePrefix = 'current_weather_cache_v1';
  static const Duration _cacheTtl = Duration(minutes: 30);
  static const Duration _requestTimeout = Duration(seconds: 8);

  Future<CurrentWeather?> fetchCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _cacheKey(latitude, longitude);
    final cached = _readCache(prefs, cacheKey);

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheTtl) {
      return cached;
    }

    try {
      final fresh = await _fetchFromOpenMeteo(
        latitude: latitude,
        longitude: longitude,
      );
      await prefs.setString(
        cacheKey,
        jsonEncode({
          'temperatureCelsius': fresh.temperatureCelsius,
          'fetchedAt': fresh.fetchedAt.toIso8601String(),
        }),
      );
      return fresh;
    } catch (_) {
      return cached;
    }
  }

  Future<CurrentWeather> _fetchFromOpenMeteo({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': latitude.toStringAsFixed(5),
      'longitude': longitude.toStringAsFixed(5),
      'current': 'temperature_2m',
      'timezone': 'auto',
    });

    final response = await http.get(uri).timeout(_requestTimeout);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError('Weather request failed: ${response.statusCode}');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final current = payload['current'] as Map<String, dynamic>?;
    final temperature = (current?['temperature_2m'] as num?)?.toDouble();
    if (temperature == null) {
      throw const FormatException('Weather response missing temperature.');
    }

    return CurrentWeather(
      temperatureCelsius: temperature,
      fetchedAt: DateTime.now(),
    );
  }

  CurrentWeather? _readCache(SharedPreferences prefs, String cacheKey) {
    final raw = prefs.getString(cacheKey);
    if (raw == null) return null;

    try {
      final payload = jsonDecode(raw) as Map<String, dynamic>;
      final temperature = (payload['temperatureCelsius'] as num?)?.toDouble();
      final fetchedAtText = payload['fetchedAt'] as String?;
      final fetchedAt =
          fetchedAtText == null ? null : DateTime.tryParse(fetchedAtText);
      if (temperature == null || fetchedAt == null) return null;

      return CurrentWeather(
        temperatureCelsius: temperature,
        fetchedAt: fetchedAt,
      );
    } catch (_) {
      return null;
    }
  }

  String _cacheKey(double latitude, double longitude) {
    return '$_cachePrefix:${latitude.toStringAsFixed(2)}:${longitude.toStringAsFixed(2)}';
  }
}
