library cowpay;

import 'package:cowpay/bloc/bloc/cash_collection_bloc.dart';
import 'package:cowpay/bloc/event/cash_collection_event.dart';
import 'package:cowpay/bloc/state/cash_collection_state.dart';
import 'package:cowpay/formz_models/num_text_input.dart';
import 'package:cowpay/formz_models/text_input.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/models/cash_collection_response_model.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CashCollectionWidget extends StatelessWidget {
  final _cashDistrictFocusNode = FocusNode();
  final _cashAddressFocusNode = FocusNode();
  final _cashFloorFocusNode = FocusNode();
  final _cashApartmentFocusNode = FocusNode();
  final _cashCityCodeFocusNode = FocusNode();
  final String customerName,
      description,
      merchantReferenceId,
      customerMerchantProfileId,
      customerEmail,
      customerMobile;

  final CowpayEnvironment activeEnvironment;
  final double amount;
  final double? height;
  final Color? backGroundColor, cardColor, buttonColor, buttonTextColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;

  final Function(CashCollectionResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  CashCollectionWidget(
      {required this.amount,
      required this.activeEnvironment,
      required this.customerEmail,
      required this.customerMobile,
      required this.customerName,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.height,
      this.buttonTextColor,
      this.cardColor,
      this.backGroundColor,
      this.buttonColor,
      this.buttonTextStyle,
      this.textFieldStyle,
      this.textFieldInputDecoration,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    return BlocProvider<CashCollectionBloc>(
      create: (context) {
        return CashCollectionBloc()
          ..add(CashCollectionChargeStarted(
              merchantReferenceId: merchantReferenceId,
              customerMerchantProfileId: customerMerchantProfileId,
              amount: amount.toString(),
              customerEmail: customerEmail,
              customerMobile: customerMobile,
              customerName: customerName,
              description: description));
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: height ?? (ScreenSize().height),
          color: backGroundColor ?? Colors.grey.withOpacity(0.8),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                child: Container(
                  decoration: BoxDecoration(
                      color: cardColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.05)),
                  child: Padding(
                    padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                    child: Column(
                      children: [
                        _DistrictInput(
                          style: textFieldStyle,
                          inputDecoration: textFieldInputDecoration,
                          currentFocusNode: _cashDistrictFocusNode,
                          nextFocusNode: _cashAddressFocusNode,
                        ),
                        _AddressInput(
                          style: textFieldStyle,
                          inputDecoration: textFieldInputDecoration,
                          currentFocusNode: _cashAddressFocusNode,
                          nextFocusNode: _cashFloorFocusNode,
                        ),
                        SizedBox(
                          height: ScreenSize().height! * 0.01,
                        ),
                        _FloorInput(
                          style: textFieldStyle,
                          inputDecoration: textFieldInputDecoration,
                          nextFocusNode: _cashApartmentFocusNode,
                          currentFocusNode: _cashFloorFocusNode,
                        ),
                        SizedBox(
                          height: ScreenSize().height! * 0.01,
                        ),
                        _ApartmentInput(
                          style: textFieldStyle,
                          inputDecoration: textFieldInputDecoration,
                          currentFocusNode: _cashApartmentFocusNode,
                          nextFocusNode: _cashCityCodeFocusNode,
                        ),
                        _CityCodeInput(
                          style: textFieldStyle,
                          inputDecoration: textFieldInputDecoration,
                          currentFocusNode: _cashCityCodeFocusNode,
                        ),
                        SizedBox(
                          height: ScreenSize().height! * 0.01,
                        ),
                        _ChargeButton(
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          buttonTextStyle: buttonTextStyle,
                          onSuccess: (val) => onSuccess(val),
                          onError: (error) => onError(error),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChargeButton extends StatelessWidget {
  final Color? buttonColor, buttonTextColor;
  final TextStyle? buttonTextStyle;
  final Function(CashCollectionResponseModel cashCollectionModel) onSuccess;
  final Function(dynamic error) onError;

  _ChargeButton(
      {this.buttonTextStyle,
      this.buttonColor,
      this.buttonTextColor,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          if (state.status.isSubmissionSuccess)
            onSuccess(state.cashCollectionResponseModel!);
          else if (state.status.isSubmissionFailure) onError(state.errorModel);
        });
        return state.status.isSubmissionInProgress
            ? ButtonLoadingView()
            : ButtonView(
                title: 'Charge',
                textColor: buttonTextColor ?? Colors.white,
                fontSize: 0.02,
                backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
                mainContext: context,
                buttonTextStyle: buttonTextStyle,
                onClickFunction: onClickLogin,
              );
      },
    );
  }

  void onClickLogin(
    BuildContext context,
  ) {
    context.read<CashCollectionBloc>().add(ChargeValidation(context));
  }
}

class _DistrictInput extends StatelessWidget {
  final TextStyle? style;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final InputDecoration? inputDecoration;

  _DistrictInput(
      {this.style,
      this.inputDecoration,
      required this.currentFocusNode,
      required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionDistrict != current.cashCollectionDistrict ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionDistrict.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'District',
          onChange: onCashCollectionDistrictChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionDistrict.error?.message,
        );
      },
    );
  }

  void onCashCollectionDistrictChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionDistrictChange(value));
  }
}

class _AddressInput extends StatelessWidget {
  final TextStyle? style;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final InputDecoration? inputDecoration;

  _AddressInput(
      {this.style,
      this.inputDecoration,
      required this.currentFocusNode,
      required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionAddress != current.cashCollectionAddress ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionAddress.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Address',
          onChange: onCashCollectionAddressChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionAddress.error?.message,
        );
      },
    );
  }

  void onCashCollectionAddressChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionAddressChange(value));
  }
}

class _FloorInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode nextFocusNode;
  final FocusNode currentFocusNode;

  _FloorInput(
      {this.style,
      this.inputDecoration,
      required this.nextFocusNode,
      required this.currentFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionFloor != current.cashCollectionFloor ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionFloor.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Floor',
          onChange: onCashCollectionFloorChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionFloor.error?.message,
        );
      },
    );
  }

  void onCashCollectionFloorChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionFloorChange(value));
  }
}

class _ApartmentInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode nextFocusNode;
  final FocusNode currentFocusNode;

  _ApartmentInput(
      {this.style,
      this.inputDecoration,
      required this.nextFocusNode,
      required this.currentFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionApartment != current.cashCollectionApartment ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionApartment.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Apartment',
          onChange: onCashCollectionApartmentChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionApartment.error?.message,
        );
      },
    );
  }

  void onCashCollectionApartmentChange(BuildContext context, String value) {
    context
        .read<CashCollectionBloc>()
        .add(CashCollectionApartmentChange(value));
  }
}

class _CityCodeInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentFocusNode;

  _CityCodeInput({
    this.style,
    this.inputDecoration,
    required this.currentFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionCityCode != current.cashCollectionCityCode ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionCityCode.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'City code',
          onChange: onCashCollectionCityCodeChange,
          currentFocus: currentFocusNode,
          onFieldSubmitted: (_) {
            onClickSubmit(context);
          },
          errorMessage: state.cashCollectionCityCode.error?.message,
        );
      },
    );
  }

  void onCashCollectionCityCodeChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionCityCodeChange(value));
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    context.read<CashCollectionBloc>().add(ChargeValidation(context));
  }
}
