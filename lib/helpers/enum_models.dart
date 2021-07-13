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

 Map<String,String> testList ={
  "Cairo	Downtown":"EG-01" ,
  "Giza & Haram":"EG-01" ,
 "Downtown Alex": "EG-02" ,
  "Sahel":"EG-03" ,
  "Behira":"EG-04",
  "Dakahlia":"EG-05" ,
  "El Kalioubia":"EG-06" ,
  "Gharbia":"EG-07" ,
   "Kafr Alsheikh":"EG-08" ,
   "Monufia":"EG-09",
  "Sharqia":"EG-10" ,
   "Isamilia":"EG-11" ,
   "Suez":"EG-12" ,
   "Port":"EG-13" ,
   "Damietta":"EG-14",
  "Fayoum":"EG-15" ,
   "Bani Suif":"EG-16" ,
   "Asyut":"EG-17",
   "Sohag":"EG-18" ,
   "Menya":"EG-19"
,"Qena":"EG-20" ,
   "Aswan":"EG-21",
   "Luxor":"EG-22",
};
