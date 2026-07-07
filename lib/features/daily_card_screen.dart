import 'package:flutter/material.dart';
import 'nav_helper.dart';

class DailyCardScreen extends StatefulWidget {
  const DailyCardScreen({super.key});

  @override
  State<DailyCardScreen> createState() => _DailyCardScreenState();
}

class _DailyCardScreenState extends State<DailyCardScreen> {
  // الألوان الأساسية المأخوذة من التصميم
  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color secondaryColor = Color(0xFF02677F);
  static const Color outlineVariant = Color(0xFFC5C6CF);
  static const Color surfaceContainer = Color(0xFFEFEDF0);
  static const Color background = Color(0xFFE8ECF0);

  // أيام الأسبوع مع تواريخها، واليوم المختار حاليًا (الأربعاء)
  final List<Map<String, String>> weekDays = const [
    {'day': 'Mon', 'date': '12'},
    {'day': 'Tue', 'date': '13'},
    {'day': 'Wed', 'date': '14'},
    {'day': 'Thu', 'date': '15'},
    {'day': 'Fri', 'date': '16'},
    {'day': 'Sat', 'date': '17'},
    {'day': 'Sun', 'date': '18'},
  ];
  int selectedDayIndex = 2;

  // بيانات بطاقات "الحصون الخمسة"
  final List<Map<String, dynamic>> fortresses = [
    {
      'icon': Icons.menu_book,
      'title': 'New Memorization',
      'subtitle': 'Pages 45 to 46',
      'checked': false,
      'highlighted': false,
    },
    {
      'icon': Icons.refresh,
      'title': 'Near Review',
      'subtitle': 'Page 21 to 40',
      'checked': false,
      'highlighted': true, // البطاقة المميزة كما في التصميم
    },
    {
      'icon': Icons.layers,
      'title': 'Far Review',
      'subtitle': 'Systematic Recall',
      'checked': false,
      'highlighted': false,
    },
    {
      'icon': Icons.visibility,
      'title': 'Preparation',
      'subtitle': "Tomorrow's Focus",
      'checked': false,
      'highlighted': false,
    },
    {
      'icon': Icons.book_outlined,
      'title': 'Continuous Reading',
      'subtitle': 'Passive Immersion',
      'checked': false,
      'highlighted': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // الشريط العلوي
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: primaryContainer,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text(
              'Five Fortresses',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: primaryColor),
            onPressed: () {
              // TODO: افتح شاشة الإعدادات
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // شريط اختيار التاريخ
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final bool isSelected = index == selectedDayIndex;
                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = index),
                  child: Container(
                    width: 48,
                    margin: const EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        Text(
                          weekDays[index]['day']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Text(
                            weekDays[index]['date']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // عنوان القسم + شارة السلسلة اليومية (streak)
          Row(
            children: [
              const Text(
                "Today's Plan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text('12',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // قائمة بطاقات الحصون الخمسة
          ...fortresses.map((item) {
            final bool isHighlighted = item['highlighted'] as bool;
            final bool isChecked = item['checked'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isHighlighted ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // أيقونة البطاقة
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isHighlighted ? primaryContainer : surfaceContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: isHighlighted ? Colors.white : primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // عنوان ووصف البطاقة
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isHighlighted ? Colors.white : primaryColor,
                          ),
                        ),
                        Text(
                          item['subtitle'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: isHighlighted
                                ? Colors.white70
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // زر الإتمام (checkbox دائري)
                  GestureDetector(
                    onTap: () => setState(() => item['checked'] = !isChecked),
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isChecked ? secondaryColor : Colors.transparent,
                        border: Border.all(
                          color: isChecked
                              ? secondaryColor
                              : (isHighlighted
                                  ? primaryContainer
                                  : outlineVariant),
                          width: 2,
                        ),
                      ),
                      child: isChecked
                          ? const Icon(Icons.check, size: 18, color: Colors.white)
                          : null,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          // بانر إتمام المهام اليومية
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF98E2FD),
                  child: Icon(Icons.check_circle, color: primaryColor),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today Completed!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        'All 5 fortresses secured.',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: افتح شاشة الملخص (Recap)
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    'RECAP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => handleBottomNavTap(context, index, 0),
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
