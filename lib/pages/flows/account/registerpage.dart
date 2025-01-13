import 'package:flutter/material.dart';
import 'package:cinema_application/pages/flows/account/loginpage.dart';
import 'package:cinema_application/data/helpers/dbquerieshelper.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final DatabaseQueriesHelper accountHelper = DatabaseQueriesHelper();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void _handleSignUp() async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    final isSuccess = await accountHelper.submitRegister(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email is already registered.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 247),
      appBar: CustomAppBar(centerText: 'Sign up'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(bottom: 80),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 14.0),
                  child: Column(
                    children: [
                      Text(
                        'Let’s get started!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 14, 37, 34),
                        ),
                      ),
                      Text(
                        'Enter your details and then we can continue.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 14, 37, 34),
                        ),
                      )
                    ],
                  )
                ),

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
                      _buildTextField("Full Name", fullNameController),
                      _buildTextField("Email", emailController),
                      _buildTextField("Password", passwordController, obscureText: true),
                      _buildTextField("Phone Number", phoneNumberController),
                      
                      // Sign Up Button
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
                              _handleSignUp();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 196, 64), // Warna tombol
                              foregroundColor: Color.fromARGB(
                                  255, 14, 37, 34), // Warna teks
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: Color.fromARGB(
                                      255, 14, 37, 34), // Tambahkan border
                                  width: 1.2,
                                ),
                              ),
                              elevation:
                                  0, // Set elevation ke 0 untuk menghindari shadow default
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
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
              border: Border.all(color: Color.fromARGB(255, 14, 37, 34), width: 1.2),
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