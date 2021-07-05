import 'dart:convert';

import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:crypto/crypto.dart';

class FawryUseCase{

  Future <FawryResponseModel> createFawrReceipt(FawryRequestModel fawryRequestModel) async{
    try {
      return await ApiCallsClass().fawryChargeCall(fawryRequestModel);
    } catch (error) {
      throw(error);
    }
  }

  String generateSignature(List params) {
    String concatenated = params.join("");
    String res = sha256.convert(utf8.encode(concatenated)).toString();
    return res;
  }
}