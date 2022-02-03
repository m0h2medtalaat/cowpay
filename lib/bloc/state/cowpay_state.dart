import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/models/credit_card_response_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CowpayState extends Equatable {
  const CowpayState(
      {this.status = FormzStatus.pure,
      this.creditCardNumber = const CreditCardNumber.pure(),
      this.creditCardExpiryMonth = const CreditCardExpiryMonth.pure(),
      this.creditCardExpiryYear = const CreditCardExpiryYear.pure(),
      this.creditCardCvv = const CreditCardCvv.pure(),
      this.creditCardHolderName = const CreditCardHolderName.pure(),
      this.notValid = 0,
      this.checkValidation = false,
      this.isNotValidExpirationDate = true,
      this.merchantReferenceId,
      this.customerMerchantProfileId,
      this.customerEmail,
      this.customerMobile,
      this.amount,
      this.creditCardResponseModel,
      this.fawryResponseModel,
      this.errorModel,
      this.description,
      this.yearsList,
      this.customerName,
      this.tabCurrentIndex = 0});

  final FormzStatus status;
  final CreditCardExpiryMonth creditCardExpiryMonth;
  final CreditCardExpiryYear creditCardExpiryYear;
  final CreditCardCvv creditCardCvv;
  final CreditCardNumber creditCardNumber;
  final CreditCardHolderName creditCardHolderName;

  final String? merchantReferenceId;
  final String? customerMerchantProfileId;
  final String? customerEmail;
  final String? customerMobile;
  final String? amount;
  final String? description;
  final String? customerName;

  final int notValid;
  final bool checkValidation;
  final bool isNotValidExpirationDate;

  final List<String>? yearsList;

  final CreditCardResponseModel? creditCardResponseModel;
  final FawryResponseModel? fawryResponseModel;
  final dynamic? errorModel;
  final int tabCurrentIndex;

  CowpayState copyWith(
      {FormzStatus? status,
      CreditCardExpiryMonth? creditCardExpiryMonth,
      CreditCardExpiryYear? creditCardExpiryYear,
      CreditCardCvv? creditCardCvv,
      CreditCardNumber? creditCardNumber,
      CreditCardHolderName? creditCardHolderName,
      bool? checkValidation,
      bool? isNotValidExpirationDate,
      int? notValid,
      String? merchantReferenceId,
      String? customerMerchantProfileId,
      String? customerName,
      String? customerEmail,
      String? customerMobile,
      String? amount,
      String? description,
      CreditCardResponseModel? creditCardResponseModel,
      FawryResponseModel? fawryResponseModel,
      dynamic? errorModel,
      List<String>? yearsList,
      int? tabCurrentIndex}) {
    return CowpayState(
        status: status ?? this.status,
        yearsList: yearsList ?? this.yearsList,
        creditCardExpiryMonth:
            creditCardExpiryMonth ?? this.creditCardExpiryMonth,
        creditCardExpiryYear: creditCardExpiryYear ?? this.creditCardExpiryYear,
        creditCardCvv: creditCardCvv ?? this.creditCardCvv,
        creditCardNumber: creditCardNumber ?? this.creditCardNumber,
        creditCardHolderName: creditCardHolderName ?? this.creditCardHolderName,
        notValid: notValid ?? this.notValid,
        checkValidation: checkValidation ?? this.checkValidation,
        isNotValidExpirationDate:
            isNotValidExpirationDate ?? this.isNotValidExpirationDate,
        merchantReferenceId: merchantReferenceId ?? this.merchantReferenceId,
        customerMerchantProfileId:
            customerMerchantProfileId ?? this.customerMerchantProfileId,
        customerEmail: customerEmail ?? this.customerEmail,
        customerMobile: customerMobile ?? this.customerMobile,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        creditCardResponseModel:
            creditCardResponseModel ?? this.creditCardResponseModel,
        fawryResponseModel: fawryResponseModel ?? this.fawryResponseModel,
        errorModel: errorModel ?? this.errorModel,
        customerName: customerName ?? this.customerName,
        tabCurrentIndex: tabCurrentIndex ?? this.tabCurrentIndex);
  }

  @override
  List get props => [
        status,
        creditCardExpiryMonth,
        creditCardExpiryYear,
        creditCardHolderName,
        creditCardNumber,
        creditCardCvv,
        checkValidation,
        isNotValidExpirationDate,
        yearsList,
        tabCurrentIndex,
        fawryResponseModel,
      ];
/*const CowpayState({this.tabCurrentIndex = 0});

  final int tabCurrentIndex;

  CowpayState copyWith({int? tabCurrentIndex}) {
    return CowpayState(
        tabCurrentIndex: tabCurrentIndex ?? this.tabCurrentIndex);
  }

  @override
  List get props => [tabCurrentIndex];*/
}
