import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowpay/bloc/event/cash_collection_event.dart';
import 'package:cowpay/bloc/state/cash_collection_state.dart';
import 'package:cowpay/cowpay.dart';
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
    } else if (event is CashCollectionCityKeyChange) {
      yield _mapCashCollectionCityKeyChangeToState(event, state);
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
    return state.copyWith(
      cashCollectionDistrict: cashCollectionDistrict,
    );
  }

  CashCollectionState _mapCashCollectionAddressChangeToState(
    CashCollectionAddressChange event,
    CashCollectionState state,
  ) {
    final cashCollectionAddress = TextInput.dirty(event.cashCollectionAddress);
    return state.copyWith(
      cashCollectionAddress: cashCollectionAddress,
    );
  }

  CashCollectionState _mapCashCollectionFloorChangeToState(
    CashCollectionFloorChange event,
    CashCollectionState state,
  ) {
    final cashCollectionFloor = NumTextInput.dirty(event.cashCollectionFloor);
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
    return state.copyWith(
      cashCollectionApartment: cashCollectionApartment,
    );
  }

  CashCollectionState _mapCashCollectionCityKeyChangeToState(
    CashCollectionCityKeyChange event,
    CashCollectionState state,
  ) {
    final cashCollectionCityCode =
        TextInput.dirty(testList[event.cashCollectionCityKey]!);

    return state.copyWith(
      cityKey: event.cashCollectionCityKey,
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

    FormzStatus formzStatus = Formz.validate([
      cashCollectionDistrict,
      cashCollectionAddress,
      cashCollectionFloor,
      cashCollectionApartment,
      cashCollectionCityCode,
    ]);

    if (formzStatus.isValid)
      yield* _mapRegisterSubmittedToState(
          state,
          event.context,);
    else
      yield state.copyWith(
          cashCollectionDistrict: cashCollectionDistrict,
          cashCollectionAddress: cashCollectionAddress,
          cashCollectionFloor: cashCollectionFloor,
          cashCollectionApartment: cashCollectionApartment,
          cashCollectionCityCode: cashCollectionCityCode,
          checkValidation: true,
          status: FormzStatus.invalid,);
  }

  Stream<CashCollectionState> _mapRegisterSubmittedToState(
      CashCollectionState state,
      BuildContext context,) async* {
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

      yield state.copyWith(
          status: FormzStatus.submissionFailure, errorModel: error);
    }
  }
}
