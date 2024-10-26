import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/response/jobs/get_job.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl,"/api/jobs");
    var response = await client.get(url, headers: requestHeaders);
    

    if (response.statusCode == 200) {
      print("data successfully recieved from Server");
      List<JobsResponse> joblist = jobsResponseFromJson(response.body);
      
      if(joblist.isEmpty){
        
        print("not getting Data");
        
        return throw  Exception("Not getting Data");
      }
      else{
        print("data successfully recieved from Server");
        return joblist;
      }
      
    } else {
      print(response.body);
      throw  Exception("Jobs not found");
    }
  }


  static Future<List<JobsResponse>> getRecent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl,"/api/jobs",{"new":"true"});
    var response = await client.get(url, headers: requestHeaders);
    

    if (response.statusCode == 200) {
      print("data successfully recieved from Server");
      List<JobsResponse> joblist = jobsResponseFromJson(response.body);
      
      if(joblist.isEmpty){
        
        print("not getting Data");
        
        return throw  Exception("Not getting Data");
      }
      else{
        print("data successfully recieved from Server");
        return joblist;
      }
      
    } else {
      print(response.statusCode);
      throw  Exception("Jobs not found");
    }
  }
   
   static Future<List<JobsResponse>> SearchJobs(String query) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl,"/api/jobs/search/$query");
    var response = await client.get(url, headers: requestHeaders);
    

    if (response.statusCode == 200) {
      print("data successfully recieved from Server");
      List<JobsResponse> joblist = jobsResponseFromJson(response.body);
      
      if(joblist.isEmpty){
        
        print("not getting Data");
        
        return throw  Exception("Not getting Data");
      }
      else{
        print("data successfully recieved from Server");
        return joblist;
      }
      
    } else {
      print(response.statusCode);
      throw  Exception("Jobs not found");
    }
  }

   static Future<GetJobRes> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.job}/$jobId");
    var response = await client.get(url, headers: requestHeaders);
     
     
    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      print("Data retrieved successfully");
      return job;
    } else {
      throw new Exception("Failed to get Jobs");
    }
  }

  static Future<bool> createJob(String model) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "/api/jobs");

      var response = await client.post(url, headers: requestHeaders,body: model);

      if (response.statusCode == 200) {
         print("status: 200  ${response.body}");
        return true;
      } else {
        // print("in else statement");
         print("in else statement   ${response.body}");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateJob(String model,String id) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "/api/jobs/$id");

      var response = await client.put(url, headers: requestHeaders,body: model);
       print(response.statusCode);
      if (response.statusCode == 200) {
         print("status: 200  ${response.body}");
        return true;
      } else {
        // print("in else statement");
         print("in else statement   ${response.body}");
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
