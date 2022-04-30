import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/components/kDropdown.dart';
import 'package:survey/components/kTextInput.dart';
import 'package:survey/repos/repo.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _othernameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final LocalStorage _sexStore = LocalStorage('sex');
  final LocalStorage _nationalityStore = LocalStorage('nationality');
  final LocalStorage _idStore = LocalStorage('id');
  final LocalStorage storage = LocalStorage('360_survey');

  Repo repo = Repo();
  bool isLoading = false;

  List<Map<String, dynamic>> gender = [
    {'key': 'Male', 'value': 'm'},
    {'key': 'Female', 'value': 'f'},
  ];

  List<Map<String, dynamic>> nationality = [
    {'key': 'Ghanaian', 'value': 'Ghanaian'},
    {'key': 'Nigerian', 'value': 'Nigerian'},
    {'key': 'Other', 'value': 'other'},
  ];

  List<Map<String, dynamic>> id_types = [
    {'key': 'Voter\'s ID', 'value': 'VID'},
    {'key': 'Ghana Card', 'value': 'GHC'},
    {'key': 'Driver\'s License', 'value': 'DVL'},
  ];

  void _saveToStorage(username) {
    storage.setItem('username', username);
  }

  void _sendOTP() async {
    LocalStorage storage = LocalStorage('360_survey');
    String username = storage.getItem('username');

    // useless commit for git

    dynamic payload = {
      "username": username,
      "key":"1qaz@WSX"
    };

    try {
      repo.resendOTP(payload);
    } catch(e) {
      showSnackBar(context, e.toString(), 'warning');
    }
  }

  void signUp() async {
    dynamic payload = {
      "firstname": _firstnameController.value.text.trim(),
      "lastname": _lastnameController.value.text.trim(),
      "othername": _othernameController.value.text.trim(),
      "username": _usernameController.value.text.trim(),
      "dob": _dobController.value.text.trim(),
      "sex": _sexStore.getItem('sex').trim(),
      "address": _addressController.value.text.trim(),
      "nationality": _nationalityStore.getItem('nationality'),
      "id_type": _idStore.getItem('id'),
      "id_number": _idNumberController.value.text.trim(),
      "email": _emailController.value.text.trim(),
      "password": _passwordController.value.text.trim(),
      "phone_number": _phoneNumberController.value.text.trim(),
      "key": "1qaz@WSX"
    };

    try {
      setState(() => isLoading = true);

      dynamic res = await repo.reqRegister(payload);
      _saveToStorage(_usernameController.value.text);

      if (res['status'] == 0) {
        newPage(context, '/otp');
      } else if (res['status'] == 1) {
      //  resend token
        _sendOTP();
        newPage(context, '/otp');
      } else {
        showSnackBar(context, res['message'], 'warning');
      }
    } catch (e) {
      print(e);
      newPage(context, '/error');
    } finally {
      setState(() => isLoading = false);
    }
  }

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
              KTextInput(label: 'Firstname', controller: _firstnameController),
              KTextInput(label: 'Lastname', controller: _lastnameController,),
              KTextInput(label: 'Other Names', controller: _othernameController,),
              KTextInput(label: 'Username', controller: _usernameController),
              KTextInput(
                  label: 'Date of Birth',
                  textInputType: TextInputType.datetime, controller: _dobController,),
              KDropdown(label: 'Sex', items: gender),
              KTextInput(label: 'Address', controller: _addressController),
              KDropdown(label: 'Nationality', items: nationality),
              KDropdown(label: 'ID', items: id_types),
              KTextInput(label: 'ID Number', controller: _idNumberController,),
              KTextInput(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController
              ),
              KTextInput(
                  label: 'Phone', textInputType: TextInputType.phone, controller: _phoneNumberController),
              KTextInput(
                label: 'Password',
                textInputType: TextInputType.visiblePassword,
                isPassword: true,
                textInputAction: TextInputAction.done,
                controller: _passwordController
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: KButton(
                      label: 'Continue',
                      isLoading: isLoading,
                      onPressed: signUp)),
              const SizedBox(height: AppConstants.spacing_large)
            ],
          ),
        ),
      ),
    );
  }
}
