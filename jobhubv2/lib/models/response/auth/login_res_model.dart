import 'dart:convert';

// LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

// class LoginResponseModel {
//     final String? id;
//     final String? profile;
//     final String? userToken;
//     final String? uid;
//     final String? username;

//     LoginResponseModel({
//         required this.id,
//         required this.profile,
//         required this.userToken,
//         required this.uid,
//         required this.username,
//     });

//     factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//         id: json["_id"],
//         profile: json["profile"],
//         userToken: json["userToken"],
//         uid: json["uid"],
//         username: json["username"],
//     );

// }

// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String token;
    final User user;

    LoginResponseModel({
        required this.token,
        required this.user,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    final String id;
    final String username;
    final String uid;
    final bool updated;
    final bool isAgent;
    final String profile;
    final int v;

    User({
        required this.id,
        required this.username,
        required this.uid,
        required this.updated,
        required this.isAgent,
        required this.profile,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        uid: json["uid"],
        updated: json["updated"],
        isAgent: json["isAgent"],
        profile: json["profile"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "uid": uid,
        "updated": updated,
        "isAgent": isAgent,
        "profile": profile,
        "__v": v,
    };
}

