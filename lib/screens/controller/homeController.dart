import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom/screens/modals/FindAllMeetingModalData.dart';
import 'package:zoom/screens/view/homeScreens.dart';

class HomeController extends GetxController {
  RxList<Datum> findmeeting = <Datum>[].obs;
  RxBool isLoading = false.obs;

  var token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZGYxYTAwNTNjODViYzEyNjBjNTc3OCIsInVzZXJuYW1lIjoiR2lvdmFubmE4IiwiaWF0IjoxNjkyMzQ4OTY5LCJleHAiOjE2OTI5NDg5Njl9.CMoA7_5G94R6Dvr4Wp2Tww5q0qQ7HipwjW6Mwm5WfRw';


  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      Get.offAll(() => const HomeScreens());
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    return val != null;
  }

  Future<void> login(String username, String password) async {
    final bodys = {"username": username, "password": password};
    final header = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    if (username.isNotEmpty && password.isNotEmpty) {
      var url =
      Uri.parse('https://8b0e09-cate-sandbox.dhiwise.co/device/auth/login');
      var response =
      await http.post(url, body: jsonEncode(bodys), headers: header);

      if (response.statusCode == 200) {
        // Login successful, handle the response

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("login", token);
        Get.rawSnackbar(
          message: "Login Successfully",
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
        );
        Get.offAll(() => const HomeScreens());
      } else {
        // Login failed, handle the error
        Get.rawSnackbar(
          message: "Something went wrong",
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      Get.rawSnackbar(
        message: "Blank Value Found",
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> addMeeting({
    required String meetingtitle,
    required String meetingdate,
    required String meetingfrom,
    required String meetingto,
    required String expectedmember,
    required String meetingid,
    required String meetingdescription,
    required String meetingimage,
  }) async {
    final body = {
      "space_id": "64df341a781d27a878bd2dd7",
      "user_id": "64df1a0053c85bc1260c5778",
      "meeting_title": meetingtitle,
      "meeting_date": meetingdate,
      "meeting_from": meetingfrom,
      "meeting_to": meetingto,
      "expected_member": int.parse(expectedmember),
      "meeting_id": int.parse(meetingid),
      "meeting_description": meetingdescription,
      "meeting_image": meetingimage,
    };
    final header = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (meetingtitle.isNotEmpty &&
        meetingdescription.isNotEmpty &&
        meetingdate.isNotEmpty &&
        meetingfrom.isNotEmpty &&
        meetingto.isNotEmpty &&
        expectedmember.isNotEmpty &&
        meetingid.isNotEmpty &&
        meetingimage.isNotEmpty) {
      var url = Uri.parse(
          'https://8b0e09-cate-sandbox.dhiwise.co/device/api/v1/meeting/create');
      var response =
      await http.post(url, body: jsonEncode(body), headers: header);

      if (response.statusCode == 200) {
        // Data added successfully
        Get.rawSnackbar(
          message: "Your request is successfully executed",
          backgroundColor: Colors.white,
        );
        findAllMeeting();
        Get.offAll(() => const HomeScreens());
      } else {
        // Failed to add data
        Get.rawSnackbar(
          message: "Please Check Your Data",
          backgroundColor: Colors.white,
        );
      }
    } else {
      Get.rawSnackbar(
        message: "Blank Value Found",
        backgroundColor: Colors.white,
      );
    }
  }

  Future<void> findAllMeeting() async {
    try {
      var url = Uri.parse(
          'https://8b0e09-cate-sandbox.dhiwise.co/device/api/v1/meeting/list');
      var response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Clear the existing meeting list
        findmeeting.clear();

        FindAllMeetingModalData findAllMeetingModalData =
        FindAllMeetingModalData.fromJson(jsonDecode(response.body));

        // Add the new data to the meeting list
        findmeeting.addAll(findAllMeetingModalData.data!.data!);

        // Sort the meeting list
        sortData();
      } else {
        throw Exception('Something went wrong. Please check your data.');
      }
    } catch (e) {
      throw Exception('Failed to fetch meeting data: $e');
    }
  }

  Future<void> updateData(
      String editTitle,
      String editDate,
      String editFrom,
      String editTo,
      int editExpectedMember,
      int editMeetingid,
      String editDescription,
      String editImage,
      String id,
      ) async {
    final body = {
      "space_id": "64df341a781d27a878bd2dd7",
      "user_id": "64df1a0053c85bc1260c5778",
      "meeting_title": editTitle,
      "meeting_date": editDate,
      "meeting_from": editFrom,
      "meeting_to": editTo,
      "expected_member": editExpectedMember,
      "meeting_id": editMeetingid,
      "meeting_description": editDescription,
      "meeting_image": editImage,
      "isDeleted": false,
      "id": id,
    };
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        'https://8b0e09-cate-sandbox.dhiwise.co/device/api/v1/meeting/update/$id');

    var response = await http.put(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      // Data update successful
      Get.offAll(() => const HomeScreens());
      await findAllMeeting();
      sortData();
    } else {
      // Data update failed
      Get.snackbar("OOPS", "Your Data is Not Updated",
          backgroundColor: Colors.white);
      throw jsonDecode(response.body)['meta']["message"] ??
          "Unknown Error Occurred";
    }
  }

  Future<void> deleteData(String id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse(
        'https://8b0e09-cate-sandbox.dhiwise.co/device/api/v1/meeting/delete/$id');
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      // Data deletion successful
      Get.snackbar("Deleted", "Your Data is Successfully Deleted",
          backgroundColor: Colors.white);
      await findAllMeeting();
    } else {
      // Data deletion failed
      Get.snackbar("OOPS", "Your Data is Not Deleted",
          backgroundColor: Colors.white);
      throw jsonDecode(response.body)['meta']["message"] ??
          "Unknown Error Occurred";
    }
  }

  void sortData() {
    // Sort the meeting list based on meeting date and time
    findmeeting.sort((a, b) {
      // Convert meeting date and time strings to DateTime objects for comparison
      DateTime dateA = DateFormat('dd/MM/yyyy hh:mm a')
          .parse('${a.meetingDate} ${a.meetingFrom}');
      DateTime dateB = DateFormat('dd/MM/yyyy hh:mm a')
          .parse('${b.meetingDate} ${b.meetingFrom}');

      return dateA.compareTo(dateB);
    });
  }
}
