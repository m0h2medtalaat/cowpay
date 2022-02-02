library cowpay;

import 'package:cowpay/bloc/bloc/cowpay_bloc.dart';
import 'package:cowpay/bloc/bloc/credit_card_bloc.dart';
import 'package:cowpay/bloc/event/cash_collection_event.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/localization.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/models/credit_card_response_model.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/drop_down_view.dart';
import 'package:cowpay/ui/generic_views/text_input_error_view.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class FawryWidget extends StatelessWidget {
  final String description, merchantReferenceId, customerMerchantProfileId;

  final String customerEmail;

  final String customerMobile;
  final CowpayEnvironment activeEnvironment;
  final double amount;
  final double? height;
  final Color? /*backGroundColor,*/ /*cardColor,*/ buttonColor,
      buttonTextColor,
      mainColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;
  final LocalizationCode? localizationCode;
  final Function(CreditCardResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  FawryWidget(
      {required this.amount,
      required this.activeEnvironment,
      required this.customerEmail,
      required this.customerMobile,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.localizationCode,
      this.height,
      this.buttonTextColor,
//      this.cardColor,
//      this.backGroundColor,
      this.buttonColor,
      this.buttonTextStyle,
      this.textFieldStyle,
      this.textFieldInputDecoration,
      this.mainColor,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    if (localizationCode == LocalizationCode.ar) {
      Localization().localizationMap = localizationMapAr;
      Localization().localizationCode = LocalizationCode.ar;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Localization().localizationMap["fawryPayPlaceholderMessage"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardHolderName() {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardHolderName != current.creditCardHolderName ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardHolderName.invalid && state.status.isInvalid;
        return TextInputView(
          style: textFieldStyle,
          inputDecoration: textFieldInputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: Localization().localizationMap["cardHolderName"],
          onChange: onChangeCreditCardHolderName,
          // currentFocus: currentNode,
          // nextFocus: nextNode,
          errorMessage: state.creditCardHolderName.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardHolderName(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNameChange(value));
  }

  Widget _buildCardNumberTextField() {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardNumber != current.creditCardNumber ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardNumber.invalid && state.status.isInvalid;
        return TextInputView(
          style: textFieldStyle,
          inputDecoration: textFieldInputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          maxLength: 16,
          hintText: Localization().localizationMap["cardNumber"],
          onChange: onChangeCreditCardNumber,
          errorMessage: state.creditCardNumber.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardNumber(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNumberChange(value));
  }

  Widget _buildCvvTextField() {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardCvv != current.creditCardCvv ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid = state.creditCardCvv.invalid && state.status.isInvalid;
        return TextInputView(
          suffixIcon: "cvv",
          inputDecoration: textFieldInputDecoration,
          style: textFieldStyle,
          mainContext: context,
          isNotValid: isNotValid,
          onFieldSubmitted: (_) {
            onClickSubmit(context);
          },
          width: (ScreenSize().width! * 0.4),
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          maxLength: 3,
          hintText: Localization().localizationMap["cvv"],
          onChange: onChangeCreditCardCvv,
          errorMessage: state.creditCardCvv.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardCvv(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardCvvChange(value));
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    // context.read<CreditCardBloc>().add(ChargeValidation(context));
  }

  _buildDropDownExpiryMonth() {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
        buildWhen: (previous, current) =>
            previous.creditCardExpiryMonth != current.creditCardExpiryMonth ||
            previous.status != current.status,
        builder: (context, state) {
          bool isInValid =
              state.creditCardExpiryMonth.value == '' && state.checkValidation;
          return DropDownView(
            list: [
              "01",
              "02",
              "03",
              "04",
              "05",
              "06",
              "07",
              "08",
              "09",
              "10",
              "11",
              "12"
            ],
            onChange: onChangeCreditCardExpiryMonth,
            isNotValid: isInValid,
            hintText: "MM",
            value: state.creditCardExpiryMonth.value,
          );
        });
  }

  void onChangeCreditCardExpiryMonth(BuildContext context, String? value) {
    if (value != null) {
      context.read<CreditCardBloc>().add(CreditCardExpiryMonthChange(value));
    }
  }

  _buildDropDownExpiryYear() {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
        buildWhen: (previous, current) =>
            previous.creditCardExpiryYear != current.creditCardExpiryYear ||
            previous.yearsList != current.yearsList ||
            previous.status != current.status,
        builder: (context, state) {
          bool isInValid =
              state.creditCardExpiryYear.value == '' && state.checkValidation;
          return DropDownView(
            list: state.yearsList ?? [],
            onChange: onChangeCreditCardExpiryYear,
            isNotValid: isInValid,
            hintText: "YYYY",
            value: state.creditCardExpiryYear.value,
          );
        });
  }

  void onChangeCreditCardExpiryYear(BuildContext context, String? value) {
    if (value != null) {
      context.read<CreditCardBloc>().add(CreditCardExpiryYearChange(value));
    }
  }
}

Widget buildExpiryError() {
  return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardExpiryMonth != current.creditCardExpiryMonth ||
          previous.status != current.status ||
          previous.creditCardExpiryYear != current.creditCardExpiryYear ||
          previous.isNotValidExpirationDate != current.isNotValidExpirationDate,
      builder: (context, state) {
        bool isNotValid = (state.creditCardExpiryMonth.invalid ||
                state.creditCardExpiryYear.invalid ||
                state.isNotValidExpirationDate) &&
            state.checkValidation;
        return isNotValid
            ? TextInputErrorView(
                errorMessage: "Expiration Error",
              )
            : SizedBox();
      });
}

class _ChargeButton extends StatelessWidget {
  final Color? buttonColor, buttonTextColor;
  final TextStyle? buttonTextStyle;
  final Function(CreditCardResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;
  final double amount;

  _ChargeButton(
      {this.buttonTextStyle,
      this.buttonColor,
      this.buttonTextColor,
      required this.onSuccess,
      required this.onError,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          if (state.status.isSubmissionSuccess)
            onSuccess(state.creditCardResponseModel!);
          else if (state.status.isSubmissionFailure) onError(state.errorModel);
        });
        return state.status.isSubmissionInProgress
            ? ButtonLoadingView()
            : ButtonView(
                fontWeight: FontWeight.w300,
                // title: 'PAY  $amount EGP',
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize().width! * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Localization().localizationMap["pay"],
                          style: buttonTextStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 0.025 * ScreenSize().height!,
                                  color: Colors.white),
                          textScaleFactor: 1),
                      Text("$amount ${Localization().localizationMap["egp"]}",
                          style: buttonTextStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 0.025 * ScreenSize().height!,
                                  color: Colors.white),
                          textScaleFactor: 1)
                    ],
                  ),
                ),
                textColor: buttonTextColor ?? Colors.white,
                fontSize: 0.025,
                backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
                mainContext: context,
                buttonTextStyle: buttonTextStyle,
                onClickFunction: onClickSubmit,
              );
      },
    );
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    // context.read<CowpayBloc>().add(ChargeValidation(context));
  }
}

class _ScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}