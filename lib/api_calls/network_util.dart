import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Future<dynamic> post(String url, {Map? body}) async {
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
      return _handleResponse(
        response,
      );
    } on TimeoutException catch (error) {
      throw error;
    } on SocketException catch (error) {
      throw error;
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
    } catch (e) {
      throw ('Error Call');
    }

    switch (statusCode) {
      case 401:
        throw ('Error Call');
        return false;
      case 400:
        throw ('Error Call');

      case 500:
        throw ('Error Call');

      case 200:
        if (res.isEmpty) return true;
        return parsed;
      //TODO
      case 204:
        return true;

      default:
        String message = 'somethingWentWrong';
        if (parsed.containsKey("message") && parsed['message'] != null)
          message = parsed['message'];
        throw ('Error Call');
    }
  }

  Map<String, String> _handleHeaders() {
    Map<String, String> headers;
    headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer " + Cowpay.token!
    };

    debugPrint("header: " + headers.toString());
    return headers;
  }
}
