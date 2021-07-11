library cowpay;

import 'package:cowpay/bloc/bloc/credit_card_bloc.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

FocusNode _creditCardHolderNameFocusNode = FocusNode();
FocusNode _creditCardNumberFocusNode = FocusNode();
FocusNode _creditCardExpiryMonthFocusNode = FocusNode();
FocusNode _creditCardExpiryYearFocusNode = FocusNode();
FocusNode _creditCardCvvFocusNode = FocusNode();

class CreditCardWidget extends StatelessWidget {
  final String merchantCode;
  final String merchantHash;
  final CowpayEnvironment activeEnvironment;
  final String token;
  final double amount;
  final String customerEmail;
  final String customerMobile;
  final String description;
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final double? height;

  CreditCardWidget(
      {required this.merchantCode,
      required this.merchantHash,
      required this.amount,
      required this.activeEnvironment,
      required this.token,
      required this.customerEmail,
      required this.customerMobile,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.height});

  @override
  Widget build(BuildContext context) {
    // Cowpay.instance.init(
    //   cowpayEnvironment: CowpayEnvironment.staging,
    //   token: token,
    //   merchantCode: merchantCode,
    //   merchantHash: merchantHash,
    // );
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    return BlocProvider<CreditCardBloc>(
      create: (context) {
        return CreditCardBloc();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: height ?? (ScreenSize().height),
          width: ScreenSize().width,
          color: Colors.grey.withOpacity(0.8),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(ScreenSize().width! * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.05)),
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                  child: Column(
                    children: [
                      _CreditCardHolderNameInput(),
                      SizedBox(
                        height: ScreenSize().height! * 0.01,
                      ),
                      _CreditCardNumberInput(),
                      SizedBox(
                        height: ScreenSize().height! * 0.01,
                      ),
                      _CreditCardExpiryMonthInput(),
                      SizedBox(
                        height: ScreenSize().height! * 0.01,
                      ),
                      _CreditCardExpiryYearInput(),
                      SizedBox(
                        height: ScreenSize().height! * 0.01,
                      ),
                      _CreditCardCvvInput(),
                      SizedBox(
                        height: ScreenSize().height! * 0.01,
                      ),
                      _ChargeButton()
                    ],
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isSubmissionSuccess)
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        return state.status.isSubmissionInProgress
            ? ButtonLoadingView()
            : ButtonView(
                title: 'Charge',
                textColor: Colors.white,
                fontSize: 0.02,
                backgroundColor: Theme.of(context).primaryColor,
                mainContext: context,
                onClickFunction: onClickLogin,
              );
      },
    );
  }

  void onClickLogin(
    BuildContext context,
  ) {
    context.read<CreditCardBloc>().add(ChargeValidation(context));
  }
}

class _CreditCardHolderNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardHolderName != current.creditCardHolderName ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardHolderName.invalid && state.status.isInvalid;
        return TextInputView(
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Card Holder Name',
          onChange: onChangeCreditCardHolderName,
          currentFocus: _creditCardHolderNameFocusNode,
          nextFocus: _creditCardNumberFocusNode,
          errorMessage: state.creditCardHolderName.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardHolderName(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNameChange(value));
  }
}

class _CreditCardNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardNumber != current.creditCardNumber ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardNumber.invalid && state.status.isInvalid;
        return TextInputView(
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          maxLength: 16,
          hintText: 'Card Number',
          onChange: onChangeCreditCardNumber,
          currentFocus: _creditCardNumberFocusNode,
          nextFocus: _creditCardExpiryMonthFocusNode,
          errorMessage: state.creditCardNumber.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardNumber(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNumberChange(value));
  }
}

class _CreditCardExpiryMonthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardExpiryMonth != current.creditCardExpiryMonth ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardExpiryMonth.invalid && state.status.isInvalid;
        return TextInputView(
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Card Expiry Month',
          maxLength: 2,
          onChange: onChangeCreditCardExpiryMonth,
          currentFocus: _creditCardExpiryMonthFocusNode,
          nextFocus: _creditCardExpiryYearFocusNode,
          errorMessage: state.creditCardExpiryMonth.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardExpiryMonth(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardExpiryMonthChange(value));
  }
}

class _CreditCardExpiryYearInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardExpiryYear != current.creditCardExpiryYear ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardExpiryYear.invalid && state.status.isInvalid;
        return TextInputView(
          mainContext: context,
          isNotValid: isNotValid,
          width: (ScreenSize().width! * 0.2),
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Card Expiry Year',
          maxLength: 2,
          onChange: onChangeCreditCardExpiryYear,
          currentFocus: _creditCardExpiryYearFocusNode,
          nextFocus: _creditCardCvvFocusNode,
          errorMessage: state.creditCardExpiryYear.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardExpiryYear(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardExpiryYearChange(value));
  }
}

class _CreditCardCvvInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardCvv != current.creditCardCvv ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid = state.creditCardCvv.invalid && state.status.isInvalid;
        return TextInputView(
          mainContext: context,
          isNotValid: isNotValid,
          onFieldSubmitted: (_) {},
          width: (ScreenSize().width! * 0.4),
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          maxLength: 3,
          hintText: 'Card Cvv',
          onChange: onChangeCreditCardCvv,
          currentFocus: _creditCardCvvFocusNode,
          errorMessage: state.creditCardCvv.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardCvv(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardCvvChange(value));
  }
}
