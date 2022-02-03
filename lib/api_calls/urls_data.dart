import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/helpers/enum_models.dart';

class UrlsData {
  CowpayEnvironment cowpayEnvironment = CowpayEnvironment.staging;

  static const String host_production = "https://cowpay.me";
  static const String host_staging = "https://staging.cowpay.me";

  static const basicUrl = '/api/v1/';

  //region Fawry
  static final fawryUrl =
      'https://staging.cowpay.me' + basicUrl + 'charge/fawry';

  //endregion

  //region Credit Card
  static final creditCardUrl =
      CowpayHelper.activeEnvironment!.baseUrl! + basicUrl + 'charge/card';

  //endregion

  //region Cash Collection
  static final cashCollectionUrl = CowpayHelper.activeEnvironment!.baseUrl! +
      basicUrl +
      'charge/cash-collection';
//endregion

}
