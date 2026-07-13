/// أنواع الحصون الخمسة في منهجية "الحصون الخمسة" (د. سعيد أبو العلا حمزة).
///
/// هذا enum يمثّل الأنواع الخمسة الثابتة فقط — بدون أي منطق حساب أو حالة.
/// الترتيب هنا يعكس الترتيب المنطقي اليومي للممارسة كما ورد في المنهجية.
enum HosnType {
  /// الحفظ الجديد
  newMemorization,

  /// مراجعة القريب
  recentReview,

  /// مراجعة البعيد
  distantReview,

  /// التحضير
  preparation,

  /// القراءة المستمرة
  continuousReading,
}

/// امتداد (extension) يوفر اسم العرض العربي لكل قيمة من [HosnType].
///
/// فُصل هذا المنطق عن تعريف الـ enum نفسه عن قصد: الـ enum يمثّل البيانات
/// الخام فقط، بينما هذا الـ extension مسؤول عن التمثيل النصي (العرض).
/// هذا الفصل يسمح لاحقًا بإضافة extensions أخرى (مثل أيقونة أو لون لكل
/// حصن) دون تعديل تعريف الـ enum الأساسي.
extension HosnTypeArabic on HosnType {
  /// اسم الحصن بالعربية، لعرضه مباشرة في واجهة المستخدم.
  String get arabicName {
    switch (this) {
      case HosnType.newMemorization:
        return 'الحفظ الجديد';
      case HosnType.recentReview:
        return 'مراجعة القريب';
      case HosnType.distantReview:
        return 'مراجعة البعيد';
      case HosnType.preparation:
        return 'التحضير';
      case HosnType.continuousReading:
        return 'القراءة المستمرة';
    }
  }
}
