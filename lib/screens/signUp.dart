import 'package:flutter/material.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/components/kDropdown.dart';
import 'package:survey/components/kTextInput.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<Map<String, dynamic>> gender = [
    {'key': 'Male', 'value': 'm'},
    {'key': 'Female', 'value': 'f'},
  ];

  List<Map<String, dynamic>> nationality = [
    {'key': 'Ghanaian', 'value': 'Ghanaian'},
    {'key': 'Nigerian', 'value': 'Nigerian'},
  ];

  List<Map<String, dynamic>> id_types = [
    {'key': 'Voter\'s ID', 'value': 'VID'},
    {'key': 'Driver\'s License', 'value': 'DVL'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightColor,
      appBar: KAppBar('Create Account', 'Register to continue'),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: AnimatedContainer(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.spacing_large),
        duration: const Duration(seconds: 2),
        child: Form(
          child: Column(
            children: [
              const KTextInput(label: 'Firstname'),
              const KTextInput(label: 'Lastname'),
              const KTextInput(label: 'Other Names'),
              const KTextInput(label: 'Username'),
              const KTextInput(
                  label: 'Date of Birth',
                  textInputType: TextInputType.datetime),
              KDropdown(label: 'Sex', items: gender),
              const KTextInput(label: 'Address'),
              KDropdown(label: 'Nationality', items: nationality),
              KDropdown(label: 'ID', items: id_types),
              const KTextInput(label: 'ID Number'),
              const KTextInput(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const KTextInput(
                  label: 'Phone', textInputType: TextInputType.phone),
              const KTextInput(
                label: 'Password',
                textInputType: TextInputType.visiblePassword,
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: KButton(
                      label: 'Continue',
                      onPressed: () => print('Hello world'))),
              const SizedBox(height: AppConstants.spacing_large)
            ],
          ),
        ),
      ),
    );
  }
}
