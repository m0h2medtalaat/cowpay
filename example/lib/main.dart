import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:example/cash_collection_example.dart';
import 'package:example/credit_card_example.dart';
import 'package:flutter/material.dart';

void main() {
  //TODO Delete this bullshit before publish

  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2E3ZjUxMjBkOWE0ZjM5Y2Y0YjAzOGFlODVmMWY4ZDBmYWM4ZWZhZWFkZDgzZTcyZWZmZDI1YzdlYmM4ZWYxOTlkZjAxNjIwZmMyN2NhOWEiLCJpYXQiOiIxNjI2MDEzNjQ1LjA4NDAwOCIsIm5iZiI6IjE2MjYwMTM2NDUuMDg0MDEzIiwiZXhwIjoiMTY1NzU0OTY0NS4wNzkwMjYiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.BSvvHMcdAq-Q10dn1HvSKdXBpecel25oXE9UU9Fm1FsUtrAcDhTrXNGJs_pklmczmBFSXcVTR1Te7W2fwK1uxA";
  String merchantCode = "Chy9jpiJSONq";
  String merchantHash =
      "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreditCardExample())),
                  child: Text('Credit Card')),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CashCollectionExample())),
                  child: Text('Cash Collection')),
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
