import 'package:flutter/material.dart';
import 'package:global_services/core/notifications/notifications.dart';
import 'package:global_services/core/router/app_router.dart';
import 'package:global_services/core/theme/app_theme.dart';
import 'package:global_services/injection.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await GlobalNotifications.instance.init();
  await GlobalNotifications.instance.requestPermissions();

  runApp(Application());
}

class Application extends StatelessWidget {
  final router = AppRouter();
  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Global Services',
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}
