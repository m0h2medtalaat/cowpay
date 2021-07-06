import 'dart:async';

import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/fawry_request_model.dart';

class FawryUseCase {
  Future<dynamic> createFawryReceipt(
      FawryRequestModel fawryRequestModel) async {
    try {
      return await ApiCallsClass().fawryChargeCall(fawryRequestModel);
    } catch (error) {
      throw (error);
    }
  }
}
