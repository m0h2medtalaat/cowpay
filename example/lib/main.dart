import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cowpay/api_calls/exceptions.dart';
import 'package:cowpay/cowpay.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:flutter/material.dart';

void main() {
  //TODO Delete this bullshit before publish

  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
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
        appBar: AppBar(
          title: Text('Cowpay'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () => _fawryOnCLick, child: Text('Fawry')),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: ElevatedButton(
                    onPressed: () => _fawryOnCLick, child: Text('Credit Card')),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: ElevatedButton(
                    onPressed: () => _fawryOnCLick,
                    child: Text('Cash Collection')),
              ),
            ],
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

  Future<void> _fawryOnCLick() async {
    try {
      await Cowpay.instance.createFawryReceipt(
        description: 'description',
        amount: '32',
        customerMerchantProfileId: '2312',
        merchantReferenceId: getRandString(),
        customerEmail: 'sqeqedqqw@gmail.com',
        customerMobile: '01234567890',
        customerName: 'customerName',
      );
    } on TimeoutException catch (error) {
      print(error);
    } on SocketException catch (error) {
      print(error);
    } on InternalServerException catch (error) {
      print(error.code);
    }
  }
}
