class DBConfig {
  static const String mongoUri = String.fromEnvironment(
    'MONGO_URI',
    defaultValue: 'mongodb+srv://your-username:your-password@cluster0.mongodb.net/sip_fit?retryWrites=true&w=majority',
  );

  static const String dbName = 'sip_fit';

  static const collections = {
    'interactions': 'user_interactions',
    'embeddings': 'text_embeddings',
    'users': 'users',
    'drinks': 'drinks',
    'workouts': 'workouts',
  };
}
