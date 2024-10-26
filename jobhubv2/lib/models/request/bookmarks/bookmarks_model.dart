import 'dart:convert';

// BookmarkReqResModel bookmarkReqResModelFromJson(String str) => BookmarkReqResModel.fromJson(json.decode(str));

// String bookmarkReqResModelToJson(BookmarkReqResModel data) => json.encode(data.toJson());

// class BookmarkReqResModel {
//     final String job;

//     BookmarkReqResModel({
//         required this.job,
//     });

//     factory BookmarkReqResModel.fromJson(Map<String, dynamic> json) => BookmarkReqResModel(
//         job: json["job"],
//     );

//     Map<String, dynamic> toJson() => {
//         "job": job,
//     };
// }
BookMarkReqRes bookMarkReqResFromJson(String str) => BookMarkReqRes.fromJson(json.decode(str));

String bookMarkReqResToJson(BookMarkReqRes data) => json.encode(data.toJson());

class BookMarkReqRes {
    final String job;

    BookMarkReqRes({
        required this.job,
    });

    factory BookMarkReqRes.fromJson(Map<String, dynamic> json) => BookMarkReqRes(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
    };
}
