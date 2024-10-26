import 'dart:convert';

// BookMark bookMarkFromJson(String str) => BookMark.fromJson(json.decode(str));

// String bookMarkToJson(BookMark data) => json.encode(data.toJson());

// class BookMark {
//     final bool status;
//     final String bookmarkId;

//     BookMark({
//         required this.status,
//         required this.bookmarkId,
//     });

//     factory BookMark.fromJson(Map<String, dynamic> json) => BookMark(
//         status: json["status"],
//         bookmarkId: json["bookmarkId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "bookmarkId": bookmarkId,
//     };
// }
// To parse this JSON data, do
//
//     final bookMark = bookMarkFromJson(jsonString);

import 'dart:convert';

BookMark bookMarkFromJson(String str) => BookMark.fromJson(json.decode(str));

String bookMarkToJson(BookMark data) => json.encode(data.toJson());

class BookMark {
    final bool status;
    final Bookmark bookmark;

    BookMark({
        required this.status,
        required this.bookmark,
    });

    factory BookMark.fromJson(Map<String, dynamic> json) => BookMark(
        status: json["status"],
        bookmark: Bookmark.fromJson(json["bookmark"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "bookmark": bookmark.toJson(),
    };
}

class Bookmark {
    final String id;
    final String userId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Bookmark({
        required this.id,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["_id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
