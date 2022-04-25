import 'package:flutter/material.dart';
import 'package:survey/components/button.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/utils/helpers.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_large),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.spacing_xlarge),
                    child: Image.asset('assets/images/logo.png')),
                const SizedBox(height: AppConstants.spacing_large),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(height: AppConstants.spacing_middle),
                const Text(
                    'Keep track of progress for your land documentation with just a click'),
                const SizedBox(height: AppConstants.spacing_xlarge),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: KButton(
                        onPressed: () => newPage(context, '/register'),
                        label: 'Sign Up',
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacing_standard),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: KButton(
                        onPressed: () => newPage(context, '/login'),
                        label: 'Login',
                        backgroundColor: Colors.transparent,
                        labelColor: AppColors.appTextColorPrimary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing_large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Read our ',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: AppConstants.textSizeSmall)),
                    InkWell(
                      onTap: (){},
                        child: Text('Privacy Policy & Terms of Use',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: AppColors.appColorPrimary, fontSize: AppConstants.textSizeSmall)))
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
