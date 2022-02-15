import 'package:flutter/material.dart';

class ButtonLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      width: deviceSize.width * 0.14,
      height: deviceSize.width * 0.14,
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xff3D1A54),
        ),
      ),
    );
  }
}
