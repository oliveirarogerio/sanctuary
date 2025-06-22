import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/constants/app_colors.dart';

/// A glassmorphism-styled theme toggle button for switching between light/dark modes
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [
                      AppColors.primary.withOpacity(0.3),
                      AppColors.primary.withOpacity(0.2),
                    ]
                  : [
                      AppColors.background.withOpacity(0.3),
                      AppColors.background.withOpacity(0.2),
                    ],
            ),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.secondary.withOpacity(0.3)
                  : AppColors.secondary.withOpacity(0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.primary.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => themeController.toggleTheme(),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    themeController.themeIcon,
                    key: ValueKey(themeController.themeMode),
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.secondary
                        : AppColors.secondary.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 