import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';

class UIUtils {
  // Gradient Decorations
  static BoxDecoration gradientCard({
    List<Color>? colors,
    double borderRadius = 24,
    double opacity = 1.0,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors?.map((c) => c.withOpacity(opacity)).toList() ??
            AppColors.purpleToOrangeGradient.map((c) => c.withOpacity(opacity)).toList(),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowColor.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration whiteCard({
    double borderRadius = 24,
    Color? borderColor,
    bool withShadow = true,
  }) {
    return BoxDecoration(
      color: AppColors.backgroundCard,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
          ? Border.all(color: borderColor)
          : null,
      boxShadow: withShadow
          ? [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );
  }

  // Text Styles
  static TextStyle headingStyle({
    Color? color,
    double size = 24,
    FontWeight weight = FontWeight.w900,
  }) {
    return TextStyle(
      color: color ?? AppColors.textDark,
      fontSize: size,
      fontWeight: weight,
    );
  }

  static TextStyle bodyStyle({
    Color? color,
    double size = 16,
    FontWeight weight = FontWeight.w500,
  }) {
    return TextStyle(
      color: color ?? AppColors.textMedium,
      fontSize: size,
      fontWeight: weight,
    );
  }

  // Button Styles
  static ButtonStyle gradientButton({
    List<Color>? colors,
    double borderRadius = 16,
  }) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ).copyWith(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(AppColors.textWhite),
      overlayColor: MaterialStateProperty.all(AppColors.shadowColor.withOpacity(0.1)),
    );
  }

  static ButtonStyle outlinedButton({
    Color? borderColor,
    double borderRadius = 16,
  }) {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(
        color: borderColor ?? AppColors.borderColor,
        width: 2,
      ),
    ).copyWith(
      foregroundColor: MaterialStateProperty.all(AppColors.textMedium),
      overlayColor: MaterialStateProperty.all(AppColors.shadowColor.withOpacity(0.05)),
    );
  }

  // Input Decoration
  static InputDecoration searchInputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.primaryPurple, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Animation Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bouncyCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutExpo;
}
