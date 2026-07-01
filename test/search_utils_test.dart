import 'package:flutter_test/flutter_test.dart';
import 'package:haqaiq/utils/search_utils.dart';

void main() {
  test('matches inside a hyphenated title after three letters', () {
    final items = [
      {'title': 'Al-Baqarah'},
      {'title': 'Al-Fatiha'},
      {'title': 'Al-Ikhlas'},
    ];

    final results = rankedSearch<Map<String, String>>(
      items: items,
      query: 'fat',
      titles: (item) => [item['title']],
    );

    expect(results, hasLength(1));
    expect(results.first['title'], 'Al-Fatiha');
  });

  test('keeps title matches above secondary field matches', () {
    final items = [
      {
        'title': 'Daily Duas',
        'category': 'dua_kumail',
      },
      {
        'title': 'Dua Kumail',
        'category': 'special_duas',
      },
    ];

    final results = rankedSearch<Map<String, String>>(
      items: items,
      query: 'kum',
      titles: (item) => [item['title']],
      fields: (item) => [item['category']],
    );

    expect(results.first['title'], 'Dua Kumail');
  });

  test('does not filter before the minimum search length', () {
    final items = [
      {'title': 'Al-Baqarah'},
      {'title': 'Al-Fatiha'},
    ];

    final results = rankedSearch<Map<String, String>>(
      items: items,
      query: 'fa',
      titles: (item) => [item['title']],
    );

    expect(results, items);
  });
}
