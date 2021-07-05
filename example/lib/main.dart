import 'package:flutter/material.dart';
import 'package:cowpay/cowpay.dart';

void main() {
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
                // onTap: ()=>,
                child: Text('Credit Card')),
          ),
        ),
      ),
    );
  }
}
