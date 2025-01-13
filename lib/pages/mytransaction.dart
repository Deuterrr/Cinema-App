import 'package:flutter/material.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class MyTransactionPage extends StatefulWidget {
  const MyTransactionPage({super.key});

  @override
  State<MyTransactionPage> createState() => _MyTransactionPageState();
}

class _MyTransactionPageState extends State<MyTransactionPage> {
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFFFFF), // White
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: CustomAppBar(
        centerText: 'Transaction',
        showBackButton: false
      ),
    ),
    body: const Center(
      child: Text("Transaction Pages"),
    ),
  );
}
}