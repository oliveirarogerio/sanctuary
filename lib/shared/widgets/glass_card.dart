import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Apple-inspired liquid glass card widget with backdrop blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final double blurIntensity;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius = 16,
    this.onTap,
    this.blurIntensity = 10,
    this.opacity = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.glassBackgroundDark.withOpacity(opacity),
                        AppColors.glassBackgroundDark.withOpacity(opacity * 0.8),
                      ]
                    : [
                        AppColors.glassBackground.withOpacity(opacity),
                        AppColors.glassBackground.withOpacity(opacity * 0.8),
                      ],
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isDark
                    ? AppColors.glassBorderDark.withOpacity(0.3)
                    : AppColors.glassBorder.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                // Soft outer shadow
                BoxShadow(
                  color: isDark
                      ? AppColors.secondary.withOpacity(0.1)
                      : AppColors.glassShadow,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                // Subtle secondary shadow
                BoxShadow(
                  color: isDark
                      ? AppColors.glassHighlightDark
                      : AppColors.glassHighlight,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius),
                splashColor: AppColors.secondary.withOpacity(0.1),
                highlightColor: AppColors.secondary.withOpacity(0.05),
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass container with gradient overlay
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Gradient? gradient;

  const GlassContainer({
    super.key,
    required this.child,
    required this.height,
    this.width,
    this.padding,
    this.borderRadius = 16,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            gradient: gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.glassBackground.withOpacity(0.9),
                    AppColors.glassBackground.withOpacity(0.7),
                  ],
                ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.glassBorder.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
} 