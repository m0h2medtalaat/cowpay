import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/ui/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';

class CreditCardExample extends StatelessWidget {
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
  String merchantCode = "Chy9jpiJSONq";
  String merchantHash =
      "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
  double amount = 150.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01068890002";
  String description = "description";
  String merchantReferenceId = "121222155";
  String customerMerchantProfileId = "ExmpleId122345682";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreditCardWidget(
        token: token,
        amount: amount,
        customerEmail: customerEmail,
        customerMobile: customerMobile,
        merchantHash: merchantHash,
        merchantCode: merchantCode,
        description: description,
        customerMerchantProfileId: customerMerchantProfileId,
        merchantReferenceId: merchantReferenceId,
        activeEnvironment: CowpayEnvironment.staging,
      ),
    );
  }
}
