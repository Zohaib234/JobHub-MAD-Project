// To parse this JSON data, do
//
//     final allBookmarks = allBookmarksFromJson(jsonString);

import 'dart:convert';

List<AllBookmarks> allBookmarksFromJson(String str) => List<AllBookmarks>.from(
    json.decode(str).map((x) => AllBookmarks.fromJson(x)));

String allBookmarksToJson(List<AllBookmarks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookmarks {
  final String id;
  final String userId;
  final Job? job;

  AllBookmarks({
    required this.id,
    required this.userId,
    this.job,
  });

  factory AllBookmarks.fromJson(Map<String, dynamic> json) => AllBookmarks(
        id: json["_id"],
        userId: json["userId"],
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "job": job?.toJson(),
      };
}

class Job {
  final String id;
  final String title;
  final String location;
  final String agentName;
  final String salary;
  final String period;
  final String contract;
  final bool hiring;
  final String imageUrl;
  final String agentId;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.agentName,
    required this.salary,
    required this.period,
    required this.contract,
    required this.hiring,
    required this.imageUrl,
    required this.agentId,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"] ?? '', // Provide a default value if null
        title: json["title"] ?? '', // Provide a default value if null
        location: json["location"] ?? '', // Provide a default value if null
        agentName: json["agentName"] ?? '', // Provide a default value if null
        salary: json["salary"] ?? '', // Provide a default value if null
        period: json["period"] ?? '', // Provide a default value if null
        contract: json["contract"] ?? '', // Provide a default value if null
        hiring: json["hiring"] ?? false, // Provide a default value if null
        imageUrl: json["imageUrl"] ?? '', // Provide a default value if null
        agentId: json["agentId"] ?? '', // Provide a default value if null
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "agentName": agentName,
        "salary": salary,
        "period": period,
        "contract": contract,
        "hiring": hiring,
        "imageUrl": imageUrl,
        "agentId": agentId,
      };
}
