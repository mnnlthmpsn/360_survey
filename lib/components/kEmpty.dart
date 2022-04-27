import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/utils/constants.dart';

class KEmpty extends StatelessWidget {
  const KEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_xxLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            Lottie.asset('assets/lottie/empty.json'),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            const Text('No jobs found', style: TextStyle(color: Colors.grey, fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
