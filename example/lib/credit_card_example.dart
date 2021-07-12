import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreditCardExample extends StatelessWidget {
  double amount = 150.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01068890002";
  String description = "description";
  String customerName = "test name";
  String customerMerchantProfileId = "ExmpleId122345682";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreditCardWidget(
        buttonTextColor: Colors.white,
        amount: amount,
        customerEmail: customerEmail,
        customerMobile: customerMobile,
        customerName: customerName,
        description: description,
        customerMerchantProfileId: customerMerchantProfileId,
        merchantReferenceId: getRandString(),
        activeEnvironment: CowpayEnvironment.staging,
        onSuccess: (val) {
          debugPrint(val.statusDescription);
          // Navigator.pop(context);
        },
        onError: (val) {
          debugPrint(val.toString());
        },
      ),
    );
  }

  String getRandString() {
    Random random = new Random();
    int randomNumber = random.nextInt(9000) + 1000;
    return randomNumber.toString();
  }
}
