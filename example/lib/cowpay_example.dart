import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CowpayExample extends StatelessWidget {
  double amount = 2.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01068890002";
  String description = "description";
  String customerMerchantProfileId = "ExmpleId122345682";
  String customerName = "Testing";
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNzI5MGJiOWNiNTllNDdmMzk1YmExNTNkN2VlZjMzODhmYjVhNDVmZGEzZDE0YmU1MGI5MTFkZjNlNmY3OTM5ZTQ3ZjYxODQ4NzhmNDZmMjQiLCJpYXQiOjE2NTA0NTA4OTAuODQ0NjQ2LCJuYmYiOjE2NTA0NTA4OTAuODQ0NjUxLCJleHAiOjQ4MDYxMjQ0OTAuNzkwODI1LCJzdWIiOiI2OCIsInNjb3BlcyI6W119.dbcCTGtoIAFF0gRD3moqahrANsdf0wbvnzmM-WUvARAvw_f7CKtfUkpE1X-WbvtR0foyQxFu5C_f3l9-lHFYFg";
  String merchantCode = "sgwDzj24xXAc";
  String merchantHash =
      "\$2y\$10\$UZDXXAVFHsXgF6azMT6McuLnK88n3aclJMeL8BNt1AI6/NDbTgHwe";
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
