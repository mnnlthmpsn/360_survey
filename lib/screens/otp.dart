import 'package:flutter/material.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/utils/colors.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightColor,
      appBar: KAppBar('Confirm OTP', 'Enter OTP code to continue'),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Text('otp here');
  }
}
