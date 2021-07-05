import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:flutter/material.dart';
import 'package:cowpay/cowpay.dart';

void main() {

  //TODO Delete this bullshit before publish

  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
  String merchantCode = "Chy9jpiJSONq";
  String merchantHash = "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
  Cowpay.instance.init(cowpayEnvironment: CowpayEnvironment.staging,
      token: token,
      merchantCode: merchantCode,
      merchantHash: merchantHash,);
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
                  Cowpay.instance.createFawryReceipt(fawryRequestModel: FawryRequestModel());
                },
                child: Text('Credit Card')),
          ),
        ),
      ),
    );
  }
}
