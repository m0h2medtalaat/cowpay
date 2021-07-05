import 'package:cowpay/cowpay.dart';
import 'package:cowpay/helpers/enum_models.dart';

class UrlsData {
  CowpayEnvironment cowpayEnvironment = CowpayEnvironment.staging;

  static const String host_production = "cowpay.me";
  static const String host_staging = "staging.cowpay.me";

  static const basicUrl = '/api/v1/';

  //region Fawry
  static final fawryUrl =
      Cowpay.activeEnvironment!.baseUrl! + basicUrl + 'charge/fawry';

  //endregion

  //region Credit Card
  static final creditCardUrl =
      Cowpay.activeEnvironment!.baseUrl! + basicUrl + 'charge/card';

  //endregion

  //region Cash Collection
  static final cashCollectionUrl =
      Cowpay.activeEnvironment!.baseUrl! + basicUrl + 'charge/cash-collection';
//endregion

}
