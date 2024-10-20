import 'package:postgres/postgres.dart';

class UserDatabase {
  late PostgreSQLConnection _connection;

  Future<void> connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5432,
      'user_database',
      username: 'postgres',
      password: 'Adhi@123',
    );
    await _connection.open();
  }

  Future<void> registerUser(String name, String email, String password) async {
    await _connection.query(
      'INSERT INTO users (name, email, password) VALUES (@name, @e, @p)',
      substitutionValues: {'name': name, 'e': email, 'p': password},
    );
  }

  Future<bool> loginUser(String email, String password) async {
    final result = await _connection.query(
      'SELECT * FROM users WHERE email = @e AND password = @p',
      substitutionValues: {'e': email, 'p': password},
    );
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    final result = await _connection.query('SELECT * FROM users LIMIT 1');
    if (result.isEmpty) return null;
    return {'name': result[0][1], 'email': result[0][2]};
  }

  Future<void> deleteUser() async {
    await _connection.query('DELETE FROM users WHERE id = 1');
  }
}
