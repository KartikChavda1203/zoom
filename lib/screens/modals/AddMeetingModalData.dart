// To parse this JSON data, do
//
//     final addMettingModalData = addMettingModalDataFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AddMettingModalData addMettingModalDataFromJson(String str) => AddMettingModalData.fromJson(json.decode(str));

String addMettingModalDataToJson(AddMettingModalData data) => json.encode(data.toJson());

class AddMettingModalData {
  AddMettingModalData({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AddMettingModalData.fromJson(Map<String, dynamic> json) => AddMettingModalData(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.spaceId,
    this.userId,
    this.meetingTitle,
    this.meetingDate,
    this.meetingFrom,
    this.meetingTo,
    this.expectedMember,
    this.meetingId,
    this.meetingDescription,
    this.meetingImage,
    this.isDeleted,
    this.id,
  });

  String? spaceId;
  String? userId;
  String? meetingTitle;
  String? meetingDate;
  String? meetingFrom;
  String? meetingTo;
  int? expectedMember;
  int? meetingId;
  String? meetingDescription;
  String? meetingImage;
  bool? isDeleted;
  String? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    spaceId: json["space_id"],
    userId: json["user_id"],
    meetingTitle: json["meeting_title"],
    meetingDate: json["meeting_date"],
    meetingFrom: json["meeting_from"],
    meetingTo: json["meeting_to"],
    expectedMember: json["expected_member"],
    meetingId: json["meeting_id"],
    meetingDescription: json["meeting_description"],
    meetingImage: json["meeting_image"],
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "space_id": spaceId,
    "user_id": userId,
    "meeting_title": meetingTitle,
    "meeting_date": meetingDate,
    "meeting_from": meetingFrom,
    "meeting_to": meetingTo,
    "expected_member": expectedMember,
    "meeting_id": meetingId,
    "meeting_description": meetingDescription,
    "meeting_image": meetingImage,
    "isDeleted": isDeleted,
    "id": id,
  };
}
