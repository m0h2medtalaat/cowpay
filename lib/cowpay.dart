library cowpay;

import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/bloc/cowpay_bloc.dart';
import 'bloc/event/cowpay_event.dart';
import 'bloc/state/cowpay_state.dart';
import 'helpers/localization.dart';
import 'helpers/screen_size.dart';
import 'models/credit_card_response_model.dart';

export 'package:cowpay/api_calls/exceptions.dart';
export 'package:cowpay/helpers/enum_models.dart';

class Cowpay extends StatefulWidget {
  Cowpay({
    Key? key,
    required this.description,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.customerEmail,
    required this.customerMobile,
    required this.activeEnvironment,
    required this.amount,
    required this.customerName,
    this.height,
    this.buttonColor,
    this.buttonTextColor,
    this.mainColor,
    this.buttonTextStyle,
    this.textFieldStyle,
    this.textFieldInputDecoration,
    this.localizationCode,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);
  // double amount = 150.0;
  // String customerEmail = "example@mail.com";
  // String customerMobile = "01068890002";
  // String description = "description";
  // String customerMerchantProfileId = "ExmpleId122345682";

  final String description, merchantReferenceId, customerMerchantProfileId;

  final String customerEmail, customerName;

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

  @override
  State<Cowpay> createState() => _CowpayState();
}

class _CowpayState extends State<Cowpay> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    if (widget.localizationCode == LocalizationCode.ar) {
      Localization().localizationMap = localizationMapAr;
      Localization().localizationCode = LocalizationCode.ar;
    }
    return Directionality(
      textDirection: widget.localizationCode == LocalizationCode.ar
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(Localization().localizationMap["paymentMethod"]),
          backgroundColor: Color(0xff66496A),
        ),
        body: DefaultTabController(
          length: 2,
          child: BlocProvider<CowpayBloc>(
            create: (context) {
              return CowpayBloc();
            },
            child: Column(
              children: [
                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CreditCardWidget(
                          localizationCode: LocalizationCode.en,
                          amount: widget.amount,
                          customerEmail: widget.customerEmail,
                          customerMobile: widget.customerMobile,
                          description: widget.description,
                          customerMerchantProfileId:
                              widget.customerMerchantProfileId,
                          merchantReferenceId: "11",
                          activeEnvironment: CowpayEnvironment.staging,
                          onSuccess: (val) {
                            debugPrint(val.statusDescription);
                            // Navigator.pop(context);
                          },
                          onError: (val) {
                            debugPrint(val.toString());
                          },
                        ),
                        CreditCardWidget(
                          localizationCode: LocalizationCode.en,
                          amount: widget.amount,
                          customerEmail: widget.customerEmail,
                          customerMobile: widget.customerMobile,
                          description: widget.description,
                          customerMerchantProfileId:
                              widget.customerMerchantProfileId,
                          merchantReferenceId: "11",
                          activeEnvironment: CowpayEnvironment.staging,
                          onSuccess: (val) {
                            debugPrint(val.statusDescription);
                            // Navigator.pop(context);
                          },
                          onError: (val) {
                            debugPrint(val.toString());
                          },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return BlocBuilder<CowpayBloc, CowpayState>(
        buildWhen: (previous, current) =>
            previous.tabCurrentIndex != current.tabCurrentIndex,
        builder: (context, state) {
          return Container(
              width: ScreenSize().width!,
              height: ScreenSize().height! * 0.2,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (ScreenSize().width! * 0.01),
                      vertical: (ScreenSize().height! * 0.02)),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        2,
                        (index) => _buildTabCard(
                            state.tabCurrentIndex, index, context),
                      ))));
        });
  }

  Widget _buildTabCard(int currentIndex, int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (ScreenSize().width! * 0.01),
          vertical: (ScreenSize().height! * 0.01)),
      child: GestureDetector(
        onTap: () {
          if (currentIndex != index) {
            context.read<CowpayBloc>().add(ChangeTabCurrentIndexEvent(index));

            _tabController.animateTo(index);
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: (ScreenSize().width! * 0.22),
            decoration: BoxDecoration(
                border: Border.all(
                    width: currentIndex == index ? 2 : 1,
                    color: currentIndex == index
                        ? Colors.deepPurple
                        : Colors.grey),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      index == 0
                          ? "assets/credit-card-svgrepo-com.svg"
                          : "assets/combined-shape.svg",
                      package: 'cowpay',
                      fit: BoxFit.fill,
                      color: currentIndex == index
                          ? Colors.deepPurple
                          : Colors.black,
                    ),
                  ),
                  Text(
                    index == 0
                        ? Localization().localizationMap["creditCard"]
                        : Localization().localizationMap["fawry"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == index
                          ? Colors.deepPurple
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
