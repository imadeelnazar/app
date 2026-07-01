const int minSearchLength = 3;

class SearchResult<T> {
  final T item;
  final int score;

  const SearchResult({
    required this.item,
    required this.score,
  });
}

String normalizeSearchText(Object? value) {
  return (value?.toString() ?? '')
      .toLowerCase()
      .replaceAll(RegExp(r'[_\-/\\.,;:(){}\[\]"`~!@#$%^&*+=|<>?]+'), ' ')
      .replaceAll(RegExp(r"\s+"), ' ')
      .trim();
}

String compactSearchText(Object? value) {
  return normalizeSearchText(value).replaceAll(' ', '');
}

bool shouldSearch(String query) {
  return normalizeSearchText(query).length >= minSearchLength;
}

int searchScore({
  required String query,
  required Iterable<Object?> titles,
  Iterable<Object?> fields = const [],
}) {
  final normalizedQuery = normalizeSearchText(query);
  if (normalizedQuery.isEmpty) return 0;

  final compactQuery = compactSearchText(normalizedQuery);
  final titleText = normalizeSearchText(titles.join(' '));
  final titleCompact = compactSearchText(titleText);
  final titleWords =
      titleText.split(' ').where((word) => word.isNotEmpty).toList();

  if (titleText == normalizedQuery || titleCompact == compactQuery) {
    return 1000;
  }
  if (titleWords.any((word) => word.startsWith(normalizedQuery))) {
    return 950;
  }
  if (titleText.startsWith(normalizedQuery)) {
    return 900;
  }
  if (titleWords.any((word) => word.contains(normalizedQuery))) {
    return 850;
  }
  if (titleText.contains(normalizedQuery) ||
      titleCompact.contains(compactQuery)) {
    return 800;
  }

  final fieldText = normalizeSearchText(fields.join(' '));
  final fullText = normalizeSearchText('$titleText $fieldText');
  final fullCompact = compactSearchText(fullText);
  final queryWords =
      normalizedQuery.split(' ').where((word) => word.isNotEmpty).toList();

  if (fullText.contains(normalizedQuery)) {
    return 600;
  }
  if (fullCompact.contains(compactQuery)) {
    return 550;
  }
  if (queryWords.isNotEmpty &&
      queryWords.every((word) => fullText.contains(word))) {
    return 500;
  }

  return -1;
}

List<T> rankedSearch<T>({
  required Iterable<T> items,
  required String query,
  required Iterable<Object?> Function(T item) titles,
  Iterable<Object?> Function(T item)? fields,
}) {
  if (!shouldSearch(query)) {
    return items.toList();
  }

  final results = <SearchResult<T>>[];
  for (final item in items) {
    final score = searchScore(
      query: query,
      titles: titles(item),
      fields: fields?.call(item) ?? const [],
    );
    if (score >= 0) {
      results.add(SearchResult(item: item, score: score));
    }
  }

  results.sort((a, b) => b.score.compareTo(a.score));
  return results.map((result) => result.item).toList();
}
