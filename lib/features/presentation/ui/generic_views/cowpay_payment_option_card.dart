import 'package:cowpay/core/helpers/localization.dart';
import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CowpayPaymentOptionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize().width! * 0.01),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
            width: 1,
          ),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff66496A),
                      ),
                      height: 35,
                      width: 60,
                      child: SvgPicture.asset(
                        "assets/00-cow-pay-brand-logo.svg",
                        package: 'cowpay',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Cowpay',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/logos-mastercard.svg",
                      package: 'cowpay',
                    ),
                    SvgPicture.asset(
                      "assets/logos-visa.svg",
                      package: 'cowpay',
                    ),
                    SvgPicture.asset(
                      "assets/fawry-en-1-1.svg",
                      package: 'cowpay',
                    ),
                    SvgPicture.asset(
                      "assets/68-five-tips-for-pci-dss-compliance-1.svg",
                      package: 'cowpay',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Localization().localizationMap["cowpayPaymentOptionsText"],
            style: TextStyle(color: Color(0xff9B9B9C), fontSize: 15),
          ),
        ],
      ),
    );
  }
}
