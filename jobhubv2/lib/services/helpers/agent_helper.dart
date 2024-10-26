import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/request/agents/agents.dart';
import 'package:jobhubv2_0/models/response/agent/getAgent.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentHelper {
  static var client = https.Client();

  static Future<List<Agents>> getAgents() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users/agents");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var agents = agentsFromJson(response.body);
      return agents;
    } else {
      throw Exception("Failed to get agents");
    }
  }

  static Future<List<GetAgent>> getAgent(String uid) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users/agents/$uid");
    var response = await client.get(url, headers: requestHeaders);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var agent = getAgentFromJson(response.body);
      print("inside if statement");
      return agent;
    } else {
      throw Exception("Failed to get agent");
    }
  }

  static Future<List<JobsResponse>> getAgentJobs(String uid) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/jobs/agent/$uid");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      print("data successfully recieved from Server");
      List<JobsResponse> joblist = jobsResponseFromJson(response.body);

      if (joblist.isEmpty) {
        print("not getting Data");

        return throw Exception("Not getting Data");
      } else {
        print("data successfully recieved from Server");
        return joblist;
      }
    } else {
      print(response.body);
      throw Exception("Jobs not found");
    }
  }
}
