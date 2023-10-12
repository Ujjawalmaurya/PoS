import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos/myApp.dart';

Future<void> main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
