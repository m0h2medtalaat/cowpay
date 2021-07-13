import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowpay/bloc/event/cash_collection_event.dart';
import 'package:cowpay/bloc/state/cash_collection_state.dart';
import 'package:cowpay/formz_models/num_text_input.dart';
import 'package:cowpay/formz_models/text_input.dart';
import 'package:cowpay/models/cash_collection_response_model.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class CashCollectionBloc
    extends Bloc<CashCollectionEvent, CashCollectionState> {
  CashCollectionBloc() : super(CashCollectionState());

  @override
  Stream<CashCollectionState> mapEventToState(
    CashCollectionEvent event,
  ) async* {
    if (event is CashCollectionChargeStarted) {
      yield _mapCardStartToState(event, state);
    }
    if (event is CashCollectionDistrictChange) {
      yield _mapCashCollectionDistrictChangeToState(event, state);
    } else if (event is CashCollectionAddressChange) {
      yield _mapCashCollectionAddressChangeToState(event, state);
    } else if (event is CashCollectionFloorChange) {
      yield _mapCashCollectionFloorChangeToState(event, state);
    } else if (event is CashCollectionApartmentChange) {
      yield _mapCashCollectionApartmentChangeToState(event, state);
    } else if (event is CashCollectionCityCodeChange) {
      yield _mapCashCollectionCityCodeChangeToState(event, state);
    } else if (event is ChargeValidation) {
      yield* _validateChangedToState(state, event);
    }
  }

  CashCollectionState _mapCardStartToState(
    CashCollectionChargeStarted event,
    CashCollectionState state,
  ) {
    return state.copyWith(
      merchantReferenceId: event.merchantReferenceId,
      customerMerchantProfileId: event.customerMerchantProfileId,
      customerEmail: event.customerEmail,
      customerMobile: event.customerMobile,
      customerName: event.customerName,
      amount: event.amount,
      description: event.description,
    );
  }

  CashCollectionState _mapCashCollectionDistrictChangeToState(
    CashCollectionDistrictChange event,
    CashCollectionState state,
  ) {
    final cashCollectionDistrict =
        TextInput.dirty(event.cashCollectionDistrict);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([cashCollectionDistrict]));
      validationListState.add(Formz.validate([state.cashCollectionAddress]));
      validationListState.add(Formz.validate([state.cashCollectionFloor]));
      validationListState.add(Formz.validate([state.cashCollectionApartment]));
      validationListState.add(Formz.validate([state.cashCollectionCityCode]));
      return state.copyWith(
          cashCollectionDistrict: cashCollectionDistrict,
          status: Formz.validate([
            cashCollectionDistrict,
            state.cashCollectionAddress,
            state.cashCollectionFloor,
            state.cashCollectionApartment,
            state.cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      cashCollectionDistrict: cashCollectionDistrict,
    );
  }

  CashCollectionState _mapCashCollectionAddressChangeToState(
    CashCollectionAddressChange event,
    CashCollectionState state,
  ) {
    final cashCollectionAddress = TextInput.dirty(event.cashCollectionAddress);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.cashCollectionDistrict]));
      validationListState.add(Formz.validate([cashCollectionAddress]));
      validationListState.add(Formz.validate([state.cashCollectionFloor]));
      validationListState.add(Formz.validate([state.cashCollectionApartment]));
      validationListState.add(Formz.validate([state.cashCollectionCityCode]));
      return state.copyWith(
          cashCollectionAddress: cashCollectionAddress,
          status: Formz.validate([
            state.cashCollectionDistrict,
            cashCollectionAddress,
            state.cashCollectionFloor,
            state.cashCollectionApartment,
            state.cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      cashCollectionAddress: cashCollectionAddress,
    );
  }

  CashCollectionState _mapCashCollectionFloorChangeToState(
    CashCollectionFloorChange event,
    CashCollectionState state,
  ) {
    final cashCollectionFloor = NumTextInput.dirty(event.cashCollectionFloor);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.cashCollectionDistrict]));
      validationListState.add(Formz.validate([state.cashCollectionAddress]));
      validationListState.add(Formz.validate([cashCollectionFloor]));
      validationListState.add(Formz.validate([state.cashCollectionApartment]));
      validationListState.add(Formz.validate([state.cashCollectionCityCode]));
      return state.copyWith(
          cashCollectionFloor: cashCollectionFloor,
          status: Formz.validate([
            state.cashCollectionDistrict,
            state.cashCollectionAddress,
            cashCollectionFloor,
            state.cashCollectionApartment,
            state.cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      cashCollectionFloor: cashCollectionFloor,
    );
  }

  CashCollectionState _mapCashCollectionApartmentChangeToState(
    CashCollectionApartmentChange event,
    CashCollectionState state,
  ) {
    final cashCollectionApartment =
        NumTextInput.dirty(event.cashCollectionApartment);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.cashCollectionDistrict]));
      validationListState.add(Formz.validate([state.cashCollectionAddress]));
      validationListState.add(Formz.validate([state.cashCollectionFloor]));
      validationListState.add(Formz.validate([cashCollectionApartment]));
      validationListState.add(Formz.validate([state.cashCollectionCityCode]));
      return state.copyWith(
          cashCollectionApartment: cashCollectionApartment,
          status: Formz.validate([
            state.cashCollectionDistrict,
            state.cashCollectionAddress,
            state.cashCollectionFloor,
            cashCollectionApartment,
            state.cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      cashCollectionApartment: cashCollectionApartment,
    );
  }

  CashCollectionState _mapCashCollectionCityCodeChangeToState(
    CashCollectionCityCodeChange event,
    CashCollectionState state,
  ) {
    final cashCollectionCityCode =
        TextInput.dirty(event.cashCollectionCityCode);
    if (state.status.isSubmissionFailure || state.checkValidation) {
      List<FormzStatus> validationListState = [];
      validationListState.add(Formz.validate([state.cashCollectionDistrict]));
      validationListState.add(Formz.validate([state.cashCollectionAddress]));
      validationListState.add(Formz.validate([state.cashCollectionFloor]));
      validationListState.add(Formz.validate([state.cashCollectionApartment]));
      validationListState.add(Formz.validate([cashCollectionCityCode]));
      return state.copyWith(
          cashCollectionCityCode: cashCollectionCityCode,
          status: Formz.validate([
            state.cashCollectionDistrict,
            state.cashCollectionAddress,
            state.cashCollectionFloor,
            state.cashCollectionApartment,
            cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    }
    return state.copyWith(
      cashCollectionCityCode: cashCollectionCityCode,
    );
  }

  Stream<CashCollectionState> _validateChangedToState(
    CashCollectionState state,
    ChargeValidation event,
  ) async* {
    final cashCollectionDistrict =
        TextInput.dirty(state.cashCollectionDistrict.value);
    final cashCollectionAddress =
        TextInput.dirty(state.cashCollectionAddress.value);
    final cashCollectionFloor =
        NumTextInput.dirty(state.cashCollectionFloor.value);
    final cashCollectionApartment =
        NumTextInput.dirty(state.cashCollectionApartment.value);
    final cashCollectionCityCode =
        TextInput.dirty(state.cashCollectionCityCode.value);

    List<FormzStatus> validationListState = [];
    validationListState.add(Formz.validate([cashCollectionDistrict]));
    validationListState.add(Formz.validate([cashCollectionAddress]));
    validationListState.add(Formz.validate([cashCollectionFloor]));
    validationListState.add(Formz.validate([cashCollectionApartment]));
    validationListState.add(Formz.validate([cashCollectionCityCode]));

    if (validationListState.where((element) => element.isInvalid).isEmpty)
      yield* _mapRegisterSubmittedToState(
          state,
          event.context,
          cashCollectionDistrict,
          cashCollectionAddress,
          cashCollectionFloor,
          cashCollectionApartment,
          cashCollectionCityCode,
          validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
    else
      yield state.copyWith(
          cashCollectionDistrict: cashCollectionDistrict,
          cashCollectionAddress: cashCollectionAddress,
          cashCollectionFloor: cashCollectionFloor,
          cashCollectionApartment: cashCollectionApartment,
          cashCollectionCityCode: cashCollectionCityCode,
          checkValidation: true,
          status: Formz.validate([
            cashCollectionDistrict,
            cashCollectionAddress,
            cashCollectionFloor,
            cashCollectionApartment,
            cashCollectionCityCode,
          ]),
          notValid: validationListState
              .where((element) => element == FormzStatus.invalid)
              .length);
  }

  Stream<CashCollectionState> _mapRegisterSubmittedToState(
      CashCollectionState state,
      BuildContext context,
      TextInput cashCollectionDistrict,
      TextInput cashCollectionAddress,
      NumTextInput cashCollectionFloor,
      NumTextInput cashCollectionApartment,
      TextInput cashCollectionCityCode,
      int length) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      // var model = await Cowpay.instance.cashCollectionCharge(
      //     merchantReferenceId: state.merchantReferenceId!,
      //     customerMerchantProfileId: state.customerMerchantProfileId!,
      //     customerEmail: state.customerEmail!,
      //     customerMobile: state.customerMobile!,
      //     customerName: state.customerName!,
      //     floor: state.cashCollectionFloor.value,
      //     district: state.cashCollectionDistrict.value,
      //     cityCode: state.cashCollectionCityCode.value,
      //     apartment: state.cashCollectionApartment.value,
      //     address: state.cashCollectionAddress.value,
      //     amount: state.amount!,
      //     description: state.description!);
      CashCollectionResponseModel model =
          CashCollectionResponseModel(result: "Success");

      yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          cashCollectionResponseModel: model);
    } catch (error) {
      state.copyWith(
          cashCollectionDistrict: cashCollectionDistrict,
          cashCollectionAddress: cashCollectionAddress,
          cashCollectionFloor: cashCollectionFloor,
          cashCollectionApartment: cashCollectionApartment,
          cashCollectionCityCode: cashCollectionCityCode,
          checkValidation: true,
          status: Formz.validate([
            cashCollectionDistrict,
            cashCollectionAddress,
            cashCollectionFloor,
            cashCollectionApartment,
            cashCollectionCityCode
          ]),
          notValid: length);

      yield state.copyWith(
          status: FormzStatus.submissionFailure, errorModel: error);
    }
  }
}
