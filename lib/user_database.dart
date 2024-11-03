import 'package:postgres/postgres.dart';

class UserDatabase {
  late final PostgreSQLConnection _connection;
  //  = PostgreSQLConnection(
  //     'localhost',
  //     5432,
  //     'user_database',
  //     username: 'postgres',
  //     password: 'postgres',
  //   );

  Future<void> connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5432,
      'user_database',
      username: 'postgres',
      password: 'postgres',
    );
    await _connection.open();
  }

  Future<void> registerUser(String name, String email, String password) async {
    try {
      await connectToDatabase();
      // await _connection.open();
      await _connection.query(
        'INSERT INTO users (name, email, password) VALUES (@name, @e, @p)',
        substitutionValues: {'name': name, 'e': email, 'p': password},
      );
      // await _connection.close();
    } catch (e) {
      //print("in catch box");
      //print(e.toString());
      print("Error registering user: $e");
    } finally {
      await _connection.close();
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await connectToDatabase();
      final result = await _connection.query(
        'SELECT * FROM users WHERE email = @e AND password = @p',
        substitutionValues: {'e': email, 'p': password},
      );
      return result.isNotEmpty;
    } catch (e) {
      print("Error logging in user: $e");
      return false;
    } finally {
      await _connection.close();
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      await connectToDatabase();
      final result = await _connection.query(
        'SELECT * FROM users WHERE email = @e LIMIT 1',
        substitutionValues: {'e': email},
      );
      if (result.isEmpty) return null;
      return {'name': result[0][1], 'email': result[0][2]};
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    } finally {
      await _connection.close();
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      await connectToDatabase();
      await _connection.query(
        'DELETE FROM users WHERE email = @e',
        substitutionValues: {'e': email},
      );
    } catch (e) {
      print("Error deleting user: $e");
    } finally {
      await _connection.close();
    }
  }
}
