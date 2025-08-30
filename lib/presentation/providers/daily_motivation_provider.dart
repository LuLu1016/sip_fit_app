import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/user_profile_model.dart';

class DailyMotivationNotifier extends StateNotifier<String> {
  DailyMotivationNotifier() : super('');

  void generateMotivation(UserProfileModel profile) {
    final List<String> weightLossMotivations = [
      "Today's your day to make healthy choices! Every sip counts towards your goals. 💪",
      "Small changes lead to big results. Let's make every drink choice count! 🌟",
      "You're getting stronger and lighter with each mindful choice. Keep going! 🎯",
    ];

    final List<String> maintenanceMotivations = [
      "Maintaining balance is an art - you're mastering it one drink at a time! ⚖️",
      "Stay consistent with your healthy choices today. You've got this! 🌿",
      "Keep up the great work balancing fitness and fun! 🎉",
    ];

    final List<String> muscleGainMotivations = [
      "Power up your day with protein-rich drinks and smart choices! 💪",
      "Building strength one smart drink choice at a time. Let's grow! 🚀",
      "Feed those muscles with the right drinks. You're getting stronger! 🏋️‍♂️",
    ];

    final List<String> generalMotivations = [
      "Every healthy choice is a step toward your best self! 🌟",
      "Make today count with mindful drinking and active living! 💫",
      "You're creating healthy habits that will last a lifetime! 🎯",
    ];

    final DateTime now = DateTime.now();
    final int dayOfYear = now.difference(DateTime(now.year)).inDays;

    List<String> motivations;
    switch (profile.fitnessGoal) {
      case FitnessGoal.loseWeight:
        motivations = weightLossMotivations;
        break;
      case FitnessGoal.maintainWeight:
        motivations = maintenanceMotivations;
        break;
      case FitnessGoal.buildMuscle:
        motivations = muscleGainMotivations;
        break;
      case FitnessGoal.generalFitness:
        motivations = generalMotivations;
        break;
    }

    state = motivations[dayOfYear % motivations.length];
  }
}

final dailyMotivationProvider = StateNotifierProvider<DailyMotivationNotifier, String>(
  (ref) => DailyMotivationNotifier(),
);
