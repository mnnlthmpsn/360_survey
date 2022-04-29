import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/repos/repo.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _primCont = TextEditingController();
  final TextEditingController _secCont = TextEditingController();
  final TextEditingController _thirCont = TextEditingController();
  final TextEditingController _fourCont = TextEditingController();
  final TextEditingController _fifCont = TextEditingController();
  final TextEditingController _sixCont = TextEditingController();

  bool isLoading = false;
  String username = '';
  final LocalStorage storage = LocalStorage('360_survey');

  final Repo _repo = Repo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String username = storage.getItem('username');
    setState(() => username = username);
  }

  void resendOTP() async {
    dynamic payload = {
      "username": username,
      "key":"1qaz@WSX"
    };

    try {
      bool isSuccessful = await _repo.resendOTP(payload);
      isSuccessful
          ? showSnackBar(context, 'OTP Resent', 'success')
          : throw 'Error resending OTP';
    }
    catch(e) {
      print(e);
      showSnackBar(context, e.toString(), 'warning');
    }
  }

  void submit() async {
    setState(() => isLoading = true);

    dynamic otpCode = _primCont.value.text +
        _secCont.value.text +
        _thirCont.value.text +
        _fourCont.value.text +
        _fifCont.value.text +
        _sixCont.value.text;

    dynamic payload = {
      "username": username,
      "code": otpCode.toString(),
      "key":"1qaz@WSX"
    };

    try {
      bool isSuccessful = await _repo.validateOTP(payload);
      isSuccessful
          ? newPageDestroyAll(context, '/dashboard')
          : showSnackBar(context, 'OTP validation error', 'warning');
    }
        catch(e) {
          newPage(context, '/error');
        }
    finally {
      setState(() => isLoading = false);
    }
  }

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
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.spacing_large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppConstants.spacing_large),
            Lottie.asset('assets/lottie/otp.json'),
            const SizedBox(height: AppConstants.spacing_xxLarge),
            Text('OTP Verification',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 18)),
            const SizedBox(height: AppConstants.spacing_xxLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textFieldOTP(first: true, last: false, controller: _primCont),
                _textFieldOTP(first: false, last: false, controller: _secCont),
                _textFieldOTP(first: false, last: false, controller: _thirCont),
                _textFieldOTP(first: false, last: false, controller: _fourCont),
                _textFieldOTP(first: false, last: false, controller: _fifCont),
                _textFieldOTP(first: false, last: true, controller: _sixCont),
              ],
            ),
            const SizedBox(height: AppConstants.spacing_standard_new),
            SizedBox(
                width: double.infinity,
                child: KButton(
                    label: 'Finish', isLoading: isLoading, onPressed: submit)),
            const SizedBox(height: AppConstants.spacing_xxLarge),
            InkWell(
              onTap: resendOTP,
              child: const Text(
                  'Resend Code', style: TextStyle(color: AppColors.appColorPrimary)),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first,
      required bool last,
      required TextEditingController controller}) {
    return Builder(
      builder: (BuildContext context) {
        return SizedBox(
          height: 60,
          child: AspectRatio(
            aspectRatio: .8,
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: (value) {
                if (value.length == 1 && last == false) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.isEmpty && first == false) {
                  FocusScope.of(context).previousFocus();
                }
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                  counter: const Offstage(),
                  filled: true,
                  fillColor: AppColors.appLayoutBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.spacing_standard),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.4, color: AppColors.appColorPrimary),
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        );
      },
    );
  }
}
