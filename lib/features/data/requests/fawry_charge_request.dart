import 'package:api_manager/api_manager.dart';
import 'package:cowpay/core/constants/network/urls_data.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';

class FawryChargeRequest with Request, PostRequest {
  const FawryChargeRequest(this.requestModel);

  @override
  final FawryRequestModel requestModel;

  @override
  String get path => UrlsData.fawryUrl;
}
