import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowpay/api_calls/api_calls.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/cowpay.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
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
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([name]));
      validationListState.add(Formz.validate([state.creditCardNumber]));
      validationListState.add(Formz.validate([state.creditCardCvv]));
      validationListState.add(Formz.validate([state.creditCardExpiryMonth]));
      validationListState.add(Formz.validate([state.creditCardExpiryYear]));
      return state.copyWith(
          creditCardHolderName: name,
          status: Formz.validate([
            name,
            state.creditCardNumber,
            state.creditCardExpiryMonth,
            state.creditCardExpiryYear,
            state.creditCardCvv,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      creditCardHolderName: name,
    );
  }

  CreditCardState _mapCardStartToState(
    CreditCardChargeStarted event,
    CreditCardState state,
  ) {
    return state.copyWith(
      merchantReferenceId: event.merchantReferenceId,
      customerMerchantProfileId: event.customerMerchantProfileId,
      customerName: event.customerName,
      customerEmail: event.customerEmail,
      customerMobile: event.customerMobile,
      amount: event.amount,
      description: event.description,
    );
  }

  CreditCardState _mapCardNumberChangedToState(
    CreditCardNumberChange event,
    CreditCardState state,
  ) {
    final creditCardNumber = CreditCardNumber.dirty(event.creditCardNumber);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.creditCardHolderName]));
      validationListState.add(Formz.validate([creditCardNumber]));
      validationListState.add(Formz.validate([state.creditCardCvv]));
      validationListState.add(Formz.validate([state.creditCardExpiryMonth]));
      validationListState.add(Formz.validate([state.creditCardExpiryYear]));

      return state.copyWith(
          creditCardNumber: creditCardNumber,
          status: Formz.validate([
            state.creditCardHolderName,
            creditCardNumber,
            state.creditCardExpiryMonth,
            state.creditCardExpiryYear,
            state.creditCardCvv,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      creditCardNumber: creditCardNumber,
    );
  }

  CreditCardState _mapCardCvvChangedToState(
    CreditCardCvvChange event,
    CreditCardState state,
  ) {
    final creditCardCvv = CreditCardCvv.dirty(event.creditCardCvv);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.creditCardHolderName]));
      validationListState.add(Formz.validate([state.creditCardNumber]));
      validationListState.add(Formz.validate([creditCardCvv]));
      validationListState.add(Formz.validate([state.creditCardExpiryMonth]));
      validationListState.add(Formz.validate([state.creditCardExpiryYear]));

      return state.copyWith(
          creditCardCvv: creditCardCvv,
          status: Formz.validate([
            state.creditCardHolderName,
            state.creditCardNumber,
            creditCardCvv,
            state.creditCardExpiryMonth,
            state.creditCardExpiryYear,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
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
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.creditCardHolderName]));
      validationListState.add(Formz.validate([state.creditCardNumber]));
      validationListState.add(Formz.validate([state.creditCardCvv]));
      validationListState.add(Formz.validate([creditCardExpiryMonth]));
      validationListState.add(Formz.validate([state.creditCardExpiryYear]));
      return state.copyWith(
          creditCardExpiryMonth: creditCardExpiryMonth,
          status: Formz.validate([
            state.creditCardHolderName,
            state.creditCardNumber,
            state.creditCardCvv,
            creditCardExpiryMonth,
            state.creditCardExpiryYear,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      creditCardExpiryMonth: creditCardExpiryMonth,
    );
  }

  CreditCardState _mapCardExpiryYearChangedToState(
    CreditCardExpiryYearChange event,
    CreditCardState state,
  ) {
    final creditCardExpiryYear =
        CreditCardExpiryYear.dirty(event.creditCardExpiryYear);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.creditCardHolderName]));
      validationListState.add(Formz.validate([state.creditCardNumber]));
      validationListState.add(Formz.validate([state.creditCardCvv]));
      validationListState.add(Formz.validate([state.creditCardExpiryMonth]));
      validationListState.add(Formz.validate([creditCardExpiryYear]));
      return state.copyWith(
          creditCardExpiryYear: creditCardExpiryYear,
          status: Formz.validate([
            state.creditCardHolderName,
            state.creditCardNumber,
            state.creditCardCvv,
            state.creditCardExpiryMonth,
            creditCardExpiryYear,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      creditCardExpiryYear: creditCardExpiryYear,
    );
  }

  Stream<CreditCardState> _validateChangedToState(
    CreditCardState state,
    ChargeValidation event,
  ) async* {
    final creditCardHolderName =
        CreditCardHolderName.dirty(state.creditCardHolderName.value);
    final creditCardNumber =
        CreditCardNumber.dirty(state.creditCardNumber.value);
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

    if (validationListState.where((element) => element.isInvalid).isEmpty)
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
      var model = await Cowpay.instance.creditCardCharge(
          merchantReferenceId: state.merchantReferenceId!,
          customerMerchantProfileId: state.customerMerchantProfileId!,
          customerName: state.customerName ?? null,
          customerEmail: state.customerEmail ?? null,
          customerMobile: state.customerMobile ?? null,
          cvv: creditCardCvv.value,
          cardNumber: creditCardNumber.value,
          expiryYear: creditCardExpiryYear.value,
          expiryMonth: creditCardExpiryMonth.value,
          amount: state.amount!,
          description: state.description!);

      yield state.copyWith(status: FormzStatus.submissionSuccess,creditCardResponseModel: model);
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

      yield state.copyWith(status: FormzStatus.submissionFailure,errorModel: error);
    }
  }
}
