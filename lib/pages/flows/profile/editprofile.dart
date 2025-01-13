import 'dart:io';

import 'package:cinema_application/data/helpers/dbquerieshelper.dart';
import 'package:cinema_application/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userDetails;
  File? image;
  String? profileimagepath;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    loadPicture();
  }

  Future<void> loadPicture() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      profileimagepath = pref.getString('profile_image');
    });
  }

  Future<void> pickPicture(ImageSource source) async {
    final pickFile = await ImagePicker().pickImage(source: source);
    if (pickFile != null) {
      setState(() {
        image = File(pickFile.path);
        profileimagepath = pickFile.path;
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('profile_image', pickFile.path);
    }
  }

  void showimage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a Photo'),
            onTap: () {
              Navigator.of(context).pop();
              pickPicture(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              pickPicture(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _checkLoginStatus() async {
    String? lastLoginEmail = await DatabaseQueriesHelper().getLastLogin();

    if (lastLoginEmail != null) {
      final user = await DatabaseQueriesHelper().getUserByEmail(lastLoginEmail);
      if (user != null) {
        setState(() {
          _isLoggedIn = true;
          _userDetails = user;
        });
        return;
      }
    }

    setState(() {
      _isLoggedIn = false;
      _userDetails = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(centerText: 'Edit Profile'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture with Edit Icon
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileimagepath != null
                      ? FileImage(File(profileimagepath!))
                      : AssetImage('assets/images/pngwing.com.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: showimage,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xffA7D4CB),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.edit, size: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Scrollable Text Container
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    buildInformation(
                        "Name", "${_userDetails?['name'] ?? 'User'}"),
                    buildInformation("Email",
                        _userDetails?['email'] ?? 'Email not available'),
                    buildInformation("Phone Number",
                        "${_userDetails?['phoneNumber'] ?? 'N/A'}"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInformation(String label, String text) {
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
                fontWeight: FontWeight.w500),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Color.fromARGB(255, 14, 37, 34), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
