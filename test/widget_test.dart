import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:edumanage/main.dart';
import 'package:edumanage/theme.dart';

void main() {
  testWidgets('App loads successfully smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const EduManageApp(),
      ),
    );

    // Verify that the app loaded (No crash)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
