import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:flutter/material.dart';

void main() {
  //TODO Delete this bullshit before publish

  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
  String merchantCode = "Chy9jpiJSONq";
  String merchantHash =
      "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
  Cowpay.instance.init(
    cowpayEnvironment: CowpayEnvironment.staging,
    token: token,
    merchantCode: merchantCode,
    merchantHash: merchantHash,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: InkWell(
                onTap: () {
                  Cowpay.instance.createFawryReceipt(
                      description: 'description',
                      amount: '32',
                      customerMerchantProfileId: '2312',
                      merchantReferenceId: '123456',
                      customerEmail: 'sqeqedqqw@gmail.com',
                      customerMobile: '01234567890',
                      customerName: 'customerName',
                      onSuccess: (val) {
                        debugPrint('fawrySuccess ${val.type}');
                      },
                      onError: (val) {
                        debugPrint('fawryError $val');
                      });
                },
                child: Text('Fawry')),
          ),
        ),
      ),
    );
  }

  String getRandString() {
    Random random = new Random();
    int randomNumber = random.nextInt(9000) + 1000;
    return randomNumber.toString();
  }
}
