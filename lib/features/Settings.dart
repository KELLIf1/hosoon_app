import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // الألوان الأساسية المأخوذة من التصميم
  static const Color primaryColor = Color(0xFF031634);
  static const Color primaryContainer = Color(0xFF1A2B4A);
  static const Color secondaryContainer = Color(0xFF98E2FD);
  static const Color background = Color(0xFFE8ECF0);
  static const Color surfaceContainerLow = Color(0xFFF5F3F6);
  static const Color errorColor = Color(0xFFBA1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // الشريط العلوي مع زر الرجوع
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // بطاقة الملف الشخصي
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
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
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryContainer, width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: primaryContainer,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zaid Al-Farooq',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Member since August 2023',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // قائمة صفوف الإعدادات
          _settingsRow(
            icon: Icons.speed,
            title: 'Weekly Memorization Rate',
            trailingBadge: '1 Hizb',
            onTap: () {
              // TODO: افتح شاشة تغيير المعدل الأسبوعي
            },
          ),
          const SizedBox(height: 12),
          _settingsRow(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              // TODO: افتح شاشة إعدادات الإشعارات
            },
          ),
          const SizedBox(height: 12),
          _settingsRow(
            icon: Icons.schedule,
            title: 'Reminder Time',
            trailingText: '05:30 AM',
            onTap: () {
              // TODO: افتح منتقي الوقت لتحديد وقت التذكير
            },
          ),
          const SizedBox(height: 12),
          _settingsRow(
            icon: Icons.info,
            title: 'About Method',
            onTap: () {
              // TODO: افتح شاشة شرح منهجية الحفظ
            },
          ),
          const SizedBox(height: 32),
          // زر إعادة ضبط التقدم (منطقة الخطر)
          OutlinedButton.icon(
            onPressed: () {
              // TODO: اعرض تأكيد قبل إعادة ضبط التقدم فعليًا
              _showResetConfirmationDialog(context);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: errorColor, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            icon: const Icon(Icons.history, color: errorColor),
            label: const Text(
              'Reset Progress',
              style: TextStyle(color: errorColor, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'DANGER ZONE',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // TODO: تنقّل بين الشاشات حسب الـ index
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // صف واحد قابل لإعادة الاستخدام لكل عنصر في قائمة الإعدادات
  Widget _settingsRow({
    required IconData icon,
    required String title,
    String? trailingText,
    String? trailingBadge,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
              if (trailingBadge != null)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    trailingBadge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              if (trailingText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    trailingText,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // نافذة تأكيد قبل إعادة ضبط التقدم فعليًا (لأنها عملية خطيرة لا يمكن التراجع عنها)
  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text(
          'This will permanently erase all your memorization progress. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: نفّذ عملية إعادة ضبط التقدم فعليًا (حذف بيانات Hive)
            },
            child: const Text('Reset', style: TextStyle(color: errorColor)),
          ),
        ],
      ),
    );
  }
}
