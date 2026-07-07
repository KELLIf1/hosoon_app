// main.dart
// نسخة مؤقتة و"بسيطة" لتشغيل الشاشات الستاتيك الحالية والتأكد من أن
// التنقل بينها يعمل بدون مشاكل، بدون أي اعتماد على Hive أو Riverpod
// (لأنهم لسا ما جهزوا). لما تجهز الـ backend، رجّع النسخة الأصلية
// (Hive.initFlutter + HiveBoxes.openAll + ProviderScope) بدل هذي.

import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const HosoonApp());
}

/* ================================================================
النسخة النهائية (لما تجهز Hive والـ Providers)، رجّعها بدل اللي فوق:

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveBoxes.openAll();

  runApp(
    const ProviderScope(
      child: HosoonApp(),
    ),
  );
}
================================================================ */
