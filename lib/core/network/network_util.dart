import 'dart:async';
import 'dart:convert';

import 'package:cowpay/core/error/exceptions.dart';
import 'package:cowpay/core/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class NetworkUtil {
  Future<dynamic> getList(
    String url,
  );

  Future<dynamic> postWithRaw(String url, {Map? body});

  Future<dynamic> postLogout(String url, {Map? body});

  Future<dynamic> put(String url, {Map? body});

  Future<dynamic> delete(String url, {Map? body});

  Future<dynamic> postUrlEncoded(String url, {Map? body, encoding});

  Future<dynamic> putGetToken(String url, {Map? body, encoding});

  Future<dynamic> get(String url);
}

class NetworkUtilImpl implements NetworkUtil {
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

  Future<dynamic> postWithRaw(String url, {Map? body}) async {
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> postLogout(String url, {Map? body}) async {
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

  Future<dynamic> delete(String url, {Map? body}) async {
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> postUrlEncoded(String url, {Map? body, encoding}) async {
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

  Future<dynamic> putGetToken(String url, {Map? body, encoding}) async {
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

  Object _handleResponse(http.Response response, {bool isList = false}) {
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
      throw FormatException();
    }

    switch (statusCode) {
      /*     case 401:
        throw AuthException();
      case 400:
        throw BadRequestException();

      case 500:
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
        throw UnExpectedException(message: message);
    }
  }

  Map<String, String> _handleHeaders({bool isUrlEncoded = false}) {
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
