import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';

class FawryUseCase{

  Future <FawryResponseModel> createFawrReceipt(FawryRequestModel fawryRequestModel) async{
    return await ApiCallsClass().fawryChargeCall(fawryRequestModel);
  }
}