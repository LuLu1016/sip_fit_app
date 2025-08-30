import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Logo
            Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  AppIcons.wine,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: const Duration(milliseconds: 600),
              ),
            const SizedBox(height: 48),
            // Title
            Text(
              'Start your drink & fit journey\nwith mindful choices',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white.withOpacity(0.9),
                fontFamily: 'Serif',
                height: 1.4,
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 64),
            // Habit Circles
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    shape: BoxShape.circle,
                  ),
                ),
                ...List.generate(3, (index) {
                  final position = index * (2 * 3.14 / 3);
                  final radius = 60.0;
                  return Positioned(
                    left: 100 + radius * math.cos(position),
                    top: 100 + radius * math.sin(position),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                    ).animate(
                      delay: Duration(milliseconds: index * 200),
                    ).fadeIn(duration: const Duration(milliseconds: 600))
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1, 1),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutBack,
                      ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 64),
            // Progress Bar
            Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideX(begin: -0.2, end: 0),
            const Spacer(),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/survey');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      minimumSize: const Size(double.infinity, 64),
                    ),
                    child: const Text(
                      'Begin My Journey',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement account creation
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: Colors.grey[900],
                      minimumSize: const Size(double.infinity, 64),
                    ),
                    child: Text(
                      'Continue with an account',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
