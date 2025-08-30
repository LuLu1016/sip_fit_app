import 'package:mongo_dart/mongo_dart.dart';
import 'package:sip_fit/core/config/db_config.dart';
import 'package:sip_fit/data/models/user_interaction_model.dart';
import 'package:sip_fit/data/services/database_service.dart';

class KnowledgeRepository {
  final DatabaseService _dbService;
  late final DbCollection _interactions;
  late final DbCollection _embeddings;

  KnowledgeRepository(this._dbService) {
    _interactions = _dbService.collection(DBConfig.collections['interactions']!);
    _embeddings = _dbService.collection(DBConfig.collections['embeddings']!);
  }

  Future<void> saveInteraction(UserInteraction interaction) async {
    await _interactions.insert(interaction.toJson());
    
    // 生成并存储消息的嵌入向量
    final embedding = await _generateEmbedding(interaction.message);
    await _embeddings.insert({
      'interaction_id': interaction.id,
      'embedding': embedding,
      'timestamp': interaction.timestamp,
    });
  }

  Future<List<UserInteraction>> findSimilarInteractions(
    String query,
    String userId, {
    int limit = 5,
  }) async {
    // 生成查询的嵌入向量
    final queryEmbedding = await _generateEmbedding(query);
    
    // 使用向量相似度搜索找到相关的历史交互
    final pipeline = AggregationPipelineBuilder()
        .addStage(Match({
          'embedding': {
            '\$nearSphere': {
              '\$geometry': {
                'type': 'Point',
                'coordinates': queryEmbedding,
              },
              '\$maxDistance': 0.3, // 相似度阈值
            }
          }
        }))
        .addStage(Limit(limit))
        .build();

    final similarEmbeddings = await _embeddings.aggregateToStream(pipeline).toList();
    final interactionIds = similarEmbeddings.map((e) => e['interaction_id']).toList();

    // 获取完整的交互记录
    final interactions = await _interactions
        .find(where.oneFrom('_id', interactionIds))
        .map((json) => UserInteraction.fromJson(json))
        .toList();

    return interactions;
  }

  Future<List<String>> generateRecommendations(
    UserInteraction currentInteraction,
    List<UserInteraction> similarInteractions,
  ) async {
    // 基于当前上下文和相似历史交互生成推荐
    final recommendations = <String>[];
    
    // 分析时间和天气
    if (currentInteraction.context.timeOfDay == TimeOfDay.evening &&
        currentInteraction.context.weather == WeatherCondition.hot) {
      recommendations.add('A refreshing cucumber spritz would be perfect for this warm evening');
    }

    // 分析运动历史
    if (currentInteraction.context.recentWorkouts.isNotEmpty) {
      recommendations.add(
        'After your ${currentInteraction.context.recentWorkouts.last}, '
        'try our protein-enriched recovery mocktail',
      );
    }

    // 分析压力水平
    if (currentInteraction.context.stressLevel == UserStressLevel.high) {
      recommendations.add(
        'Our calming lavender and chamomile infusion might help you unwind',
      );
    }

    // 从相似交互中学习
    final successfulRecommendations = similarInteractions
        .expand((i) => i.recommendations)
        .where((r) => _wasRecommendationSuccessful(r))
        .toList();

    if (successfulRecommendations.isNotEmpty) {
      recommendations.add(successfulRecommendations.first);
    }

    return recommendations;
  }

  Future<String> generateResponse(
    String userMessage,
    UserInteraction currentInteraction,
    List<UserInteraction> similarInteractions,
  ) async {
    // 基于上下文和历史生成个性化回复
    final context = currentInteraction.context;
    final mood = currentInteraction.mood;
    
    String response = '';

    // 添加情感共鸣
    if (mood == UserMood.stressed) {
      response += "I understand you're feeling stressed. ";
    } else if (mood == UserMood.tired) {
      response += "I can see you've had a long day. ";
    }

    // 添加上下文相关建议
    if (context.remainingDrinkAllowance < 200) {
      response += "Since you're close to your daily limit, ";
    }

    // 从相似交互中学习合适的回复风格
    final successfulResponses = similarInteractions
        .where((i) => _wasResponseSuccessful(i))
        .map((i) => i.agentResponse)
        .toList();

    if (successfulResponses.isNotEmpty) {
      response += _adaptResponseStyle(successfulResponses.first, context);
    }

    return response;
  }

  Future<List<double>> _generateEmbedding(String text) async {
    // TODO: 实现文本嵌入生成
    // 可以使用OpenAI的API或其他嵌入模型
    return List.generate(128, (i) => 0.0);
  }

  bool _wasRecommendationSuccessful(String recommendation) {
    // TODO: 实现推荐成功率评估
    return true;
  }

  bool _wasResponseSuccessful(UserInteraction interaction) {
    // TODO: 实现回复成功率评估
    return true;
  }

  String _adaptResponseStyle(String baseResponse, InteractionContext context) {
    // TODO: 根据上下文调整回复风格
    return baseResponse;
  }
}
