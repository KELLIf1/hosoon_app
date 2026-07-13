import 'hosn_type.dart';

/// يمثّل حالة إنجاز الحصون الخمسة ليوم واحد محدد.
///
/// هذا الكلاس Pure Dart بالكامل ولا يعتمد على Hive أو Flutter. طبقة التخزين
/// (`data/local_storage_service.dart`) هي المسؤولة عن تحويله من/إلى JSON،
/// وليس هذا الكلاس نفسه.
///
/// الكلاس غير قابل للتعديل (immutable): أي تغيير على حالة الإنجاز ينتج
/// نسخة جديدة عبر [copyWith] بدلاً من تعديل الكائن الحالي. هذا يتماشى مع
/// مبدأ Derived State المعتمد في المشروع، ويسهّل التكامل مع Riverpod لاحقًا.
class DayProgress {
  /// تاريخ هذا اليوم.
  final DateTime date;

  /// حالة إنجاز كل حصن من الحصون الخمسة لهذا اليوم.
  ///
  /// يُضمن دائمًا احتواء هذه الخريطة على جميع قيم [HosnType] كمفاتيح،
  /// حتى عند عدم تمرير أي قيم صراحة عند الإنشاء.
  final Map<HosnType, bool> completions;

  DayProgress({required this.date, Map<HosnType, bool>? completions})
    : completions = completions ?? _defaultCompletions();

  /// يبني خريطة افتراضية تحتوي على جميع الحصون الخمسة بقيمة false،
  /// مبنية ديناميكيًا من [HosnType.values] بدلاً من كتابتها يدويًا،
  /// حتى تبقى صحيحة تلقائيًا لو أُضيف نوع حصن جديد مستقبلاً.
  static Map<HosnType, bool> _defaultCompletions() => {
    for (final type in HosnType.values) type: false,
  };

  /// ينشئ نسخة جديدة من هذا الكائن مع استبدال الحقول الممرَّرة فقط.
  DayProgress copyWith({DateTime? date, Map<HosnType, bool>? completions}) {
    return DayProgress(
      date: date ?? this.date,
      completions: completions ?? Map<HosnType, bool>.from(this.completions),
    );
  }

  /// ينشئ نسخة جديدة بعد تعديل حالة حصن واحد فقط، مع بقاء الباقي كما هو.
  ///
  /// مفيد لعمليات التفاعل اليومي (مثل: تأشير حصن واحد كمُنجز) دون الحاجة
  /// لإعادة بناء الخريطة كاملة يدويًا في كل مرة.
  DayProgress updateHosn(HosnType type, bool isCompleted) {
    final updated = Map<HosnType, bool>.from(completions);
    updated[type] = isCompleted;
    return copyWith(completions: updated);
  }

  @override
  String toString() => 'DayProgress(date: $date, completions: $completions)';
}
