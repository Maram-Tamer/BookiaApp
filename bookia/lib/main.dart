import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/core/utils/themes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.value([DioProvider.init(), LocalHelper.init()]);

  runApp(DevicePreview(enabled: false, builder: (context) => MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
  routerConfig: AppNavigator.router,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
    );
  }
}

