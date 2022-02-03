library cowpay;

import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/helpers/localization.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
export 'package:cowpay/api_calls/exceptions.dart';
export 'package:cowpay/helpers/enum_models.dart';

class WebViewScreen extends StatelessWidget {
  final FawryResponseModel responseModel;


  WebViewScreen({required this.responseModel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Localization().localizationCode == LocalizationCode.ar
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // title: Text(Localization().localizationMap["paymentMethod"]),
          backgroundColor: Color(0xff3D1A54),
        ),
        body: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
