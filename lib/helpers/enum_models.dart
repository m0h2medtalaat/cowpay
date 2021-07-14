import 'package:cowpay/api_calls/urls_data.dart';
import 'package:flutter/material.dart';

enum CowpayEnvironment { production, staging }

enum LocalizationCode { en, ar }

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

 Map<String,String> citiesListEn ={
  "Cairo":"EG-01" ,
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
   "Port Said":"EG-13" ,
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

Map<String,String> citiesListAr ={
  "القاهرة":"EG-01" ,
  "الجيزة و الهرم":"EG-01" ,
  "الاسكندرية": "EG-02" ,
  "الساحل":"EG-03" ,
  "البحيرة":"EG-04",
  "الدقهلية":"EG-05" ,
  "القليوبية":"EG-06" ,
  "الغربية":"EG-07" ,
  "كفر الشيخ":"EG-08" ,
  "المنوفية":"EG-09",
  "الشرقية":"EG-10" ,
  "الاسماعيلية":"EG-11" ,
  "السويس":"EG-12" ,
  "بورسعيد":"EG-13" ,
  "دمياط":"EG-14",
  "الفيوم":"EG-15" ,
  "بني سويف":"EG-16" ,
  "اسيوط":"EG-17",
  "سوهاج":"EG-18" ,
  "المنيا":"EG-19"
  ,"قنا":"EG-20" ,
  "اسوان":"EG-21",
  "الاقصر":"EG-22",
};

Map<String,String> localizationMapEn ={
  "district":"District" ,
  "address":"Address" ,
  "floor":"Floor" ,
  "apartment":"Apartment",
  "city":"City" ,
  "confirm":"CONFIRM",
  "egp":"EGP"  ,
  "mm":"MM",
  "yy":"YY",
  "cardHolderName":"Card Holder Name",
  "cardNumber":"Card Number",
  "cvv":"CVV",
  "pay":"PAY"
};

Map<String,String> localizationMapAr ={
  "district":"الحى" ,
  "address":"العنوان" ,
  "floor":"الطابق" ,
  "apartment":"الشقة",
  "city":"المحافظة" ,
  "confirm":"تأكيد",
  "egp":"جم",
  "mm":"شهر" ,
  "yy":"سنة",
"cardHolderName":"اسم حامل البطاقة",
  "cardNumber":"رقم البطاقة",
  "cvv":"رمز الامان (CVV)",
  "pay":"ادفع"
};

