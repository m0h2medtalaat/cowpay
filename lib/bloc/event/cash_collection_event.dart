import 'package:flutter/material.dart';

abstract class CashCollectionEvent {
  const CashCollectionEvent();
}

class CashCollectionChargeStarted extends CashCollectionEvent {
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final String customerEmail;
  final String customerName;
  final String customerMobile;
  final String amount;
  final String description;

  const CashCollectionChargeStarted(
      {required this.merchantReferenceId,
      required this.customerMerchantProfileId,
      required this.customerEmail,
      required this.customerMobile,
      required this.customerName,
      required this.amount,
      required this.description});
}

class CashCollectionDistrictChange extends CashCollectionEvent {
  const CashCollectionDistrictChange(this.cashCollectionDistrict);

  final String cashCollectionDistrict;
}

class CashCollectionAddressChange extends CashCollectionEvent {
  const CashCollectionAddressChange(this.cashCollectionAddress);
  final String cashCollectionAddress;
}

class CashCollectionFloorChange extends CashCollectionEvent {
  const CashCollectionFloorChange(this.cashCollectionFloor);
  final String cashCollectionFloor;
}

class CashCollectionApartmentChange extends CashCollectionEvent {
  const CashCollectionApartmentChange(this.cashCollectionApartment);

  final String cashCollectionApartment;
}

class CashCollectionCityCodeChange extends CashCollectionEvent {
  const CashCollectionCityCodeChange(this.cashCollectionCityCode);

  final String cashCollectionCityCode;
}

class ChargeValidation extends CashCollectionEvent {
  const ChargeValidation(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [];
}

class ChargeSubmitted extends CashCollectionEvent {
  const ChargeSubmitted();
}
