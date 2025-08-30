import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/presentation/pages/dashboard_page.dart';
import 'package:sip_fit/presentation/pages/bars_list_page.dart';
import 'package:sip_fit/presentation/pages/my_sippy_page.dart';
import 'package:sip_fit/presentation/pages/fitness_drink_survey_page.dart';
import 'package:sip_fit/presentation/pages/survey_results_page.dart';
import 'package:sip_fit/presentation/pages/onboarding/splash_page.dart';
import 'package:sip_fit/presentation/pages/onboarding/start_page.dart';
import 'package:sip_fit/presentation/pages/onboarding/habits_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SipFit',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryPurple,
          secondary: AppColors.primaryPink,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/start': (context) => const StartPage(),
        '/habits': (context) => const HabitsPage(),
        '/': (context) => const MainTabNavigation(),
        '/survey': (context) => const FitnessDrinkSurveyPage(),
        '/survey_results': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return SurveyResultsPage(responses: args);
        },
      },
    );
  }
}

class MainTabNavigation extends ConsumerStatefulWidget {
  const MainTabNavigation({super.key});

  @override
  ConsumerState<MainTabNavigation> createState() => _MainTabNavigationState();
}

class _MainTabNavigationState extends ConsumerState<MainTabNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const DashboardPage(),
    const BarsListPage(),
    const MySippyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(AppIcons.wine),
              label: 'My Drinks',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.gift),
              label: 'Points',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.sparkles),
              label: 'My Sippy',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.textLight,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}