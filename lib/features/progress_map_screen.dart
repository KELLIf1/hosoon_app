import 'package:flutter/material.dart';
import 'nav_helper.dart';
import 'statistics_screen.dart';

class ProgressMapScreen extends StatelessWidget {
  const ProgressMapScreen({super.key});

  // الألوان الأساسية المأخوذة من التصميم
  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color secondaryContainer = Color(0xFF98E2FD);
  static const Color background = Color(0xFFE8ECF0);
  static const Color outlineVariant = Color(0xFFC5C6CF);

  // إجمالي عدد الأحزاب في القرآن، والحزب الحالي الذي يعمل عليه المستخدم
  static const int totalHizbs = 60;
  static const int completedHizbs = 22; // آخر حزب مكتمل قبل الحزب الحالي
  static const int currentHizb = 23; // الحزب الذي يعمل عليه المستخدم الآن

  @override
  Widget build(BuildContext context) {
    final double percent = (completedHizbs / totalHizbs) * 100;

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
          // زر إضافي: عرض تفاصيل الإحصائيات الأسبوعية/الشهرية
          // (push وليس pushReplacement، لأنها شاشة فرعية يُفترض الرجوع منها)
          IconButton(
            icon: const Icon(Icons.bar_chart, color: primaryColor),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: primaryColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // بطاقة الإحصائية العلوية (نسبة الحفظ الكلية)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${percent.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'LEVEL 4 FORTRESS',
                      style: TextStyle(
                        color: secondaryContainer,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Quran Memorized',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                // شريط التقدم الكلي
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 8,
                    backgroundColor: primaryContainer,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(secondaryContainer),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$completedHizbs Hizbs Completed',
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Text('${totalHizbs - completedHizbs} Remaining',
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // بطاقة خريطة رحلة الأحزاب
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text(
                  'Hizb Journey',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Visualizing your noble path through the 60 Hizbs',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),
                // توليد كل عقد الرحلة من 1 إلى 60
                for (int hizb = 1; hizb <= totalHizbs; hizb++)
                  _buildHizbStep(hizb),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // بطاقة معلومات أسفل الرحلة (التقدم المستمر)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: outlineVariant.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.trending_up, color: primaryColor),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Consistent Progress',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: primaryColor)),
                      Text(
                        "You've completed 3 Hizbs in the last 7 days. Keep going!",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => handleBottomNavTap(context, index, 2),
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

  // بناء عقدة واحدة لحزب معيّن، مع إضافة شارة "معلم" كل 10 أحزاب
  Widget _buildHizbStep(int hizb) {
    final bool isCompleted = hizb < currentHizb;
    final bool isActive = hizb == currentHizb;
    final bool isMilestone = hizb % 10 == 0;

    // محاذاة متعرجة (يمين/يسار) لإعطاء إحساس المسار المتعرج، فقط للعقد العادية
    final Alignment alignment =
        hizb.isEven ? Alignment.centerRight : Alignment.centerLeft;

    // العقدة النشطة حاليًا (الحزب الذي يعمل عليه المستخدم)
    if (isActive) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'CURRENT FOCUS',
                style: TextStyle(
                    color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryContainer,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: secondaryContainer.withOpacity(0.8),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Text(
                '$hizb',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hizb $hizb',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor),
            ),
          ],
        ),
      );
    }

    // العقد العادية (مكتملة أو متبقية) + شارة المعلم كل 10 أحزاب
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Align(
            alignment: alignment,
            child: Padding(
              padding: EdgeInsets.only(
                left: alignment == Alignment.centerLeft ? 8 : 0,
                right: alignment == Alignment.centerRight ? 8 : 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: alignment == Alignment.centerRight
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isCompleted ? primaryColor : Colors.white,
                      shape: BoxShape.circle,
                      border: isCompleted
                          ? null
                          : Border.all(color: outlineVariant),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : Text(
                            '$hizb',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Hizb $hizb',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? primaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // شارة معلم كل 10 أحزاب (مثال: Hizb 10 Milestone)
        if (isMilestone)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEDF0),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: outlineVariant),
            ),
            child: Text(
              hizb == totalHizbs ? 'Hizb 60 (Goal)' : 'Hizb $hizb Milestone',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isCompleted ? primaryColor : Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
