import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  CreditCardBloc() : super(CreditCardState());

  @override
  Stream<CreditCardState> mapEventToState(
    CreditCardEvent event,
  ) async* {
    if (event is CreditCardChargeStarted) {
      yield _mapCardStartToState(event, state);
    }
    if (event is CreditCardNameChange) {
      yield _mapCardHolderNameChangedToState(event, state);
    } else if (event is CreditCardNumberChange) {
      yield _mapCardNumberChangedToState(event, state);
    } else if (event is CreditCardCvvChange) {
      yield _mapCardCvvChangedToState(event, state);
    } else if (event is CreditCardExpiryYearChange) {
      yield _mapCardExpiryYearChangedToState(event, state);
    } else if (event is CreditCardExpiryMonthChange) {
      yield _mapCardExpiryMonthChangedToState(event, state);
    } else if (event is ChargeValidation) {
      yield* _validateChangedToState(state, event);
    }
  }

  CreditCardState _mapCardHolderNameChangedToState(
    CreditCardNameChange event,
    CreditCardState state,
  ) {
    final name = CreditCardHolderName.dirty(event.creditCardHolderName);
    return state.copyWith(
      creditCardHolderName: name,
    );
  }

  CreditCardState _mapCardStartToState(
    CreditCardChargeStarted event,
    CreditCardState state,
  ) {
    int currentYear = DateTime.now().year;
    List<String> yearsList = [];
    for (int i = 0; i < 10; i++) {
      yearsList.add(currentYear.toString());
      currentYear += 1;
    }

    return state.copyWith(
        merchantReferenceId: event.merchantReferenceId,
        customerMerchantProfileId: event.customerMerchantProfileId,
        customerEmail: event.customerEmail,
        customerMobile: event.customerMobile,
        amount: event.amount,
        description: event.description,
        yearsList: yearsList);
  }

  CreditCardState _mapCardNumberChangedToState(
    CreditCardNumberChange event,
    CreditCardState state,
  ) {
    final creditCardNumber = CreditCardNumber.dirty(event.creditCardNumber);
    return state.copyWith(
      creditCardNumber: creditCardNumber,
    );
  }

  CreditCardState _mapCardCvvChangedToState(
    CreditCardCvvChange event,
    CreditCardState state,
  ) {
    final creditCardCvv = CreditCardCvv.dirty(event.creditCardCvv);
    return state.copyWith(
      creditCardCvv: creditCardCvv,
    );
  }

  CreditCardState _mapCardExpiryMonthChangedToState(
    CreditCardExpiryMonthChange event,
    CreditCardState state,
  ) {
    final creditCardExpiryMonth =
        CreditCardExpiryMonth.dirty(event.creditCardExpiryMonth);

    bool isNotValidExpirationDate = true;
    if (state.creditCardExpiryYear.value != "" &&
        state.creditCardExpiryMonth.value != "") {
      var expirationDate = DateTime(int.parse(state.creditCardExpiryYear.value),
          int.parse(creditCardExpiryMonth.value) + 1);
      //add 1 month
      if (expirationDate.isAfter(DateTime.now())) {
        isNotValidExpirationDate = false;
      }
    }

    return state.copyWith(
      creditCardExpiryMonth: creditCardExpiryMonth,
      isNotValidExpirationDate: isNotValidExpirationDate,
    );
  }

  CreditCardState _mapCardExpiryYearChangedToState(
    CreditCardExpiryYearChange event,
    CreditCardState state,
  ) {
    final creditCardExpiryYear =
        CreditCardExpiryYear.dirty(event.creditCardExpiryYear);

    bool isNotValidExpirationDate = true;
    if (state.creditCardExpiryYear.value != "" &&
        state.creditCardExpiryMonth.value != "") {
      var expirationDate = DateTime(int.parse(creditCardExpiryYear.value),
          int.parse(state.creditCardExpiryMonth.value) + 1);
      //add 1 month
      if (expirationDate.isAfter(DateTime.now())) {
        isNotValidExpirationDate = false;
      }
    }

    return state.copyWith(
      isNotValidExpirationDate: isNotValidExpirationDate,
      creditCardExpiryYear: creditCardExpiryYear,
    );
  }
}

