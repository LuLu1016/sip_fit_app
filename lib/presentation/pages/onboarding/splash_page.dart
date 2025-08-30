import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/start');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple.withOpacity(0.1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Text(
              'SipFit.',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryPurple,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 16),
            // Tagline
            Text(
              'Tiny sips, remarkable changes.',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textMedium,
                fontFamily: 'Serif',
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(duration: const Duration(milliseconds: 800))
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuart,
        ),
    );
  }
}
