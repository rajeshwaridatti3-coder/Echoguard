import 'package:flutter_test/flutter_test.dart';
import 'package:echoguard/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('EchoGuard dashboard renders', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EchoGuardApp()));
    await tester.pump();
    expect(find.text('EchoGuard'), findsOneWidget);
  });
}
