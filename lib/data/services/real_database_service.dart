import 'package:mongo_dart/mongo_dart.dart';
import 'package:sip_fit/core/config/db_config.dart';

class RealDatabaseService {
  Db? _db;
  bool _isConnected = false;

  // 单例模式
  static final RealDatabaseService _instance = RealDatabaseService._internal();
  factory RealDatabaseService() => _instance;
  RealDatabaseService._internal();

  Future<void> connect() async {
    if (_isConnected) return;

    try {
      _db = await Db.create(DBConfig.mongoUri);
      await _db!.open();
      _isConnected = true;
      
      // 创建索引
      await _createIndexes();
      
      print('Successfully connected to MongoDB.');
    } catch (e) {
      print('Failed to connect to MongoDB: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<void> close() async {
    if (_isConnected && _db != null) {
      await _db!.close();
      _isConnected = false;
    }
  }

  Future<void> _createIndexes() async {
    // 用户交互集合索引
    await _db!.collection(DBConfig.collections['interactions']!).createIndex(
      keys: {
        'userId': 1,
        'timestamp': -1,
      },
    );

    // 文本嵌入集合索引
    await _db!.collection(DBConfig.collections['embeddings']!).createIndex(
      keys: {
        'embedding': '2dsphere',
      },
    );

    // 用户集合索引
    await _db!.collection(DBConfig.collections['users']!).createIndex(
      keys: {
        'email': 1,
      },
      unique: true,
    );
  }

  DbCollection collection(String name) {
    if (!_isConnected || _db == null) {
      throw Exception('Database not connected');
    }
    return _db!.collection(name);
  }

  Future<bool> isHealthy() async {
    if (!_isConnected || _db == null) return false;

    try {
      await _db!.serverStatus();
      return true;
    } catch (e) {
      return false;
    }
  }
}
