import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/models/response/jobs/get_job.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/services/helpers/book_helper.dart';
import 'package:jobhubv2_0/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {

  late Future<List<JobsResponse>> joblist;
  late Future<List<JobsResponse>> recentJobs;
  late Future<GetJobRes> job;
  Future<List<JobsResponse>> getJobs(){
    
    joblist = JobsHelper.getJobs();
    return joblist;

  }
  Future<List<JobsResponse>> getRecentJobs(){
    
    recentJobs = JobsHelper.getRecent();
    return recentJobs;

  }

  Future<GetJobRes> getJob(String id) async {
    job = JobsHelper.getJob(id);
    return job;
  }
  



}
