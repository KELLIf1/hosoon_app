// main.dart
// نقطة الدخول. يهيّئ Hive (Hive.initFlutter)، يفتح الـ Boxes المطلوبة،
// يلف التطبيق بـ ProviderScope، ويحدد الشاشة الأولى (Onboarding أو Home
// حسب وجود بيانات سابقة).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Hive وفتح الصناديق المطلوبة
  await Hive.initFlutter();
  await HiveBoxes.openAll();

  runApp(
    const ProviderScope(
      child: HosoonApp(),
    ),
  );
}