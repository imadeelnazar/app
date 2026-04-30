import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hidayat/main.dart';

void main() {
  testWidgets('Hidayat app renders splash screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    expect(find.text('Hidayat'), findsOneWidget);
    expect(find.text('Islamic Knowledge'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
