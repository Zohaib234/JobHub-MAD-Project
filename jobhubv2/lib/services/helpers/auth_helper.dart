import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/request/auth/login_model.dart';
import 'package:jobhubv2_0/models/request/auth/profile_update_model.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/models/response/auth/login_res_model.dart';
import 'package:jobhubv2_0/models/response/auth/profile_model.dart';
import 'package:jobhubv2_0/models/response/auth/skills.dart';
import 'package:jobhubv2_0/services/config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, "/api/auth/register");
      var response =
          await client.post(url, body: model, headers: requestHeaders);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(String model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "/api/auth/login");
    var response = await client.post(url, body: model, headers: requestHeaders);
    
    if (response.statusCode == 200) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      var user = loginResponseModelFromJson(response.body);
      await preferences.setString("token", user.token);
      await preferences.setString("userId", user.user.id);
      await preferences.setString("uid", user.user.uid);
      await preferences.setString("profile", user.user.profile);
      await preferences.setBool("isAgent", user.user.isAgent);
      await preferences.setString("username", user.user.username);
      await preferences.setBool("loggedIn", true);
       
      print(preferences.getString("token"));
      print(preferences.getString("profile"));
      print(preferences.getString("username"));
     
      return true;
    } else {
      
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception("no authentication token found");
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users");
    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var profile = profileResFromJson(response.body);
        print("recieved profile successfully");
        return profile;
      } else {
        print(response.body);
        throw Exception(" failed to get profile");
      }
    } catch (e) {
      throw Exception("failed to get profile $e");
    }
  }

  static Future<List<Skills>> getSkills() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception("no authentication token found");
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users/skills");
    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var profile = skillsFromJson(response.body);
        return profile;
      } else {
        throw Exception(" failed to get skills");
      }
    } catch (e) {
      throw Exception("failed to get skills $e");
    }
  }

  static Future<bool> deleteSkill(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception("no authentication token found");
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users/skills/:$id");
    try {
      var response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        print(response.body);
        print("Skill deleted");
        return true;
      } else {
        print("failed to delete skill");
         print(response.body);
        return false;
      }
    } catch (e) {
      throw Exception("failed to delete skill $e");
    }
  }
  
  static Future<bool> addSkill(String model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception("no authentication token found");
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/users/skills");
    try {
      var response = await client.delete(url, headers: requestHeaders,body: model);

      if (response.statusCode == 200) {
       
        print("Skill added");
        return true;
      } else {
        print("failed to add skill");
        
        return false;
      }
    } catch (e) {
      throw Exception("failed to add skill $e");
    }
  }

}
