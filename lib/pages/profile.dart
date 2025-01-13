import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_application/pages/mainscreen.dart';
import 'package:cinema_application/pages/flows/account/accountsetup.dart';
import 'package:cinema_application/data/helpers/dbquerieshelper.dart';
import 'package:cinema_application/pages/flows/profile/editprofile.dart';

import 'package:cinema_application/widgets/customappbar.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _isLoggedIn = false; // Track login state
  Map<String, dynamic>? _userDetails; // Store user details
  String? picturepath;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    loadPicture();
  }

  Future<void> loadPicture() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      picturepath = pref.getString('profile_image');
    });
  }

  void _checkLoginStatus() async {
    // Fetch the last logged-in account from the login table
    String? lastLoginEmail = await DatabaseQueriesHelper().getLastLogin();

    if (lastLoginEmail != null) {
      // Fetch user details from the users table
      final user = await DatabaseQueriesHelper().getUserByEmail(lastLoginEmail);
      if (user != null) {
        setState(() {
          _isLoggedIn = true;
          _userDetails = user;
        });
        return;
      }
    }
  }

  void _deleteLoginStatus() async {
    String? lastLoginEmail = await DatabaseQueriesHelper().getLastLogin();

    if (lastLoginEmail != null) {
      // Attempt to delete the login
      final result = await DatabaseQueriesHelper().deleteLastLogin(lastLoginEmail);
      if (result > 0) {
        setState(() {
          _isLoggedIn = false;
          _userDetails = null;
        });
        return;
      }
    }

    // If no account is logged in or no user details found
    setState(() {
      _isLoggedIn = false;
      _userDetails = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // White
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: CustomAppBar(
          centerText: 'Profile',
          showBackButton: false
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: _isLoggedIn ? loginAccount(context) : notLogin(context),
        ),
      ),
    );
  }

  Widget notLogin(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Button and Text Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
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
                  "You're not logged in. Set up your account to access personalized features and manage your profile.",
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
                              builder: (context) => AccountSetupPage()),
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
                            color: Color.fromARGB(255, 14, 37, 34), // Tambahkan border
                            width: 1.2,
                          ),
                        ),
                        elevation: 0, // Set elevation ke 0 untuk menghindari shadow default
                      ),
                      child: const Text(
                        'Setup Account',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loginAccount(BuildContext context) {
    return Center(
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 20, left: 15),
            height: 86,
            decoration: BoxDecoration(
              color: const Color(0xffF5F0E0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black), // Cleaner border shorthand
            ),
            child: Row(
              children: [
                // Profile Picture
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 48, // Adjust size based on the radius + border thickness
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 14, 37, 34), // Border color
                        width: 1.2,         // Border thickness
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: picturepath != null
                          ? FileImage(File(picturepath!))
                          : AssetImage('assets/images/pngwing.com.png') as ImageProvider,
                    ),
                  ),
                ),
                // Name and Email
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_userDetails?['name'] ?? 'User'}", // Safely access the name
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _userDetails != null
                            ? _userDetails!['email'] ?? 'Email not available'
                            : 'Email not available',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit Icon
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Editprofile()));
                    },
                    child: Container(
                      width: 40.34,
                      height: 40.37,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black)),
                          color: Color(0xffA7D4CB),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [BoxShadow(offset: Offset(2, 4))]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icon/edit.svg',
                            width: 30.3,
                            height: 30.3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //logout button
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
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
                  logOutDiagog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 253, 247), // Warna tombol
                  foregroundColor:Color.fromARGB(255, 106, 149, 140), // Warna teks
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Color.fromARGB(255, 28, 195, 159), // Tambahkan border
                      width: 1.2,
                    ),
                  ),
                  elevation: 0, // Set elevation ke 0 untuk menghindari shadow default
                ),
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Color.fromARGB(255, 106, 149, 140),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  void logOutDiagog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BlurredDialog",
      transitionDuration: Duration(milliseconds: 190),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Static blur background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Color.fromARGB(255, 255, 253, 247).withOpacity(0.58),
                ),
              ),
            ),

            // The Page
            Align(
              alignment: Alignment.center,

              // Page as Animation
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1), // Start from bottom
                  end: Offset(0, 0), // End at center
                ).animate(CurvedAnimation(
                  parent: anim1,
                  curve: Curves.easeOut, // Smooth animation curve
                )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFDF7),
                    border: Border.all(
                      color: const Color.fromARGB(255, 14, 37, 34),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The Title
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Are you sure?",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decorationThickness: 0,
                              ),
                            ),
                          ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 42,
                              width: 130,
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
                                    _deleteLoginStatus();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainScreen())
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 253, 247), // Warna tombol
                                    foregroundColor:Color.fromARGB(255, 106, 149, 140), // Warna teks
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: Color.fromARGB(255, 106, 149, 140), // Tambahkan border
                                        width: 1.2,
                                      ),
                                    ),
                                    elevation: 0, // Set elevation ke 0 untuk menghindari shadow default
                                  ),
                                  child: const Text(
                                    'Log out',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 106, 149, 140),
                                        fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),

                            //Cancel button
                            SizedBox(
                              height: 42,
                              width: 130,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
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
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 14, 37, 34), // Warna tombol
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
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}