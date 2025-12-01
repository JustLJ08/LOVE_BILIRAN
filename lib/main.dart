import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:love_biliran/config/routes/app_routes.dart' show AppRoutes;
import 'config/routes/app_router.dart';
import 'config/themes/app_theme.dart';
import 'injection_container.dart' as di;
import 'firebase_options.dart'; // Ensure this file exists from your previous setup

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const LoveBiliranApp());
}

class LoveBiliranApp extends StatelessWidget {
  const LoveBiliranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love Biliran',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.splash,
    );
  }
}