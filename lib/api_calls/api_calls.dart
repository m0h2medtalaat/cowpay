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
      await _netUtil
          .post(UrlsData.fawryUrl, body: fawryRequestModel.toJson())
          .then((dynamic res) async {
        FawryResponseModel fawryResponseModel =
            FawryResponseModel.fromJson(json.decode(json.encode(res)));
      });
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

//endregion

}
