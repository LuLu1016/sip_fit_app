import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:sip_fit/core/widgets/elegant_icon.dart';
import 'package:sip_fit/presentation/providers/chat_history_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sip_fit/core/widgets/drink_card.dart';

class MySippyPage extends ConsumerStatefulWidget {
  const MySippyPage({super.key});

  @override
  ConsumerState<MySippyPage> createState() => _MySippyPageState();
}

class _MySippyPageState extends ConsumerState<MySippyPage> {
  final TextEditingController _messageController = TextEditingController();
  bool _showSurvey = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _startSurvey() {
    Navigator.pushNamed(context, '/survey');
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final chatNotifier = ref.read(chatHistoryProvider.notifier);
    chatNotifier.addMessage(_messageController.text);

    // 模拟AI回复
    Future.delayed(const Duration(seconds: 1), () {
      chatNotifier.addMessage(
        "Based on your message and recent activities, here are some personalized recommendations:",
        isUser: false,
        recommendedDrinks: [
          "Minty Mojito",
          "Tropical Sunrise",
          "Berry Blast",
          "Citrus Fizz"
        ],
      );
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatHistory = ref.watch(chatHistoryProvider);
    final recommendations = ref.read(chatHistoryProvider.notifier).getLatestRecommendations();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSurveyButton(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRecommendations(recommendations),
                    const SizedBox(height: 24),
                    _buildChatHistory(chatHistory),
                  ],
                ),
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.purpleToPinkGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              AppIcons.sparkles,
              color: AppColors.textWhite,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Sippy',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Your personal drink advisor',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildSurveyButton() {
    return GestureDetector(
      onTap: _startSurvey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.purpleToOrangeGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take the Drink Survey',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Get personalized recommendations',
                  style: TextStyle(
                    color: AppColors.textWhite.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.textWhite.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                AppIcons.arrowRight,
                color: AppColors.textWhite,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: -0.2, end: 0);
  }

  Widget _buildRecommendations(List<String> drinks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended for You',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            return DrinkCard(
              name: drinks[index],
              type: _getDrinkType(drinks[index]),
            );
          },
        ),
      ],
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildChatHistory(List<ChatMessage> messages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chat with Sippy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...messages.map((message) => _buildChatMessage(message)),
      ],
    );
  }

  String _getDrinkType(String drinkName) {
    final name = drinkName.toLowerCase();
    if (name.contains('garden') || name.contains('herbal') || name.contains('mint')) {
      return 'botanical';
    } else if (name.contains('fizz') || name.contains('spritz')) {
      return 'refreshing';
    } else if (name.contains('latte') || name.contains('smoothie')) {
      return 'creamy';
    } else if (name.contains('tea') || name.contains('coffee')) {
      return 'warming';
    } else if (name.contains('citrus') || name.contains('lemon') || name.contains('orange')) {
      return 'citrus';
    }
    return 'classic';
  }

  Widget _buildChatMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.purpleToPinkGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                AppIcons.sparkles,
                color: AppColors.textWhite,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? AppColors.primaryPurple
                        : AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: TextStyle(
                          color: message.isUser
                              ? AppColors.textWhite
                              : AppColors.textDark,
                        ),
                      ),
                      if (message.recommendedDrinks != null) ...[
                        const SizedBox(height: 8),
                        ...message.recommendedDrinks!.map(
                          (drink) => Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(
                                  AppIcons.wine,
                                  color: AppColors.primaryPink,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  drink,
                                  style: TextStyle(
                                    color: AppColors.primaryPink,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                AppIcons.user,
                color: AppColors.textMedium,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 300));
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ask Sippy anything...',
                prefixIcon: Icon(
                  AppIcons.message,
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Icon(
              AppIcons.send,
              color: AppColors.textWhite,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}