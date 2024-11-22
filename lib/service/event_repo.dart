import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/app_urls.dart';
import 'shared_pref.dart';

class EventService {
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  Future<Response> apiGetEvents(String? code, int pageIndex, int qty) async {
    var ur = Uri.parse(
        AppUrls.baseUrl + AppUrls.eventList + "/$code/$pageIndex/$qty");
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetGuestList(
    String? eventid,
    String? date,
  ) async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.guestList);
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.post(ur,
          body: jsonEncode({"eventIds": eventid, "checkInDate": date}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetUserList() async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.userList);
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiGetBookingDetails(bookingno) async {
    var ur =
        Uri.parse(AppUrls.baseUrl + AppUrls.guestBookingDetail + "/$bookingno");
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.post(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

  Future<Response> apiCreateCheckIN(
      ticketBookingNo, checkInDate, manualCheckInTag) async {
    var ur = Uri.parse(AppUrls.baseUrl + AppUrls.createCheckIn);
    var token = PreferenceUtils.getString("token");
    var eventId = PreferenceUtils.getString("eventId") ?? "";
    try {
      final response2 = await http.post(ur,
          body: jsonEncode({
            "eventIds": eventId,
            "ticketBookingNo": ticketBookingNo,
            "checkInDate": checkInDate,
            "manualCheckInTag": manualCheckInTag,
            "createdUserId": 0
          }),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }
}
