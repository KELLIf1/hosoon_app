// splash_screen.dart
// شاشة الانطلاق (Splash Screen). تظهر أثناء تهيئة Hive وتحميل بيانات المستخدم
// في main.dart، ثم تُحوّل تلقائيًا إلى شاشة Onboarding أو Home حسب وجود بيانات سابقة.

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // نفس الألوان المستخدمة في باقي شاشات التطبيق (Onboarding, Daily Card,
  // Statistics, Progress Map, Settings) للحفاظ على هوية بصرية موحدة
  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color secondaryContainer = Color(0xFF98E2FD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق (أيقونة الحصن/الطبقات كما في باقي الشاشات)
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.layers,
                color: secondaryContainer,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            // اسم التطبيق
            const Text(
              'Five Fortresses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Your path to memorization',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 40),
            // مؤشر تحميل بسيط أثناء تهيئة Hive وتحديد الشاشة التالية
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(secondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
