import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool withShadow;

  const GradientContainer({
    super.key,
    required this.child,
    this.colors,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.width,
    this.height,
    this.withShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? AppColors.purpleToOrangeGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
