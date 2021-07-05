import 'package:cowpay/api_calls/urls_data.dart';

enum CowpayEnvironment { production, staging }

extension CowpayEnvironmenteExtension on CowpayEnvironment {
  String? get baseUrl {
    switch (this) {
      case CowpayEnvironment.production:
        return UrlsData.host_production;
      case CowpayEnvironment.staging:
        return UrlsData.host_staging;
    }
  }
}
