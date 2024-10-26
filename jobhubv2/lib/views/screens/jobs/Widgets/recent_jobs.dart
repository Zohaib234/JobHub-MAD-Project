import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/job_horizental_tile.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/job_vertical_tile.dart';
import 'package:jobhubv2_0/views/screens/jobs/job_details.dart';
import 'package:provider/provider.dart';

class RecentJobs extends StatefulWidget {
  const RecentJobs({super.key});

  @override
  State<RecentJobs> createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {
  @override
  void initState() {
    super.initState();
    final jobsNotifier = Provider.of<JobsNotifier>(context, listen: false);
    jobsNotifier.getRecentJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      return SizedBox(
        height: hieght * 0.23,
        child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.recentJobs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.data!.isEmpty) {
                return Center(child: Text("No Jobs Found"));
              } else {
                final jobs = snapshot.data;

                return ListView.builder(
                    itemCount: jobs!.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var job = jobs[index];

                      return JobVerticalTile(
                        job: job,
                      );
                    });
              }
            }),
      );
    });
  }
}
