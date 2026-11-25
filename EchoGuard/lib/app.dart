import 'package:flutter/material.dart';
import 'features/dashboard/dashboard_screen.dart';

class EchoGuardApp extends StatelessWidget {
  const EchoGuardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'EchoGuard',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B87)),
      scaffoldBackgroundColor: const Color(0xFFF4F7FA),
    ),
    home: const DashboardScreen(),
  );
}
