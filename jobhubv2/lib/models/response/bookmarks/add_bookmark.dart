// To parse this JSON data, do
//
//     final addBookMarkResponse = addBookMarkResponseFromJson(jsonString);

import 'dart:convert';

AddBookMarkResponse addBookMarkResponseFromJson(String str) => AddBookMarkResponse.fromJson(json.decode(str));

String addBookMarkResponseToJson(AddBookMarkResponse data) => json.encode(data.toJson());

class AddBookMarkResponse {
    final bool status;
    final String bookmarkId;

    AddBookMarkResponse({
        required this.status,
        required this.bookmarkId,
    });

    factory AddBookMarkResponse.fromJson(Map<String, dynamic> json) => AddBookMarkResponse(
        status: json["status"],
        bookmarkId: json["bookmarkId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "bookmarkId": bookmarkId,
    };
}
