import 'package:flutter/material.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class Transactionpages extends StatefulWidget {
  const Transactionpages({super.key});

  @override
  State<Transactionpages> createState() => _TransactionpagesState();
}

class _TransactionpagesState extends State<Transactionpages> {
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 253, 247),
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: CustomAppBar(title: 'Transaction', showBackButton: false),
    ),
    body: const Center(
      child: Text("Transaction Pages"),
    ),
  );
}
}