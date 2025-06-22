import 'package:flutter/material.dart';

/// App color constants - Sanctuary pet adoption app color scheme
/// Designed to evoke warmth, trust, hope, and compassion
/// Based on psychological principles for pet rescue and adoption
class AppColors {
  // Primary colors - Soft Teal (#4CAF50) - trust, nature, growth, harmony
  static const Color primary = Color(0xFF4CAF50); // Soft teal - main brand color
  static const Color primaryLight = Color(0xFF66BB6A);
  static const Color primaryDark = Color(0xFF388E3C);
  
  // Secondary colors - Warm Orange/Peach (#FF8A65) - warmth, enthusiasm, comfort
  static const Color secondary = Color(0xFFFF8A65); // Warm orange/peach - accent
  static const Color secondaryLight = Color(0xFFFFAB91);
  static const Color secondaryDark = Color(0xFFFF7043);
  
  // Light theme background colors - Clean and calming
  static const Color background = Color(0xFFECEFF1); // Very light gray - main bg
  static const Color surface = Color(0xFFFFFFFF); // Pure white surface
  static const Color cardBackground = Color(0xFFFFFFFF); // Pure white cards
  
  // Dark theme background colors - Deep and sophisticated
  static const Color backgroundDark = Color(0xFF1A1A1A); // Deep charcoal
  static const Color surfaceDark = Color(0xFF2D2D2D); // Elevated dark surface
  static const Color cardBackgroundDark = Color(0xFF333333); // Dark card surface
  
  // Light theme glass effect colors
  static const Color glassBackground = Color(0xFFFFFFFF); // Pure white base
  static const Color glassTint = Color(0xFF4CAF50); // Soft teal tint
  static const Color glassBorder = Color(0xFF78909C); // Medium gray border
  static const Color glassOverlay = Color(0x0A4CAF50); // Subtle teal overlay
  static const Color glassHighlight = Color(0x1A4CAF50); // Teal highlight
  
  // Dark theme glass effect colors
  static const Color glassBackgroundDark = Color(0xFF333333); // Dark glass base
  static const Color glassTintDark = Color(0xFF4CAF50); // Soft teal tint (same)
  static const Color glassBorderDark = Color(0xFF78909C); // Medium gray border
  static const Color glassOverlayDark = Color(0x1A4CAF50); // Teal overlay
  static const Color glassHighlightDark = Color(0x33FFFFFF); // Light highlight
  
  // Light theme text colors - Clear hierarchy with charcoal base
  static const Color textPrimary = Color(0xFF263238); // Dark charcoal
  static const Color textSecondary = Color(0xFF78909C); // Medium gray
  static const Color textLight = Color(0xFFB0BEC5); // Light gray
  static const Color textOnGlass = Color(0xFF263238); // High contrast on glass
  
  // Dark theme text colors - Light contrast hierarchy
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondaryDark = Color(0xFFCCCCCC); // Light gray
  static const Color textLightDark = Color(0xFF78909C); // Medium gray
  static const Color textOnGlassDark = Color(0xFFFFFFFF); // High contrast on dark glass
  
  // Status colors - Clear and friendly
  static const Color success = Color(0xFF4CAF50); // Green (same as primary)
  static const Color warning = Color(0xFFFF8A65); // Orange (same as secondary)
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF2196F3); // Blue
  
  // Accent colors - Harmonious with new palette
  static const Color accent1 = Color(0xFF4CAF50); // Soft teal - primary
  static const Color accent2 = Color(0xFFFF8A65); // Warm orange - secondary
  static const Color accent3 = Color(0xFFFFD54F); // Muted yellow/gold - highlights
  static const Color accent4 = Color(0xFF66BB6A); // Fresh green - success
  
  // Pet category colors - Aligned with new scheme
  static const Color dogColor = Color(0xFFFF8A65); // Warm orange
  static const Color catColor = Color(0xFF4CAF50); // Soft teal
  static const Color birdColor = Color(0xFFFFD54F); // Muted gold
  static const Color rabbitColor = Color(0xFF66BB6A); // Fresh green
  static const Color otherPetColor = Color(0xFF9C27B0); // Purple
  
  // Adoption status colors - Clear visual hierarchy
  static const Color available = Color(0xFF4CAF50); // Soft teal - available
  static const Color pending = Color(0xFFFF8A65); // Warm orange - pending
  static const Color adopted = Color(0xFF78909C); // Medium gray - adopted
  
  // Glass morphism specific colors
  static const Color glassBlur = Color(0x1AFFFFFF); // Ultra-light white
  static const Color glassShadow = Color(0x0F000000); // Soft black shadow
  static const Color glassReflection = Color(0x33FFFFFF); // Bright reflection
  static const Color separator = Color(0xFF78909C); // Medium gray separator
  
  // Light theme gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF4CAF50),
    Color(0xFF66BB6A),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFF8A65),
    Color(0xFFFFAB91),
  ];
  
  static const List<Color> glassGradient = [
    Color(0xCCFFFFFF), // 80% opacity white
    Color(0xB3FFFFFF), // 70% opacity white
  ];
  
  // Dark theme gradient colors
  static const List<Color> primaryGradientDark = [
    Color(0xFF4CAF50),
    Color(0xFF388E3C),
  ];
  
  static const List<Color> secondaryGradientDark = [
    Color(0xFFFF8A65),
    Color(0xFFFF7043),
  ];
  
  static const List<Color> glassGradientDark = [
    Color(0xCC333333), // 80% opacity dark
    Color(0xB32D2D2D), // 70% opacity dark
  ];
  
  // Special pet adoption themed colors
  static const Color heartColor = Color(0xFFE91E63); // Pink for favorites
  static const Color pawColor = Color(0xFF4CAF50); // Soft teal for paw prints
  static const Color adoptionBadge = Color(0xFF4CAF50); // Soft teal for adoption badges
} 