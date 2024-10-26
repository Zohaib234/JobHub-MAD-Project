import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/job_horizental_tile.dart';
import 'package:jobhubv2_0/views/screens/jobs/job_details.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatefulWidget {
  const PopularJobs({super.key});

  @override
  State<PopularJobs> createState() => _PopularJobsState();
}

class _PopularJobsState extends State<PopularJobs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJobs();
      return SizedBox(
        height: hieght * 0.23,
        child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.joblist,
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
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var job = jobs[index];

                      return JobHorizentalTile(
                        onTap: () {
                          Get.to(()=>JobDetails(id: job.id,title: job.title,agentName: job.agentName,));
                        },
                        job: job,
                      );
                    });
              }
            }),
      );
    });
  }
}
