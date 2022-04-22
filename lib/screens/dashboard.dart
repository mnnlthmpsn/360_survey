import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:survey/components/jobCard.dart';
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
  List _comJobs = [1, 2, 3];
  late Future myFuture;
  final Repo repo = Repo();

  final List<Job> _compJobs = [];
  final List<Job> _pendingJobs = [];
  final List<Job> _createdJobs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myFuture = repo.reqJobs('arnolddo');
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
            newPage(context, 'error');
          }
          if (snapshot.hasData) {
            List<Job> jobs = snapshot.data as List<Job>;

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
                IconButton(onPressed: () {}, icon: Icon(Icons.settings))
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
              child: Text('Created Jobs',
                  style: Theme.of(context).textTheme.headline6)),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_createdJobs),

          // completed jobs
          const SizedBox(height: AppConstants.spacing_xlarge),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_large),
            child: Text('Completed Jobs',
                style: Theme.of(context).textTheme.headline6),
          ),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_compJobs),

          // pending jobs
          const SizedBox(height: AppConstants.spacing_xlarge),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_large),
            child: Text('Pending Jobs',
                style: Theme.of(context).textTheme.headline6),
          ),
          const SizedBox(height: AppConstants.spacing_standard_new),
          _jobs(_pendingJobs)
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
                    autoPlay: false,
                    scrollPhysics: const BouncingScrollPhysics(),
                    reverse: true,
                    aspectRatio: 3,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true))
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