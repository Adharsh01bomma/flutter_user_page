import 'package:flutter/material.dart';
import 'package:flutter_user_page/login.dart';
import 'package:flutter_user_page/register.dart';
import 'package:flutter_user_page/user_detailspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: {
        '/register': (context) => const MyRegister(),
        '/login': (context) => const MyLogin(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user_details') {
          final args = settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String;

          return MaterialPageRoute(
            builder: (context) => UserDetailspage(email: email),
          );
        }
        return null; // Return null if route doesn't match
      },
    );
  }
}
