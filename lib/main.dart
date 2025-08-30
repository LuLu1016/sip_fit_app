import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the theme
import 'core/constants/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/dashboard_page.dart';
import 'presentation/pages/rewards_page.dart';
import 'presentation/pages/onboarding_survey_page.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/user_profile_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sip Fit',
      theme: AppTheme.lightTheme,
      home: const MainNavigationWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationWrapper extends ConsumerWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final userProfileAsync = ref.watch(userProfileProvider);
    
    // Show login if not authenticated
    if (authState.user == null) {
      return const LoginPage();
    }
    
    // Show onboarding survey if user doesn't have a profile yet
    if (userProfileAsync.value == null) {
      return const OnboardingSurveyPage();
    }
    
    // Show main app if user has completed onboarding
    return const MainTabNavigation();
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
    const RewardsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
        ],
        backgroundColor: AppColors.primaryNavy,
        selectedItemColor: AppColors.accentGreen,
        unselectedItemColor: AppColors.textLight,
      ),
    );
  }
}
