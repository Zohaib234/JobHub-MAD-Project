import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class RecentJobList extends StatelessWidget {
  const RecentJobList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getRecentJobs();
      return SizedBox(
        height: hieght * 0.26,
        child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.recentJobs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: PageLoader());
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

                      return  UploadedTile(job: job,);
                    });
              }
            }),
      );
    });
  }
}