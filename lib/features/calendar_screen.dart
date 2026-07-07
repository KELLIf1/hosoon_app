// calendar_screen.dart
// شاشة مؤقتة (placeholder) لتبويب "Calendar" لحين بناء الشاشة الفعلية.
// موجودة الآن فقط لضمان أن شريط التنقل السفلي يعمل بالكامل بين الأربع تبويبات.

import 'package:flutter/material.dart';
import 'nav_helper.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  static const Color primaryColor = Color(0xFF031634);
  static const Color background = Color(0xFFE8ECF0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Calendar',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(
        child: Text(
          'Calendar screen coming soon',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => handleBottomNavTap(context, index, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.equalizer), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
