// import 'dart:convert';

// ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));


// class ProfileRes {
//     ProfileRes({
//         required this.id,
//         required this.username,
//         required this.email,
//         // required this.isAdmin,
//         required this.isAgent,
//         required this.skills,
//         required this.profile,
//     });

//     final String id;
//     final String username;
//     final String email;
//     // final bool isAdmin;
//     final bool isAgent;
//     final bool skills;
//     final String profile;

//     factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
//         id: json["_id"],
//         username: json["username"],
//         email: json["email"],
//         // isAdmin: json["isAdmin"],
//         isAgent: json["isAgent"],
//         skills: json['skills'],
//         profile: json["profile"],
//     );


// }

// To parse this JSON data, do
//
//     final profileRes = profileResFromJson(jsonString);

import 'dart:convert';

ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
    final String id;
    final String username;
    final String email;
    final String uid;
    final bool updated;
    final bool isAdmin;
    final bool isAgent;
    final bool skills;
    final String profile;

    ProfileRes({
        required this.id,
        required this.username,
        required this.email,
        required this.uid,
        required this.updated,
        required this.isAdmin,
        required this.isAgent,
        required this.skills,
        required this.profile,
    });

    factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        uid: json["uid"],
        updated: json["updated"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json["skills"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "uid": uid,
        "updated": updated,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": skills,
        "profile": profile,
    };
}
