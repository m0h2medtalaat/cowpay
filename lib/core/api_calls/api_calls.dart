//import 'package:flutter/material.dart';
//
//import 'urls_data.dart';
//import 'network_util.dart';
//
//class ApiCallsClass {
//  static ApiCallsClass _instance = new ApiCallsClass.internal();
//
//  ApiCallsClass.internal();
//
//  factory ApiCallsClass() => _instance;
//
//  NetworkUtil _netUtil = new NetworkUtil();
//
//  //region Auth
//  Future<dynamic> loginCall(
//      String userName, String password, BuildContext context) async {
//    try {
//      await _netUtil.postUrlEncoded(UrlsData.loginUrl, body: {
//        "userName": userName,
//        "password": password,
//      }).then((dynamic res) async {
//        //TODO: Add login model
//        return;
//      });
//    } catch (error) {
//      debugPrint(error.toString());
//      throw error;
//    }
//  }
//  //endregion
//
//}
//
////TODO replace 'test_structure' with your application name here
