import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhubv2_0/models/response/bookmarks/add_bookmark.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/models/response/bookmarks/bookmark.dart';
import 'package:jobhubv2_0/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();

  static Future<AddBookMarkResponse> addBookmark(String model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/bookmarks");
    var response = await client.post(url, body: model, headers: requestHeaders);

    if (response.statusCode == 201) {
      var bookmark = addBookMarkResponseFromJson(response.body);
      print(bookmark);
      return bookmark;
    } else {
      throw Exception("Failed to create bookmark");
    }
  }

  static Future<List<AllBookmarks>> getAllBookmark() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/bookmarks");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var bookmarks = allBookmarksFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception("Failed to get bookmarks");
    }
  }

  static Future<BookMark?> getBookmark(String id) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString('token');

      if (token == null) {
        return null;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "/api/bookmarks/$id");

      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var bookmark = bookMarkFromJson(response.body);
        return bookmark;
      } else {
        // print("in else statement");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteBookmark(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "/api/bookmarks/$id");
    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
