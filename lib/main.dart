import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:cinema_application/domain/controllers/auth_controller.dart';
import 'package:cinema_application/pages/mainscreen.dart';
import 'package:cinema_application/data/helpers/dbhelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Supabase
  await Supabase.initialize(
    url: 'https://frildbosqaboisadvdub.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyaWxkYm9zcWFib2lzYWR2ZHViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ1MDg3MTMsImV4cCI6MjA1MDA4NDcxM30.LvhbOXFDyGzrgzg65GSz6wQkaw79PaD0SdiYwdR4S_U',
  );
  print('***** Supabase init completed ${Supabase.instance}');


  // initialize FFI, for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      print("Initializing the database...");
      await dbHelper.database;
      print("Database initialized successfully.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      print("Error during database initialization: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize database: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
