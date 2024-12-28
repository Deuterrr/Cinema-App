import 'package:flutter/material.dart';
import 'package:cinema_application/pages/accountflow/accountlogin.dart';
import 'package:cinema_application/pages/accountflow/accountsignup.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class Accountsetup extends StatelessWidget {
  const Accountsetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 247),
      appBar: CustomAppBar(title: ''),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Text(
                'Cinema Time',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                )
              ),

              // Button and Text Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text
                    Text(
                      "Don't miss the hottest movies. Log in to book your seats now!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    //Login Button
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 42,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.2),
                              offset: Offset(1, 2),
                              // blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Accountlogin()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 255, 196, 64), // Warna tombol
                            foregroundColor:
                                Color.fromARGB(255, 14, 37, 34), // Warna teks
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
                            'Sign in',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // "Register here"
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 14, 37, 34),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Accountsignup()));
                    },
                    child: Text(
                      " Register here",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 14, 37, 34),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
