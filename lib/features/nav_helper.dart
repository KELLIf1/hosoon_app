// nav_helper.dart
// دالة مشتركة يستخدمها كل شريط تنقل سفلي (BottomNavigationBar) في التطبيق،
// حتى لا نكرر نفس منطق التنقل في كل شاشة على حدة.
// تعتمد على المسارات المسماة (named routes) المعرّفة في app.dart.

import 'package:flutter/material.dart';

void handleBottomNavTap(BuildContext context, int index, int currentIndex) {
  // لا تفعل شيء إذا ضغط المستخدم على التبويب الذي هو فيه أصلاً
  if (index == currentIndex) return;

  const routes = [
    '/home', // 0: الرئيسية (Daily Card)
    '/calendar', // 1: التقويم
    '/progress', // 2: التقدم (Progress Map)
    '/settings', // 3: الإعدادات
  ];

  // pushReplacementNamed تستبدل الشاشة الحالية بدل ما تكدّس شاشات فوق بعض
  // في شريط تنقل سفلي، لأن التبويبات مو "مسار متسلسل" بل مواقع مستقلة
  Navigator.of(context).pushReplacementNamed(routes[index]);
}
