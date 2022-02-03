import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:example/cowpay_example.dart';
import 'package:flutter/material.dart';

void main() {
  //TODO Delete this bullshit before publish

  // CowpayHelper.instance.init(
  //   cowpayEnvironment: CowpayEnvironment.staging,
  //   token: token,
  //   merchantCode: merchantCode,
  //   merchantHash: merchantHash,
  // );

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cowpay'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CowpayExample())),
                  child: Text('Launch Cowpay')),
            ),
          ],
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
      // await CowpayHelper.instance.createFawryReceipt(
      //   description: 'description',
      //   amount: '32',
      //   customerMerchantProfileId: '2312',
      //   merchantReferenceId: getRandString(),
      //   customerEmail: 'sqeqedqqw@gmail.com',
      //   customerMobile: '01234567890',
      //   customerName: 'customerName',
      // );
    } on TimeoutException catch (error) {
      print(error);
    } on SocketException catch (error) {
      print(error);
    } on InternalServerException catch (error) {
      print(error.code);
    }
  }
}
