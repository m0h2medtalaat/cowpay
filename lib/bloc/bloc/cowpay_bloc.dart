import 'package:cowpay/bloc/event/cowpay_event.dart';
import 'package:cowpay/bloc/state/cowpay_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CowpayBloc extends Bloc<CowpayEvent, CowpayState> {
  CowpayBloc() : super(CowpayState());

  @override
  Stream<CowpayState> mapEventToState(CowpayEvent event) async* {
    if (event is ChangeTabCurrentIndexEvent) {
      yield _changeTabCurrentIndexToState(event);
    } else if (event is ChargeCreditCardValidation) {
      yield* _validateChangedToState(state, event);
    } else if (event is ChargeFawry) {
      yield* _mapChargeFawryToState(state, event.context);
    }
  }

  CowpayState _changeTabCurrentIndexToState(ChangeTabCurrentIndexEvent event) {
    return state.copyWith(tabCurrentIndex: event.index);
  }

  Stream<CowpayState> _validateChangedToState(
    CowpayState state,
    ChargeCreditCardValidation event,
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

  Stream<CowpayState> _mapRegisterSubmittedToState(
      CowpayState state,
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

  Stream<CowpayState> _mapChargeFawryToState(
    CowpayState state,
    BuildContext context,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      var model = await CowpayHelper.instance.createFawryReceipt(
          merchantReferenceId: state.merchantReferenceId!,
          customerMerchantProfileId: state.customerMerchantProfileId!,
          customerEmail: state.customerEmail!,
          customerMobile: state.customerMobile!,
          customerName: state.creditCardHolderName.value,
          amount: state.amount!,
          description: state.description!);

      yield state.copyWith(
          status: FormzStatus.submissionSuccess, fawryResponseModel: model);
    } catch (error) {
      yield state.copyWith(
          status: FormzStatus.submissionFailure, errorModel: error);
    }
  }
}
