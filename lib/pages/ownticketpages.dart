import 'package:cinema_application/widgets/customappbar.dart';
import 'package:cinema_application/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class Voucherpages extends StatefulWidget {
  const Voucherpages({super.key});

  @override
  State<Voucherpages> createState() => _VoucherpagesState();
}

class _VoucherpagesState extends State<Voucherpages> {
  bool isVoucherClicked = false;

  void _toggleButton() {
    setState(() {
      isVoucherClicked = !isVoucherClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 247),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: CustomAppBar(title: 'My Vouchers', showBackButton: false,),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Voucher",
                isClicked: isVoucherClicked,
                onPressed: () {
                  if (!isVoucherClicked) {
                    _toggleButton();
                  }
                },
              ),
              SizedBox(width: 8),
              CustomButton(
                text: "Coupon",
                isClicked: !isVoucherClicked,
                onPressed: () {
                  if (isVoucherClicked) {
                    _toggleButton();
                  }
                },
              ),
            ],
          )
        ],
      )
    );
  }
}
