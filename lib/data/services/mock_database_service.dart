import 'package:sip_fit/core/config/db_config.dart';

class MockDatabaseService {
  final Map<String, List<Map<String, dynamic>>> _collections = {};
  bool _isConnected = false;

  // 单例模式
  static final MockDatabaseService _instance = MockDatabaseService._internal();
  factory MockDatabaseService() => _instance;
  MockDatabaseService._internal();

  Future<void> connect() async {
    if (_isConnected) return;

    try {
      // 初始化集合
      for (final collection in DBConfig.collections.values) {
        _collections[collection] = [];
      }
      _isConnected = true;
      print('Successfully connected to Mock Database.');
    } catch (e) {
      print('Failed to connect to Mock Database: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<void> close() async {
    _isConnected = false;
  }

  MockCollection collection(String name) {
    if (!_isConnected) {
      throw Exception('Database not connected');
    }
    return MockCollection(_collections[name] ?? []);
  }

  Future<bool> isHealthy() async {
    return _isConnected;
  }
}

class MockCollection {
  final List<Map<String, dynamic>> _documents;

  MockCollection(this._documents);

  Future<void> insert(Map<String, dynamic> document) async {
    _documents.add(document);
  }

  Future<void> insertMany(List<Map<String, dynamic>> documents) async {
    _documents.addAll(documents);
  }

  Stream<Map<String, dynamic>> find([Map<String, dynamic>? query]) async* {
    for (final doc in _documents) {
      if (query == null || _matchesQuery(doc, query)) {
        yield doc;
      }
    }
  }

  Future<List<Map<String, dynamic>>> findToList() async {
    return _documents;
  }

  bool _matchesQuery(Map<String, dynamic> doc, Map<String, dynamic> query) {
    for (final entry in query.entries) {
      if (doc[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }

  Future<void> createIndex({
    required Map<String, dynamic> keys,
    bool? unique,
  }) async {
    // 模拟创建索引
    return;
  }
}
