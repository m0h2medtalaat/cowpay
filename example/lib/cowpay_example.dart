import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CowpayExample extends StatelessWidget {
  double amount = 150.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01068890002";
  String description = "description";
  String customerMerchantProfileId = "ExmpleId122345682";
  String customerName = "Testing";
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2E3ZjUxMjBkOWE0ZjM5Y2Y0YjAzOGFlODVmMWY4ZDBmYWM4ZWZhZWFkZDgzZTcyZWZmZDI1YzdlYmM4ZWYxOTlkZjAxNjIwZmMyN2NhOWEiLCJpYXQiOiIxNjI2MDEzNjQ1LjA4NDAwOCIsIm5iZiI6IjE2MjYwMTM2NDUuMDg0MDEzIiwiZXhwIjoiMTY1NzU0OTY0NS4wNzkwMjYiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.BSvvHMcdAq-Q10dn1HvSKdXBpecel25oXE9UU9Fm1FsUtrAcDhTrXNGJs_pklmczmBFSXcVTR1Te7W2fwK1uxA";
  String merchantCode = "Chy9jpiJSONq";
  String merchantHash =
      "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
  // String token;
  // String merchantCode;
  // String merchantHash ;

  // CreditCardExample({required this.token,required this.merchantCode,required this.merchantHash});

  @override
  Widget build(BuildContext context) {
    return Cowpay(
      localizationCode: LocalizationCode.en,
      amount: amount,
      customerEmail: customerEmail,
      customerMobile: customerMobile,
      customerName: customerName,
      description: description,
      customerMerchantProfileId: customerMerchantProfileId,
      merchantReferenceId: getRandString(),
      activeEnvironment: CowpayEnvironment.staging,
      merchantCode: merchantCode,
      merchantHash: merchantHash,
      token: token,
      onSuccess: (val) {
        debugPrint(val.statusDescription);
        // Navigator.pop(context);
      },
      onError: (val) {
        debugPrint(val.toString());
      },
    );
  }

  String getRandString() {
    Random random = new Random();
    int randomNumber = random.nextInt(9000) + 1000;
    return randomNumber.toString();
  }
}
