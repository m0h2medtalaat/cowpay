import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/cowpay_error_model.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:crypto/crypto.dart';

class FawryUseCase {
  Future<dynamic> createFawryReceipt(
      FawryRequestModel fawryRequestModel) async {
    try {
      return await ApiCallsClass().fawryChargeCall(fawryRequestModel);
    } catch (error) {
      var errorModel = CowpayErrorModel(statusCode: 512, success: false,statusDescription: "", type: "internet connection error", errors: error );
      throw (errorModel);
    }
  }

  String generateSignature(List params) {
    String concatenated = params.join("");
    String res = sha256.convert(utf8.encode(concatenated)).toString();
    return res;
  }
}
