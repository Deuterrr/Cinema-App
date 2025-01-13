import 'package:cinema_application/pages/mainscreen.dart';
import 'package:flutter/material.dart';

import 'package:cinema_application/data/helpers/dbquerieshelper.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseQueriesHelper accountHelper = DatabaseQueriesHelper();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleSignIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    final isSuccess = await accountHelper.submitLogin(
      email: email,
      password: password,
    );

    if (isSuccess) await accountHelper.submitLastLogin(email);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username doesn't exist or Password is wrong.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 247),
      appBar: CustomAppBar(
        useAppTitle: false,
        centerText: 'Sign in',
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 42),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Header
                  Padding(
                    padding:
                      const EdgeInsets.only(top: 24.0, bottom: 14.0),
                    child: Column(
                      children: [
                        Text(
                          'Hi, welcome to Cinema Time!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 14, 37, 34),
                          ),
                        ),
                        Text(
                          'Before continue, Please enter your details.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 14, 37, 34),
                          ),
                        )
                      ],
                    )
                  ),

                  //Text Editor and Button
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 42),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 240, 224),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Color.fromARGB(255, 14, 37, 34),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(1, 2),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTextField("Email", emailController),
                        _buildTextField("Password", passwordController,
                            obscureText: true),

                        // login button
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 42,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  offset: Offset(1, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _handleSignIn();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255, 255, 196, 64), // Warna tombol
                                foregroundColor:Color.fromARGB(255, 14, 37, 34), // Warna teks
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Color.fromARGB(
                                        255, 14, 37, 34), // Tambahkan border
                                    width: 1.2,
                                  ),
                                ),
                                elevation: 0, // Set elevation ke 0 untuk menghindari shadow default
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        )
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "     $label",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Color.fromARGB(255, 14, 37, 34), width: 1.2),
            ),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
