import 'package:flutter/material.dart';
import 'package:flutter_user_page/user_database.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserDatabase _db = UserDatabase();

  void _registerUser() async {
    //print("HI Adharsh");
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    print(name);
    print(email);
    print(password);

    if (_formKey.currentState!.validate()) {
      await _db.registerUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/signup.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 2,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 60),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 9, 72), fontSize: 35),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          final RegExp emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (value == null || !emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _registerUser,
                        child: Text('Register'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color.fromARGB(255, 5, 53, 81),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color.fromARGB(255, 5, 53, 81),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
