import 'package:flutter/material.dart';
import 'package:flutter_user_page/user_database.dart';

class UserDetailspage extends StatefulWidget {
  const UserDetailspage({super.key});

  @override
  State<UserDetailspage> createState() => _UserDetailspageState();
}

class _UserDetailspageState extends State<UserDetailspage> {
  final UserDatabase _db = UserDatabase();
  Map<String, dynamic>? _userDetails;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    final details = await _db.getUserDetails();
    setState(() {
      _userDetails = details;
    });
  }

  void _deleteAccount() async {
    await _db.deleteUser();
    Navigator.pushReplacementNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    if (_userDetails == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_userDetails!['name']}'),
            Text('Email: ${_userDetails!['email']}'),
            ElevatedButton(
              onPressed: _deleteAccount,
              child: const Text('Delete Account'),
            )
          ],
        ),
      ),
    );
  }
}
