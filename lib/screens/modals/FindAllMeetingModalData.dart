// To parse this JSON data, do
//
//     final findAllMeetingModalData = findAllMeetingModalDataFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

FindAllMeetingModalData findAllMeetingModalDataFromJson(String str) => FindAllMeetingModalData.fromJson(json.decode(str));

String findAllMeetingModalDataToJson(FindAllMeetingModalData data) => json.encode(data.toJson());

class FindAllMeetingModalData {
  String? status;
  String? message;
  Data? data;

  FindAllMeetingModalData({
    this.status,
    this.message,
    this.data,
  });

  factory FindAllMeetingModalData.fromJson(Map<String, dynamic> json) => FindAllMeetingModalData(
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
  List<Datum>? data;
  Paginator? paginator;

  Data({
    this.data,
    this.paginator,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    paginator: json["paginator"] == null ? null : Paginator.fromJson(json["paginator"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "paginator": paginator?.toJson(),
  };
}

class Datum {
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Paginator {
  int? itemCount;
  int? offset;
  int? perPage;
  int? pageCount;
  int? currentPage;
  int? slNo;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prev;
  dynamic next;

  Paginator({
    this.itemCount,
    this.offset,
    this.perPage,
    this.pageCount,
    this.currentPage,
    this.slNo,
    this.hasPrevPage,
    this.hasNextPage,
    this.prev,
    this.next,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
    itemCount: json["itemCount"],
    offset: json["offset"],
    perPage: json["perPage"],
    pageCount: json["pageCount"],
    currentPage: json["currentPage"],
    slNo: json["slNo"],
    hasPrevPage: json["hasPrevPage"],
    hasNextPage: json["hasNextPage"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "itemCount": itemCount,
    "offset": offset,
    "perPage": perPage,
    "pageCount": pageCount,
    "currentPage": currentPage,
    "slNo": slNo,
    "hasPrevPage": hasPrevPage,
    "hasNextPage": hasNextPage,
    "prev": prev,
    "next": next,
  };
}