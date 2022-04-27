import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/models/job.dart';
import 'package:survey/screens/jobDetails.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
          enableFeedback: true,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => JobDetail(job: job))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_standard_new),
            child: Row(
              children: [
                Icon(
                    job.status?.toLowerCase() == 'completed'
                        ? Icons.done_all_rounded
                        : job.status?.toLowerCase() == 'created'
                            ? Icons.document_scanner_rounded
                            : Icons.pending,
                    size: 40,
                    color: job.status?.toLowerCase() == 'completed'
                        ? Colors.green
                        : job.status?.toLowerCase() == 'created'
                            ? AppColors.appColorPrimary
                            : Colors.deepOrange),
                const SizedBox(width: AppConstants.spacing_large),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${job.regNum!}',
                          style: Theme.of(context).textTheme.headline6),
                      Text('${job.district} - ${job.siteLocation}'),
                      Text(
                        job.description!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontSize: AppConstants.textSizeSmall),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      decoration: BoxDecoration(
          color: AppColors.appColorPrimary.withOpacity(.1),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
