import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? recommendedDrinks;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.recommendedDrinks,
  });
}

class ChatHistoryNotifier extends StateNotifier<List<ChatMessage>> {
  ChatHistoryNotifier() : super([
    // 初始化一些示例对话
    ChatMessage(
      id: '1',
      content: "I want to try somewhere new tonight",
      isUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatMessage(
      id: '2',
      content: "Based on your love of gin and your 45-min run today, I recommend trying these drinks:",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 29)),
      recommendedDrinks: [
        "Botanical Garden at Sage",
        "Lavender Fizz at Cloud 9",
        "Cucumber Gin Spritz at The Nest",
        "Herbal Tonic at Green Room"
      ],
    ),
  ]);

  void addMessage(String content, {bool isUser = true, List<String>? recommendedDrinks}) {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: isUser,
      timestamp: DateTime.now(),
      recommendedDrinks: recommendedDrinks,
    );
    state = [...state, message];
  }

  List<String> getLatestRecommendations() {
    final lastAgentMessage = state.lastWhere(
      (message) => !message.isUser && message.recommendedDrinks != null,
      orElse: () => ChatMessage(
        id: '0',
        content: '',
        isUser: false,
        timestamp: DateTime.now(),
        recommendedDrinks: [
          "Classic Mojito",
          "Virgin Colada",
          "Berry Sparkler",
          "Citrus Cooler"
        ],
      ),
    );
    return lastAgentMessage.recommendedDrinks ?? [];
  }
}

final chatHistoryProvider = StateNotifierProvider<ChatHistoryNotifier, List<ChatMessage>>(
  (ref) => ChatHistoryNotifier(),
);
