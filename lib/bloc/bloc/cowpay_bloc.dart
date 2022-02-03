import 'package:cowpay/bloc/event/cowpay_event.dart';
import 'package:cowpay/bloc/state/cowpay_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/models/credit_card_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CowpayBloc extends Bloc<CowpayEvent, CowpayState> {
  CowpayBloc() : super(CowpayState());

  @override
  Stream<CowpayState> mapEventToState(CowpayEvent event) async* {
    if (event is ChangeTabCurrentIndexEvent) {
      yield _changeTabCurrentIndexToState(event);
    } else if (event is CowpayStarted) {
      yield _mapCardStartToState(event, state);
    } else if (event is ChargeCreditCardValidation) {
      yield* _validateChangedToState(state, event);
    } else if (event is ChargeFawry) {
      yield* _mapChargeFawryToState(state, event.context);
    } else if (event is CreditCardNameChange) {
      yield _mapCardHolderNameChangedToState(event, state);
    } else if (event is CreditCardNumberChange) {
      yield _mapCardNumberChangedToState(event, state);
    } else if (event is CreditCardCvvChange) {
      yield _mapCardCvvChangedToState(event, state);
    } else if (event is CreditCardExpiryYearChange) {
      yield _mapCardExpiryYearChangedToState(event, state);
    } else if (event is CreditCardExpiryMonthChange) {
      yield _mapCardExpiryMonthChangedToState(event, state);
    } else if (event is ClearStatus) {
      yield _mapClearStatusToState();
    }
  }

  CowpayState _changeTabCurrentIndexToState(ChangeTabCurrentIndexEvent event) {
    return state.copyWith(tabCurrentIndex: event.index);
  }

  CowpayState _mapClearStatusToState() {
    return state.copyWith(status: FormzStatus.pure);
  }

//region Fawry
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
          //TODO Change customer Name
          customerName: 'Bahi Elfeky',
          amount: state.amount!,
          description: state.description!);

      yield state.copyWith(
          status: FormzStatus.submissionSuccess, fawryResponseModel: model);
    } catch (error) {
      yield state.copyWith(
          status: FormzStatus.submissionFailure, errorModel: error);
    }
  }

  //endregion

  //region Credit Card

  CowpayState _mapCardStartToState(
    CowpayStarted event,
    CowpayState state,
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
      CreditCardResponseModel model = await CowpayHelper.instance
          .creditCardCharge(
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

  CowpayState _mapCardHolderNameChangedToState(
    CreditCardNameChange event,
    CowpayState state,
  ) {
    final name = CreditCardHolderName.dirty(event.creditCardHolderName);
    return state.copyWith(
      creditCardHolderName: name,
    );
  }

  CowpayState _mapCardNumberChangedToState(
    CreditCardNumberChange event,
    CowpayState state,
  ) {
    final creditCardNumber = CreditCardNumber.dirty(event.creditCardNumber);
    return state.copyWith(
      creditCardNumber: creditCardNumber,
    );
  }

  CowpayState _mapCardCvvChangedToState(
    CreditCardCvvChange event,
    CowpayState state,
  ) {
    final creditCardCvv = CreditCardCvv.dirty(event.creditCardCvv);
    return state.copyWith(
      creditCardCvv: creditCardCvv,
    );
  }

  CowpayState _mapCardExpiryMonthChangedToState(
    CreditCardExpiryMonthChange event,
    CowpayState state,
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

  CowpayState _mapCardExpiryYearChangedToState(
    CreditCardExpiryYearChange event,
    CowpayState state,
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
//endregion
}
