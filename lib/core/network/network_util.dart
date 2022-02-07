import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cowpay/core/error/exceptions.dart';
import 'package:cowpay/helpers/constants.dart';
import 'package:http/http.dart' as http;


class NetworkUtil {
  // next three lines makes this class a Singleton

  Future<dynamic> getList(
    String url,
  ) async {
    Map<String, String> headers = _handleHeaders();

    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 15));

      return _handleResponse(response, isList: true);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<dynamic> postWithRaw( String url,
      {Map? body}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());

    Map<String, String> headers = _handleHeaders();

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonBody,
            encoding: encoding,
          )
          .timeout(Duration(seconds: 15));
      return _handleResponse(response);
    }catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> postLogout(String url,
      {Map? body}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());

    Map<String, String> headers = _handleHeaders();
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonBody,
            encoding: encoding,
          )
          .timeout(Duration(seconds: 15));
      return _handleResponse(response);
    }catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> postOCR( String url,
      {required Map body}) async {
    try {
      debugPrint('ApiCallUrl: ' + url);
      debugPrint('ApiCallBody: ' + body.toString());

      Map<String, String> headers;
      headers = {
        "key": "Content-Type",
        "name": "Content-Type",
        "type": "text",
        "value": "application/json",
        "Accept": "application/json",
        "Content-Type": "application/json",
      };

      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonBody,
            encoding: encoding,
          )
          .timeout(Duration(seconds: 20));

      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> put(String url, {Map? body}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());

    Map<String, String> headers = _handleHeaders();
    String jsonBody = json.encode(body);
    // final encoding = Encoding.getByName('utf-8');

    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
            body: jsonBody,
            //   encoding: encoding,
          )
          .timeout(Duration(seconds: 15));
      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> delete( String url, {Map? body}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());
    Map<String, String> headers = _handleHeaders();

    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
            //   encoding: encoding,
          )
          .timeout(Duration(seconds: 15));
      return _handleResponse(response);
    }catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> postUrlEncoded( String url,
      {Map? body, encoding}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());
    Map<String, String> headers = _handleHeaders(isUrlEncoded: true);

    try {
      final response = await http
          .post(Uri.parse(url),
              body: body,
              headers: headers,
              encoding: Encoding.getByName("utf-8"))
          .timeout(Duration(seconds: 15));

      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> putGetToken( String url,
      {Map? body, encoding}) async {
    debugPrint('ApiCallUrl: ' + url);
    debugPrint('ApiCallBody: ' + body.toString());
    Map<String, String> headers = _handleHeaders();

    try {
      final response = await http
          .put(Uri.parse(url),
              body: body,
              headers: headers,
              encoding: Encoding.getByName("utf-8"))
          .timeout(Duration(seconds: 15));
      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> get(
    String url,
  ) async {
    Map<String, String> headers = _handleHeaders();
    debugPrint('ApiCallUrl: ' + url);

    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 15));

      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Object _handleResponse(http.Response response,
      {bool isList = false}) {
    final int statusCode = response.statusCode;
    var parsed;
    final String res = response.body;
    debugPrint('ApiCallResponse: ' + res);
    try {
      if (isList) {
        var tagsJson = jsonDecode(res);
        parsed = List.from(tagsJson);
      } else {
        parsed = jsonDecode(res).cast<String, dynamic>();
      }
    } on FormatException {
      // _ackAlert(context, 'somethingWentWrong'.tr());
      throw FormatException();
    }

    switch (statusCode) {
 /*     case 401:
        // Navigator.pushNamedAndRemoveUntil(context, "/auth", (r) => false);
        // _ackAlert(context, 'برجاء تسجيل الدخول');
        throw AuthException();
      case 400:
        // _ackAlert(context, 'badRequest'.tr());
        throw BadRequestException();

      case 500:
        // _ackAlert(context, 'internalServerError'.tr());
        throw InternalServerException();
*/
      case 200:
        if (res.isEmpty) return true;
        return parsed;
      //TODO add 204 best practice
      case 204:
        return true;

      default:
        String message = 'somethingWentWrong';
        if (parsed.containsKey("message") && parsed['message'] != null)
          message = parsed['message'];
        if (parsed.containsKey("Message") && parsed['Message'] != null)
          message = parsed['Message'];
        // _ackAlert(context, message);
        throw UnExpectedException(message: message);
    }
  }

  Map<String, String> _handleHeaders(
      {bool isUrlEncoded = false}) {
    Map<String, String> headers;
    headers = {"Accept-Language": 'en'};

    if (isUrlEncoded)
      headers.addAll({"Accept": "application/json"});
    else
      headers.addAll({"Content-Type": "application/json"});

    if (ConstantsData().accessToken != null) {
      headers.addAll({
        "Authorization": "Bearer " + ConstantsData().accessToken!,
      });
    }
    debugPrint("header: " + headers.toString());
    return headers;
  }
}

