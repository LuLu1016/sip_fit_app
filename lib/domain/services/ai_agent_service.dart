import 'package:sip_fit/data/models/user_interaction_model.dart';
import 'package:sip_fit/data/repositories/knowledge_repository.dart';

class AIAgentService {
  final KnowledgeRepository _knowledgeRepo;

  AIAgentService(this._knowledgeRepo);

  Future<AgentResponse> processUserMessage(
    String userId,
    String message,
    InteractionContext context,
  ) async {
    // 分析用户情绪和意图
    final mood = await _analyzeMood(message);
    final tags = await _extractTags(message);

    // 创建当前交互记录
    final currentInteraction = UserInteraction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      message: message,
      agentResponse: '',
      context: context,
      timestamp: DateTime.now(),
      recommendations: [],
      mood: mood,
      tags: tags,
    );

    // 查找相似的历史交互
    final similarInteractions = await _knowledgeRepo.findSimilarInteractions(
      message,
      userId,
    );

    // 生成推荐
    final recommendations = await _knowledgeRepo.generateRecommendations(
      currentInteraction,
      similarInteractions,
    );

    // 生成个性化回复
    final response = await _knowledgeRepo.generateResponse(
      message,
      currentInteraction,
      similarInteractions,
    );

    // 更新并保存交互记录
    final updatedInteraction = UserInteraction(
      id: currentInteraction.id,
      userId: currentInteraction.userId,
      message: currentInteraction.message,
      agentResponse: response,
      context: currentInteraction.context,
      timestamp: currentInteraction.timestamp,
      recommendations: recommendations,
      mood: currentInteraction.mood,
      tags: currentInteraction.tags,
    );

    await _knowledgeRepo.saveInteraction(updatedInteraction);

    return AgentResponse(
      message: response,
      recommendations: recommendations,
      context: _generateResponseContext(updatedInteraction),
    );
  }

  Future<UserMood> _analyzeMood(String message) async {
    // TODO: 实现情绪分析
    // 可以使用NLP模型或情感分析API
    if (message.toLowerCase().contains('tired')) {
      return UserMood.tired;
    } else if (message.toLowerCase().contains('stress')) {
      return UserMood.stressed;
    }
    return UserMood.relaxed;
  }

  Future<List<String>> _extractTags(String message) async {
    // TODO: 实现关键词提取
    final tags = <String>[];
    
    // 饮品相关标签
    if (message.toLowerCase().contains('cocktail')) {
      tags.add('cocktail');
    }
    if (message.toLowerCase().contains('mocktail')) {
      tags.add('mocktail');
    }

    // 情境相关标签
    if (message.toLowerCase().contains('workout')) {
      tags.add('post-workout');
    }
    if (message.toLowerCase().contains('relax')) {
      tags.add('relaxation');
    }

    return tags;
  }

  Map<String, dynamic> _generateResponseContext(UserInteraction interaction) {
    return {
      'mood': interaction.mood.toString(),
      'time': interaction.context.timeOfDay.toString(),
      'stress_level': interaction.context.stressLevel.toString(),
      'remaining_allowance': interaction.context.remainingDrinkAllowance,
    };
  }
}

class AgentResponse {
  final String message;
  final List<String> recommendations;
  final Map<String, dynamic> context;

  AgentResponse({
    required this.message,
    required this.recommendations,
    required this.context,
  });
}
