import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/navigation/app_router.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize theme controller
  final themeController = ThemeController();
  await themeController.init();
  
  runApp(SanctuaryApp(themeController: themeController));
}

/// Main app widget for Sanctuary pet adoption platform
class SanctuaryApp extends StatelessWidget {
  final ThemeController themeController;
  
  const SanctuaryApp({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeController,
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp.router(
            // App configuration
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            
            // Theme configuration - Both light and dark themes with controller
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode,
            
            // Navigation configuration
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
