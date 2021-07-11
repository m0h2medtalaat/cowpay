import 'package:cowpay/api_calls/urls_data.dart';
import 'package:flutter/material.dart';

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

enum DialogType { DIALOG_INFO, DIALOG_WARNING, DIALOG_ERROR }

extension DialogTypeExtension on DialogType {
  Color get color {
    switch (this) {
      case DialogType.DIALOG_INFO:
        return Colors.black;
      case DialogType.DIALOG_WARNING:
        return Colors.amber;
      case DialogType.DIALOG_ERROR:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Image get image {
    switch (this) {
      case DialogType.DIALOG_INFO:
        return Image.asset('resources/images/info_icon.png');
      case DialogType.DIALOG_WARNING:
        return Image.asset('resources/images/warring.png');
      case DialogType.DIALOG_ERROR:
        return Image.asset('resources/images/error.png');
      default:
        return Image.asset('resources/images/info_icon.png');
    }
  }
}
