import 'dart:async';
import 'dart:convert';

import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/cash_collection_request_model.dart';
import 'package:crypto/crypto.dart';

class CashCollectionUseCase {
  Future<dynamic> cashCollectionCharge(
      CashCollectionRequestModel cashCollectionRequestModel) async {
    try {
      return await ApiCallsClass()
          .cashCollectionChargeCall(cashCollectionRequestModel);
    } catch (error) {
      throw (error);
    }
  }

  String generateSignature(List params) {
    String concatenated = params.join("");
    String res = sha256.convert(utf8.encode(concatenated)).toString();
    return res;
  }
}
