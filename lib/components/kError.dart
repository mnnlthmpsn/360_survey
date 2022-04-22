import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/button.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class KError extends StatelessWidget {
  const KError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar('Error', 'Something went wrong'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacing_large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/error.json'),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                  child: KButton(label: 'Try Again', onPressed: () => Navigator.pop(context)))
            ],
          ),
        ),
      ),
    );
  }
}
