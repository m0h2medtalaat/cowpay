import 'package:flutter/material.dart';

abstract class CreditCardEvent {
  const CreditCardEvent();
}

class CreditCardChargeStarted extends CreditCardEvent {
  const CreditCardChargeStarted();
}

class CreditCardNumberChange extends CreditCardEvent {
  const CreditCardNumberChange(this.creditCardNumber);
  final String creditCardNumber;
}

class CreditCardNameChange extends CreditCardEvent {
  const CreditCardNameChange(this.creditCardHolderName);
  final String creditCardHolderName;
}

class CreditCardExpiryMonthChange extends CreditCardEvent {
  const CreditCardExpiryMonthChange(this.creditCardExpiryMonth);
  final String creditCardExpiryMonth;
}

class CreditCardExpiryYearChange extends CreditCardEvent {
  const CreditCardExpiryYearChange(this.creditCardExpiryYear);
  final String creditCardExpiryYear;
}

class CreditCardCvvChange extends CreditCardEvent {
  const CreditCardCvvChange(this.creditCardCvv);
  final String creditCardCvv;
}

class ChargeValidation extends CreditCardEvent {
  const ChargeValidation(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [];
}

class ChargeSubmitted extends CreditCardEvent {
  const ChargeSubmitted();
}
