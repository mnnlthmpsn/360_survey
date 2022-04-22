import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/models/job.dart';
import 'package:survey/utils/constants.dart';

class JobDetail extends StatelessWidget {
  final Job job;

  const JobDetail({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar('Job Details', 'ID: ${job.regNum!}'),
      body: _body(),
    );
  }

  Widget _body() {
    return Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          padding: const EdgeInsets.all(AppConstants.spacing_large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Lottie.asset('assets/lottie/document.json', repeat: false, width: 200)),
              const SizedBox(height: AppConstants.spacing_standard_new),
              Text('Job Details', style: Theme.of(context).textTheme.headline6),
              ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.insert_drive_file),
                title: Text('ID', style: Theme.of(context).textTheme.headline6),
                subtitle: Text(job.regNum!, style: Theme.of(context).textTheme.subtitle2),
              ),
              ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.location_on),
                title: Text('Site Location', style: Theme.of(context).textTheme.headline6),
                subtitle: Text('${job.district} - ${job.siteLocation}', style: Theme.of(context).textTheme.subtitle2),
              ),
              ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.description),
                title: Text('Description', style: Theme.of(context).textTheme.headline6),
                subtitle: Text(job.description!, style: Theme.of(context).textTheme.subtitle2),
              ),
              ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.info_rounded),
                title: Text('Status: ${job.status!}', style: Theme.of(context).textTheme.subtitle2),
                subtitle: Text(job.entryDate!, style: Theme.of(context).textTheme.subtitle2),
              ),
            ],
          ),
        ),
      );
    });
  }
}
