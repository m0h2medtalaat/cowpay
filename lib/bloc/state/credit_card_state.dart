import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CreditCardState extends Equatable {
  const CreditCardState({
    this.status = FormzStatus.pure,
    this.creditCardNumber = const CreditCardNumber.pure(),
    this.creditCardExpiryMonth = const CreditCardExpiryMonth.pure(),
    this.creditCardExpiryYear = const CreditCardExpiryYear.pure(),
    this.creditCardCvv = const CreditCardCvv.pure(),
    this.creditCardHolderName = const CreditCardHolderName.pure(),
    this.notValid = 0,
    this.checkValidation = false,
  });

  final FormzStatus status;
  final CreditCardExpiryMonth creditCardExpiryMonth;
  final CreditCardExpiryYear creditCardExpiryYear;
  final CreditCardCvv creditCardCvv;
  final CreditCardNumber creditCardNumber;
  final CreditCardHolderName creditCardHolderName;

  final int notValid;
  final bool checkValidation;

  CreditCardState copyWith(
      {FormzStatus? status,
      CreditCardExpiryMonth? creditCardExpiryMonth,
      CreditCardExpiryYear? creditCardExpiryYear,
      CreditCardCvv? creditCardCvv,
      CreditCardNumber? creditCardNumber,
      CreditCardHolderName? creditCardHolderName,
      bool? checkValidation,
      int? notValid}) {
    return CreditCardState(
        status: status ?? this.status,
        creditCardExpiryMonth:
            creditCardExpiryMonth ?? this.creditCardExpiryMonth,
        creditCardExpiryYear: creditCardExpiryYear ?? this.creditCardExpiryYear,
        creditCardCvv: creditCardCvv ?? this.creditCardCvv,
        creditCardNumber: creditCardNumber ?? this.creditCardNumber,
        creditCardHolderName: creditCardHolderName ?? this.creditCardHolderName,
        notValid: notValid ?? this.notValid,
        checkValidation: checkValidation ?? this.checkValidation);
  }

  @override
  List<Object> get props => [
        status,
        creditCardExpiryMonth,
        creditCardExpiryYear,
        creditCardHolderName,
        creditCardNumber,
        creditCardCvv,
        checkValidation
      ];
}
