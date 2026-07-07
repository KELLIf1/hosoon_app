import 'package:flutter/material.dart';
import 'nav_helper.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // الألوان الأساسية المأخوذة من التصميم
  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color secondaryColor = Color(0xFF02677F);
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color skyBlueLight = Color(0xFFE0F2F7);
  static const Color background = Color(0xFFE8ECF0);
  static const Color surfaceContainer = Color(0xFFEFEDF0);

  // 0 = أسبوعي، 1 = شهري
  int selectedTab = 0;

  // بيانات جدول الأسبوع: اليوم + حالة كل حصن (خمسة حصون) + المجموع
  final List<Map<String, dynamic>> weeklyLog = [
    {'day': 'Sun 14', 'values': [true, true, false, true, true]},
    {'day': 'Mon 15', 'values': [true, true, true, true, true]},
    {'day': 'Tue 16', 'values': [false, true, false, false, false]},
    {'day': 'Wed 17', 'values': [true, true, false, false, false], 'today': true},
    {'day': 'Thu 18', 'values': [false, false, false, false, false]},
    {'day': 'Fri 19', 'values': [false, false, false, false, false]},
    {'day': 'Sat 20', 'values': [false, false, false, false, false]},
  ];

  // بيانات تحليلات الحصون الخمسة للنظرة الشهرية
  final List<Map<String, dynamic>> fortressAnalytics = const [
    {'title': 'New Memorization', 'percent': 95},
    {'title': 'Near Review', 'percent': 82},
    {'title': 'Far Review', 'percent': 64},
    {'title': 'Preparation', 'percent': 88},
    {'title': 'Continuous Reading', 'percent': 70},
  ];

  // بيانات خريطة النشاط الشهرية (1 = كامل، 0.5 = جزئي، 0 = بدون)
  final List<double> monthlyActivity = const [
    1, 1, 1, 0.5, 0, 1, 1,
    1, 1, 1, 1, 0.5, 1, 1,
    1, 0, 1, 1, 1, 1, 1,
    0.5, 1, 1, 1, 0.5, 1, 0,
    1, 1, 0.5,
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
          // مفتاح التبديل بين "أسبوعي" و "شهري"
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTabButton('This Week', 0)),
                Expanded(child: _buildTabButton('Month Overview', 1)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // عرض المحتوى المناسب حسب التبويب المختار
          if (selectedTab == 0) ..._buildWeeklyView() else ..._buildMonthlyView(),
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

  // زر تبويب واحد (أسبوعي / شهري)
  Widget _buildTabButton(String label, int index) {
    final bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  // ============ واجهة النظرة الأسبوعية ============
  List<Widget> _buildWeeklyView() {
    return [
      // بطاقة السلسلة الرئيسية (streak)
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('24',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(width: 6),
                    Icon(Icons.local_fire_department, color: skyBlue, size: 32),
                  ],
                ),
                const Text('DAY STREAK',
                    style: TextStyle(
                        color: skyBlue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 12)),
              ],
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.trending_up, color: Colors.white),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // بطاقتا الإحصائيات الثانوية
      Row(
        children: [
          Expanded(
            child: _statSquareCard(
              icon: Icons.check_circle,
              value: '18',
              label: 'Completed Days',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _statSquareCard(
              icon: Icons.visibility,
              value: '42%',
              label: 'Most Missed: Preparation',
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      // جدول سجل الأسبوع
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            for (final row in weeklyLog) _weeklyLogRow(row),
            const SizedBox(height: 16),
            // أزرار التنقل بين الأسابيع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navCircleButton(Icons.chevron_left, () {
                  // TODO: انتقل للأسبوع السابق
                }),
                const Text('Jun 14 - Jun 20',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: primaryColor)),
                _navCircleButton(Icons.chevron_right, () {
                  // TODO: انتقل للأسبوع القادم
                }),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // بطاقة نصيحة الاستمرارية
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: skyBlueLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.auto_awesome, color: secondaryColor),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Consistency Tip',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: primaryColor)),
                  SizedBox(height: 4),
                  Text(
                    'Your "Preparation" fortress is often missed on Tuesdays. '
                    'Try shifting your routine 15 minutes earlier to boost your success rate.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  // صف واحد في جدول السجل الأسبوعي
  Widget _weeklyLogRow(Map<String, dynamic> row) {
    final List<bool> values = List<bool>.from(row['values']);
    final bool isToday = row['today'] == true;
    final int total = values.where((v) => v).length;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF98E2FD).withOpacity(0.2) : null,
        borderRadius: BorderRadius.circular(8),
        border: isToday
            ? const Border(left: BorderSide(color: secondaryColor, width: 4))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              row['day'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isToday ? primaryColor : primaryColor.withOpacity(0.8),
              ),
            ),
          ),
          // خمس خانات لكل حصن
          for (final v in values)
            Expanded(
              child: Center(
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: v ? secondaryColor : surfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: v
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),
            ),
          SizedBox(
            width: 40,
            child: Text(
              '$total/5',
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  // ============ واجهة النظرة الشهرية ============
  List<Widget> _buildMonthlyView() {
    return [
      // بطاقة السلسلة الرئيسية (streak) بتصميم أكبر
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.local_fire_department, color: skyBlue),
                SizedBox(width: 6),
                Text('CURRENT MASTERY STREAK',
                    style: TextStyle(
                        color: skyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            const Text('24 Day Streak',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              "You're in the top 5% of consistent learners this month. Keep the momentum!",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // بطاقتا الإحصائيات: نسبة الإتمام الشهرية + درجة الاستمرارية
      Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircularProgressIndicator(
                          value: 0.75,
                          strokeWidth: 5,
                          backgroundColor: surfaceContainer,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                        const Text('75%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Monthly Completion',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text('92%',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  const SizedBox(height: 8),
                  const Text('Consistency Score',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      // خريطة النشاط الشهرية (Heatmap)
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Monthly Activity',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: monthlyActivity.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                final double level = monthlyActivity[index];
                final Color color = level == 1
                    ? skyBlue
                    : (level == 0.5 ? skyBlueLight : surfaceContainer);
                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Total of 24 full completions in the last 31 days.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // تحليلات الحصون الخمسة
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fortress Analytics',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor)),
            const SizedBox(height: 16),
            for (final f in fortressAnalytics) _fortressAnalyticsRow(f),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // تنقل بين الأشهر
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navCircleButton(Icons.chevron_left, () {
            // TODO: انتقل للشهر السابق
          }),
          const Text('October 2023',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: primaryColor)),
          _navCircleButton(Icons.chevron_right, () {
            // TODO: انتقل للشهر القادم
          }),
        ],
      ),
    ];
  }

  // صف واحد لعرض نسبة إتمام حصن معين مع شريط تقدم
  Widget _fortressAnalyticsRow(Map<String, dynamic> fortress) {
    final int percent = fortress['percent'] as int;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fortress['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: primaryColor)),
              Text('$percent%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 8,
              backgroundColor: surfaceContainer,
              valueColor: const AlwaysStoppedAnimation<Color>(skyBlue),
            ),
          ),
        ],
      ),
    );
  }

  // بطاقة إحصائية مربعة صغيرة (تستخدم في العرض الأسبوعي)
  Widget _statSquareCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(height: 20),
          Text(value,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // زر دائري صغير للتنقل (يمين / يسار)
  Widget _navCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: surfaceContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor),
      ),
    );
  }
}
