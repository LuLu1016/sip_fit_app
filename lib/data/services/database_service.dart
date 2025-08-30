import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sip_fit/core/config/db_config.dart';
import 'package:sip_fit/data/services/mock_database_service.dart';

// 为web平台导出模拟服务
export 'mock_database_service.dart' if (dart.library.io) 'real_database_service.dart';

class DatabaseService implements MockDatabaseService {
  final dynamic _service;

  DatabaseService() : _service = kIsWeb ? MockDatabaseService() : throw UnimplementedError();

  @override
  Future<void> connect() => _service.connect();

  @override
  Future<void> close() => _service.close();

  @override
  MockCollection collection(String name) => _service.collection(name);

  @override
  Future<bool> isHealthy() => _service.isHealthy();
}