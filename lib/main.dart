import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'utils/box_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [1] Initialize Hive - Hive Flutter'ı [BAŞLAT]
  await Hive.initFlutter();

  /// [2] Initialize Open Box - Kutu [AÇ]
  await Hive.openBox<int>(BoxManager.instance.boxNameCounter);

  runApp(
    const App(),
  );
}