Stream<CreditCardState> _validateChangedToState(
  CreditCardState state,
  ChargeValidation event,
) async* {
  final creditCardHolderName =
      CreditCardHolderName.dirty(state.creditCardHolderName.value);
  final creditCardNumber = CreditCardNumber.dirty(state.creditCardNumber.value);
  final creditCardCvv = CreditCardCvv.dirty(state.creditCardCvv.value);
  final creditCardExpiryMonth =
      CreditCardExpiryMonth.dirty(state.creditCardExpiryMonth.value);
  final creditCardExpiryYear =
      CreditCardExpiryYear.dirty(state.creditCardExpiryYear.value);

  List<FormzStatus> validationListState = [];
  validationListState.add(Formz.validate([creditCardHolderName]));
  validationListState.add(Formz.validate([creditCardNumber]));
  validationListState.add(Formz.validate([creditCardCvv]));
  validationListState.add(Formz.validate([creditCardExpiryMonth]));
  validationListState.add(Formz.validate([creditCardExpiryYear]));
  if (validationListState.where((element) => element.isInvalid).isEmpty &&
      !state.isNotValidExpirationDate)
    yield* _mapRegisterSubmittedToState(
        state,
        event.context,
        creditCardHolderName,
        creditCardNumber,
        creditCardCvv,
        creditCardExpiryMonth,
        creditCardExpiryYear,
        validationListState
            .where((element) => element == FormzStatus.invalid)
            .length);
  else
    yield state.copyWith(
        isNotValidExpirationDate: false,
        creditCardHolderName: creditCardHolderName,
        creditCardNumber: creditCardNumber,
        creditCardCvv: creditCardCvv,
        creditCardExpiryMonth: creditCardExpiryMonth,
        creditCardExpiryYear: creditCardExpiryYear,
        checkValidation: true,
        status: Formz.validate([
          creditCardHolderName,
          creditCardNumber,
          creditCardCvv,
          creditCardExpiryMonth,
          creditCardExpiryYear
        ]),
        notValid: validationListState
            .where((element) => element == FormzStatus.invalid)
            .length);
}

Stream<CreditCardState> _mapRegisterSubmittedToState(
    CreditCardState state,
    BuildContext context,
    CreditCardHolderName creditCardHolderName,
    CreditCardNumber creditCardNumber,
    CreditCardCvv creditCardCvv,
    CreditCardExpiryMonth creditCardExpiryMonth,
    CreditCardExpiryYear creditCardExpiryYear,
    int length) async* {
  yield state.copyWith(status: FormzStatus.submissionInProgress);
  try {
    var model = await CowpayHelper.instance.creditCardCharge(
        merchantReferenceId: state.merchantReferenceId!,
        customerMerchantProfileId: state.customerMerchantProfileId!,
        customerEmail: state.customerEmail!,
        customerMobile: state.customerMobile!,
        customerName: state.creditCardHolderName.value,
        cvv: creditCardCvv.value,
        cardNumber: creditCardNumber.value,
        expiryYear: creditCardExpiryYear.value,
        expiryMonth: creditCardExpiryMonth.value,
        amount: state.amount!,
        description: state.description!);

    yield state.copyWith(
        isNotValidExpirationDate: false,
        status: FormzStatus.submissionSuccess,
        creditCardResponseModel: model);
  } catch (error) {
    state.copyWith(
        creditCardHolderName: creditCardHolderName,
        creditCardNumber: creditCardNumber,
        creditCardCvv: creditCardCvv,
        creditCardExpiryMonth: creditCardExpiryMonth,
        creditCardExpiryYear: creditCardExpiryYear,
        checkValidation: true,
        status: Formz.validate([
          creditCardHolderName,
          creditCardNumber,
          creditCardCvv,
          creditCardExpiryMonth,
          creditCardExpiryYear
        ]),
        notValid: length);

    yield state.copyWith(
        status: FormzStatus.submissionFailure, errorModel: error);
  }
}
