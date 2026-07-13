import 'package:flutter_test/flutter_test.dart';
import 'package:hosoon_app/core/engine/models/day_progress.dart';
import 'package:hosoon_app/core/engine/models/hosn_type.dart';

void main() {
  group('DayProgress defaults', () {
    test(
      'contains all five HosnType keys when created without completions',
      () {
        final progress = DayProgress(date: DateTime(2026, 7, 8));

        expect(progress.completions.length, equals(HosnType.values.length));
        for (final type in HosnType.values) {
          expect(progress.completions.containsKey(type), isTrue);
        }
      },
    );

    test('all default completion values are false', () {
      final progress = DayProgress(date: DateTime(2026, 7, 8));

      expect(progress.completions.values.every((v) => v == false), isTrue);
    });

    test('updateHosn changes only the targeted hosn, keeps others false', () {
      final progress = DayProgress(date: DateTime(2026, 7, 8));

      final updated = progress.updateHosn(HosnType.newMemorization, true);

      expect(updated.completions[HosnType.newMemorization], isTrue);

      final otherTypes = HosnType.values.where(
        (t) => t != HosnType.newMemorization,
      );
      for (final type in otherTypes) {
        expect(updated.completions[type], isFalse);
      }

      // Original instance must remain unchanged (immutability check).
      expect(progress.completions[HosnType.newMemorization], isFalse);
    });
  });
}
