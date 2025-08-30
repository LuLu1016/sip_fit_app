import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/services/database_service.dart';

final databaseProvider = Provider<DatabaseService>((ref) {
  final db = DatabaseService();
  
  ref.onDispose(() {
    db.close();
  });
  
  return db;
});

// 数据库连接状态提供者
final databaseConnectionProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(databaseProvider);
  try {
    await db.connect();
    return await db.isHealthy();
  } catch (e) {
    return false;
  }
});

// 数据库错误处理提供者
final databaseErrorProvider = StateProvider<String?>((ref) => null);
