import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/appBar.dart';
import 'package:survey/components/loader.dart';
import 'package:survey/models/job.dart';
import 'package:survey/models/job_details.dart';
import 'package:survey/repos/repo.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';
import 'package:intl/intl.dart';

class JobDetail extends StatefulWidget {
  final Job job;

  const JobDetail({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  Repo repo = Repo();
  late Future myFuture;
  final LocalStorage storage = LocalStorage('360_survey');

  String convertDate(date) {
    DateTime dttime = DateTime.parse(date);
    return DateFormat('yyy-MM-dd | kk:mm').format(dttime);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String username = storage.getItem('username');
    myFuture = repo.reqJobDetails(username, widget.job.regNum!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar('Job Details', 'ID: ${widget.job.regNum!}'),
      body: _body(),
    );
  }

  Widget _body() {
    return Builder(builder: (BuildContext context) {
      return FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              newPage(context, '/error');
            }
            if (snapshot.hasData) {
              List<JobDetails> jobDetails = snapshot.data!;

              return _stepper(jobDetails);
            }
            return const KLoader(color: AppColors.appColorPrimary, size: 60);
          });
    });
  }

  Widget _stepper(List<JobDetails> jobDetails) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.spacing_large),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: 160,
                child: Lottie.asset('assets/lottie/document.json')),
            const SizedBox(height: 20),
            Text(
                '${widget.job.description!} | ${widget.job.siteLocation!} - ${widget.job.district!}',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 12, color: AppColors.appTextColorPrimary)),
            const SizedBox(height: 24),
            Stepper(
              physics: const NeverScrollableScrollPhysics(),
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: List.generate(jobDetails.length, (index) {
                return Step(
                    title: Text(convertDate(jobDetails[index].date!)),
                    content: Text(jobDetails[index].statusComments!),
                    isActive: true);
              }),
            )
          ],
        ),
      ),
    );
  }
}
