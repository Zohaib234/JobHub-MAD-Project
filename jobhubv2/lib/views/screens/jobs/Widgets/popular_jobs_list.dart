import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class PopularJobsList extends StatelessWidget {
  const PopularJobsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return SizedBox(
          height: hieght * 0.23,
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.joblist,
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
                      itemBuilder: (context, index) {
                        var job = jobs[index];
      
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UploadedTile(job: job,)
                        );
                      });
                }
              }),
        );
      }),
    );
  }
}