import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/components/button.dart';
import 'package:survey/components/jobCard.dart';
import 'package:survey/components/kEmpty.dart';
import 'package:survey/components/loader.dart';
import 'package:survey/models/job.dart';
import 'package:survey/repos/repo.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final LocalStorage storage = LocalStorage('360_survey');
  late Future myFuture;
  final Repo repo = Repo();

  final List<Job> _compJobs = [];
  final List<Job> _pendingJobs = [];
  final List<Job> _createdJobs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String username = storage.getItem('username');
    myFuture = repo.reqJobs(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing_large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/error.json'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: KButton(label: 'Try Again', onPressed: () => newPageDestroyPrevious(context, '/login')))
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            List<Job> jobs = snapshot.data as List<Job>;

            if (jobs.isNotEmpty) {
              for (var job in jobs) {
                if (job.status?.toLowerCase() == 'pending') {
                  _pendingJobs.add(job);
                }
                if (job.status?.toLowerCase() == 'completed') {
                  _compJobs.add(job);
                }
                if (job.status?.toLowerCase() == 'created') {
                  _createdJobs.add(job);
                } else {
                  print(job);
                }
              }
              return _jobBody();
            } else {
              return const KEmpty();
            }
          }
          return const KLoader(color: AppColors.appColorPrimary, size: 60);
        });
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        foregroundColor: AppColors.appTextColorPrimary,
        toolbarHeight: 80,
        title: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_standard_new),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.spacing_middle),
                    Text(
                      'Jobs',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Current Jobs',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                IconButton(onPressed: () => newPage(context, '/settings'), icon: const Icon(Icons.settings))
              ],
            ),
          );
        }));
  }

  Widget _jobBody() {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      padding:
          const EdgeInsets.symmetric(vertical: AppConstants.spacing_control),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Created Jobs
          const SizedBox(height: AppConstants.spacing_standard_new),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing_large),
              child: Text('Submitted Jobs',
                  style: Theme.of(context).textTheme.headline6)),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_createdJobs),

          // pending jobs
          const SizedBox(height: AppConstants.spacing_xlarge),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_large),
            child: Text('In Progress',
                style: Theme.of(context).textTheme.headline6),
          ),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_pendingJobs),

          // pending jobs
          const SizedBox(height: AppConstants.spacing_xlarge),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_large),
            child: Text('Completed Jobs',
                style: Theme.of(context).textTheme.headline6),
          ),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_compJobs)
        ],
      ),
    );
  }

  Widget _jobs(List jobs) {
    return Builder(
      builder: (BuildContext context) {
        return jobs.isNotEmpty
            ? CarouselSlider(
                items: jobs.map((dynamic job) {
                  return JobCard(job: job);
                }).toList(),
                options: CarouselOptions(
                    initialPage: jobs.length,
                    autoPlay: false,
                    scrollPhysics: const BouncingScrollPhysics(),
                    reverse: true,
                    aspectRatio: 3,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false))
            : const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppConstants.spacing_middle,
                    horizontal: AppConstants.spacing_xlarge),
                child: Text('No jobs here'),
              );
      },
    );
  }
}
