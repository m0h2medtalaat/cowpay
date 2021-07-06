import 'dart:async';
import 'dart:convert';

import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/credit_card_request_model.dart';
import 'package:crypto/crypto.dart';

class CreditCardUseCase {
  Future<dynamic> createCreditCardCharge(
      CreditCardRequestModel creditCardRequestModel) async {
    try {
      return await ApiCallsClass().creditChargeCall(creditCardRequestModel);
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
