import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/response/applied/applied.dart';
import 'package:jobhubv2_0/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppliedHelper {
  static var client = https.Client();

  static Future<bool> applyJob(String model) async {
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

    var url = Uri.https(
      Config.apiUrl,
      '/api/applied',
    );

    var response = await client.post(url, headers: requestHeaders, body: model);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Applied>> getAppliedJobs() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception("failed to get token");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(
      Config.apiUrl,
      '/api/applied',
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var applied = appliedFromJson(response.body);

      return applied;
    } else {
      throw Exception("failed to get applied Jobs");
    }
  }
}
