import 'package:flutter/material.dart';
import 'package:quick_foodie/widget/widget_support.dart';

class DefaultWalletAmount extends StatelessWidget {
  final String amount;

  const DefaultWalletAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE9E2E2),
        ),
      ),
      child: Text(
        amount,
        style: AppWidget.semiBoldTextFeildStyle(),
      ),
    );
  }
}
