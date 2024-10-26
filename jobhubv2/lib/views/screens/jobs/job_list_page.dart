import 'package:flutter/material.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/popular_jobs_list.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/recent_job_list.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key, required this.ispopular});
  final bool  ispopular ;
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar:  const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(text: "Jobs", child: BackBtn())),

      body:  ispopular ? const PopularJobsList() : const RecentJobList(),    
    );
  }
}
