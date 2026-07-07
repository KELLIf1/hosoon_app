// app.dart
// يعرّف كل الشاشات كـ "مسارات مسماة" (named routes)، وهذا اللي يخلي
// pushReplacementNamed / pushNamed في باقي الشاشات يشتغل.
// لاحقًا لما تجهز الـ Hive/Riverpod، التغيير الوحيد المطلوب هو:
// AppEntryPoint._decideNextScreen() تصير تقرأ من Hive بدل القيمة الثابتة.

import 'package:flutter/material.dart';

import './features/splash_screen.dart';
import './features/onboarding_screen.dart';
import './features/daily_card_screen.dart';
import './features/calendar_screen.dart';
import './features/progress_map_screen.dart';
import './features/settings_screen.dart';

class HosoonApp extends StatelessWidget {
  const HosoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Five Fortresses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE8ECF0),
      ),
      // الشاشة الأولى دائمًا: نقطة الدخول التي تقرر الوجهة التالية
      home: const AppEntryPoint(),
      // كل الشاشات الأخرى معرّفة هنا بأسماء ثابتة، تستخدمها الشاشات
      // عبر Navigator.pushNamed / pushReplacementNamed
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const DailyCardScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/progress': (context) => const ProgressMapScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

// هذا الودجت هو المسؤول عن "الانتقال" الفعلي أول ما يفتح التطبيق
class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  @override
  void initState() {
    super.initState();
    _decideNextScreen();
  }

  Future<void> _decideNextScreen() async {
    // مدة بسيطة لعرض شاشة الانطلاق (اختياري، احذفها لو ما تبيها)
    await Future.delayed(const Duration(seconds: 2));

    // TODO: لما يجهز Hive، اقرأ القيمة الفعلية بدل هذا المتغير الثابت
    // مثال: final bool hasOnboarded = HiveBoxes.settingsBox.get('hasOnboarded', defaultValue: false);
    const bool hasOnboarded = false;

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacementNamed(hasOnboarded ? '/home' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    // تظهر لحين ما ينتهي _decideNextScreen من تحديد الوجهة
    return const SplashScreen();
  }
}
