import 'dart:convert';

import 'package:cowpay/api_calls/urls_data.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:flutter/material.dart';

import 'network_util.dart';

class ApiCallsClass {
  static ApiCallsClass _instance = new ApiCallsClass.internal();

  ApiCallsClass.internal();

  factory ApiCallsClass() => _instance;

  NetworkUtil _netUtil = new NetworkUtil();

  //region Fawry
  Future<dynamic> fawryChargeCall(FawryRequestModel fawryRequestModel) async {
    try {
      var res = await _netUtil.post(UrlsData.fawryUrl,
          body: fawryRequestModel.toJson());
      FawryResponseModel fawryResponseModel =
          FawryResponseModel.fromJson(json.decode(json.encode(res)));
      debugPrint('Success ${fawryResponseModel.statusCode.toString()}');
      return fawryResponseModel;
    } catch (error) {
      throw error;
    }
  }

//endregion

}
