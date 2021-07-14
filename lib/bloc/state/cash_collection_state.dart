import 'package:cowpay/formz_models/num_text_input.dart';
import 'package:cowpay/formz_models/text_input.dart';
import 'package:cowpay/models/cash_collection_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CashCollectionState extends Equatable {
  const CashCollectionState(
      {this.status = FormzStatus.pure,
      this.cashCollectionDistrict = const TextInput.pure(),
      this.cashCollectionAddress = const TextInput.pure(),
      this.cashCollectionFloor = const NumTextInput.pure(),
      this.cashCollectionApartment = const NumTextInput.pure(),
      this.cashCollectionCityCode = const TextInput.pure(),
        this.cityKey,
      this.notValid = 0,
      this.checkValidation = false,
      this.merchantReferenceId,
      this.customerMerchantProfileId,
      this.customerEmail,
      this.customerMobile,
      this.customerName,
      this.amount,
      this.cashCollectionResponseModel,
      this.errorModel,
      this.description});

  final FormzStatus status;

  final TextInput cashCollectionDistrict;
  final TextInput cashCollectionAddress;
  final NumTextInput cashCollectionFloor;
  final NumTextInput cashCollectionApartment;
  final TextInput cashCollectionCityCode;
  final String? cityKey;
  final String? merchantReferenceId;
  final String? customerMerchantProfileId;
  final String? customerEmail;
  final String? customerMobile;
  final String? customerName;
  final String? amount;
  final String? description;

  final int notValid;
  final bool checkValidation;

  final CashCollectionResponseModel? cashCollectionResponseModel;
  final dynamic? errorModel;

  CashCollectionState copyWith(
      {FormzStatus? status,
      TextInput? cashCollectionDistrict,
      TextInput? cashCollectionAddress,
      NumTextInput? cashCollectionFloor,
      NumTextInput? cashCollectionApartment,
      TextInput? cashCollectionCityCode,
      bool? checkValidation,
      int? notValid,
      String? merchantReferenceId,
      String? customerMerchantProfileId,
      String? customerName,
      String? customerEmail,
      String? customerMobile,
      String? amount,
      String? description,
      CashCollectionResponseModel? cashCollectionResponseModel,
        String? cityKey,
      dynamic? errorModel}) {
    return CashCollectionState(
      status: status ?? this.status,
      cityKey: cityKey ?? this.cityKey,
      notValid: notValid ?? this.notValid,
      checkValidation: checkValidation ?? this.checkValidation,
      merchantReferenceId: merchantReferenceId ?? this.merchantReferenceId,
      customerMerchantProfileId:
          customerMerchantProfileId ?? this.customerMerchantProfileId,
      customerEmail: customerEmail ?? this.customerEmail,
      customerMobile: customerMobile ?? this.customerMobile,
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      errorModel: errorModel ?? this.errorModel,
      cashCollectionApartment:
          cashCollectionApartment ?? this.cashCollectionApartment,
      cashCollectionAddress:
          cashCollectionAddress ?? this.cashCollectionAddress,
      cashCollectionFloor: cashCollectionFloor ?? this.cashCollectionFloor,
      cashCollectionDistrict:
          cashCollectionDistrict ?? this.cashCollectionDistrict,
      cashCollectionCityCode:
          cashCollectionCityCode ?? this.cashCollectionCityCode,
      cashCollectionResponseModel:
          cashCollectionResponseModel ?? this.cashCollectionResponseModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cashCollectionDistrict,
        cashCollectionAddress,
        cashCollectionFloor,
        cashCollectionApartment,
        cityKey,
        checkValidation
      ];
}
