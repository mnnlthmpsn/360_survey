import 'package:flutter/material.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar('Profile', 'Your user profile & settings'),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing_large),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 56,),
            Text('Get user details here'),
            SizedBox(height: 120),
            SizedBox(
              width: double.infinity,
              child: KButton(
                  label: 'Logout',
                  onPressed: () => newPageDestroyAll(context, '/welcome')),
            )
          ],
        ),
      ),
    );
  }
}
