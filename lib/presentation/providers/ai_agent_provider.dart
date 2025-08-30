import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/user_interaction_model.dart';
import 'package:sip_fit/data/repositories/knowledge_repository.dart';
import 'package:sip_fit/domain/services/ai_agent_service.dart';
import 'package:sip_fit/presentation/providers/database_provider.dart';

class AIAgentState {
  final bool isProcessing;
  final List<UserInteraction> chatHistory;
  final Map<String, dynamic> currentContext;
  final String? error;

  AIAgentState({
    required this.isProcessing,
    required this.chatHistory,
    required this.currentContext,
    this.error,
  });

  AIAgentState copyWith({
    bool? isProcessing,
    List<UserInteraction>? chatHistory,
    Map<String, dynamic>? currentContext,
    String? error,
  }) {
    return AIAgentState(
      isProcessing: isProcessing ?? this.isProcessing,
      chatHistory: chatHistory ?? this.chatHistory,
      currentContext: currentContext ?? this.currentContext,
      error: error,
    );
  }
}

class AIAgentNotifier extends StateNotifier<AIAgentState> {
  final AIAgentService _agentService;

  AIAgentNotifier(this._agentService)
      : super(AIAgentState(
          isProcessing: false,
          chatHistory: [],
          currentContext: {},
        ));

  Future<void> sendMessage(String userId, String message) async {
    try {
      state = state.copyWith(isProcessing: true, error: null);

      // 构建当前上下文
      final context = InteractionContext(
        currentCalories: state.currentContext['current_calories'] ?? 0.0,
        remainingDrinkAllowance:
            state.currentContext['remaining_drink_allowance'] ?? 850.0,
        recentWorkouts: List<String>.from(
            state.currentContext['recent_workouts'] ?? []),
        timeOfDay: _getCurrentTimeOfDay(),
        location: state.currentContext['location'] ?? 'unknown',
        weather: _getCurrentWeather(),
        stressLevel: _getCurrentStressLevel(),
      );

      // 处理消息
      final response = await _agentService.processUserMessage(
        userId,
        message,
        context,
      );

      // 更新状态
      final newInteraction = UserInteraction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        message: message,
        agentResponse: response.message,
        context: context,
        timestamp: DateTime.now(),
        recommendations: response.recommendations,
        mood: await _agentService._analyzeMood(message),
        tags: await _agentService._extractTags(message),
      );

      state = state.copyWith(
        isProcessing: false,
        chatHistory: [...state.chatHistory, newInteraction],
        currentContext: response.context,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }

  void updateContext(Map<String, dynamic> newContext) {
    state = state.copyWith(
      currentContext: {
        ...state.currentContext,
        ...newContext,
      },
    );
  }

  TimeOfDay _getCurrentTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return TimeOfDay.morning;
    } else if (hour >= 12 && hour < 17) {
      return TimeOfDay.afternoon;
    } else if (hour >= 17 && hour < 22) {
      return TimeOfDay.evening;
    } else {
      return TimeOfDay.night;
    }
  }

  WeatherCondition _getCurrentWeather() {
    // TODO: 实现天气获取
    return WeatherCondition.moderate;
  }

  UserStressLevel _getCurrentStressLevel() {
    // TODO: 基于用户活动和生物指标估算压力水平
    return UserStressLevel.moderate;
  }
}

final aiAgentProvider =
    StateNotifierProvider<AIAgentNotifier, AIAgentState>((ref) {
  final dbService = ref.watch(databaseProvider);
  final knowledgeRepo = KnowledgeRepository(dbService);
  final agentService = AIAgentService(knowledgeRepo);
  return AIAgentNotifier(agentService);
});
