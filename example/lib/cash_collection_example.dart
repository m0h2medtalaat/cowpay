import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CashCollectionExample extends StatelessWidget {
  double amount = 150.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01068890002";
  String description = "description";
  String customerName = "test name";
  String customerMerchantProfileId = "ExmpleId122345682";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CashCollectionWidget(
        buttonColor: Colors.black,
        buttonTextColor: Colors.white,
        backGroundColor: Colors.red,
        cardColor: Colors.amber,
        textFieldStyle: TextStyle(color: Colors.white),
        textFieldInputDecoration: InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          isDense: false,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
          counterText: '',
          hintText: "hintText.tr()",
          hintStyle:
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
        amount: amount,
        customerEmail: customerEmail,
        customerMobile: customerMobile,
        customerName: customerName,
        description: description,
        customerMerchantProfileId: customerMerchantProfileId,
        merchantReferenceId: getRandString(),
        activeEnvironment: CowpayEnvironment.staging,
        onSuccess: (val) {
          debugPrint(val.result);
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
