// To parse this JSON data, do
//
//     final getAgent = getAgentFromJson(jsonString);

import 'dart:convert';

List<GetAgent> getAgentFromJson(String str) => List<GetAgent>.from(json.decode(str).map((x) => GetAgent.fromJson(x)));

String getAgentToJson(List<GetAgent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAgent {
    final String id;
    final String userId;
    final String uid;
    final String company;
    final String hqAddress;
    final String workingHrs;

    GetAgent({
        required this.id,
        required this.userId,
        required this.uid,
        required this.company,
        required this.hqAddress,
        required this.workingHrs,
    });

    factory GetAgent.fromJson(Map<String, dynamic> json) => GetAgent(
        id: json["_id"],
        userId: json["userId"],
        uid: json["uid"],
        company: json["company"],
        hqAddress: json["hq_address"],
        workingHrs: json["working_hrs"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "uid": uid,
        "company": company,
        "hq_address": hqAddress,
        "working_hrs": workingHrs,
    };
}
