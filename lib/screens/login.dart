import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/components/kTextInput.dart';
import 'package:survey/repos/repo.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Repo _repo = Repo();

  void _login() async {
    try {
      setState(() => isLoading = true);

      var params = {
        "username": _usernameController.value.text,
        "password": _passwordController.value.text,
        "key": "1qaz@WSX"
      };

      bool isSuccessful = await _repo.reqLogin(params);
      isSuccessful
          ? newPageDestroyPrevious(context, '/dashboard')
          : showSnackBar(context, 'Login Unsuccessful. Please try again', 'warning');
    } catch (e) {
      newPage(context, '/error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar('Login', 'Enter Username and Password'),
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
            children: <Widget>[
              Lottie.asset('assets/lottie/login.json', repeat: false),
              KTextInput(label: 'Username', controller: _usernameController),
              KTextInput(
                controller: _passwordController,
                label: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              _submitBtn(),
              Builder(builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(AppConstants.spacing_standard),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Forgot Password? ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontSize: AppConstants.textSizeSmall)),
                      InkWell(
                          onTap: () {},
                          child: Text('Reset Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      color: AppColors.appColorPrimary,
                                      fontSize: AppConstants.textSizeSmall)))
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppConstants.spacing_large)
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitBtn() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: KButton(
            label: 'Continue', isLoading: isLoading, onPressed: _login));
  }
}
