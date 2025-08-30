import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Logo
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  AppIcons.wine,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: const Duration(milliseconds: 600),
              ),
            const SizedBox(height: 24),
            Text(
              'SipFit.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Serif',
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 32),
            // Action Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'I will',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textMedium,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'take action',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'so that I can become',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textMedium,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'the type of person I\nwant to be',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      fontFamily: 'Serif',
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 800))
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuart,
              ),
            const SizedBox(height: 48),
            // Action Button
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/habits');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Center(
                  child: Text(
                    'PRESS AND HOLD TO GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, end: 0),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
