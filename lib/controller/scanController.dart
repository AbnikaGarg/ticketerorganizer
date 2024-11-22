import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/model/VendorListModel.dart';

import '../components/dialogs.dart';
import '../model/GuestListNewModel.dart';
import '../model/eventModel.dart';
import '../service/event_repo.dart';
import '../service/shared_pref.dart';
import '../view/home/Selectprofile.dart';

class ScanController extends GetxController {
  final parameters = Get.parameters;
  String bookingNo = "";
  String checkinid = "";
  @override
  void onInit() {
    super.onInit();
    if (parameters.isNotEmpty && parameters != null) {
      bookingNo = parameters["data"].toString();
      checkinid = parameters["checkinid"].toString();
      getData();
      update();
    }
  }

  final service = EventService();
  bool isLoaded = false;
  List bookingDetails = [];
  void getData() async {
    bookingDetails.clear();
    service.apiGetBookingDetails(bookingNo).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);

          bookingDetails.add(decodedData);

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoaded = true;
          update();
          break;
      }
    });
  }

  // {"status":1,"message":"Checkin response","data":
  // [{"eventId":0,"newBookingNo":"BN07247ZHM43C2WGA_1_1","checkInDate":null,
  // "manualCheckInTag":false,"manualCheckOutTag":false,"ticketName":"New","haveAddOnTag":false,
  // "addons":null,"checkInExist":false,"firstName":"Softel Solutions","lastName":"","email":"btioffice@softelsystems.com","mobile":null
  // ,"errorCode":1,"errorDesc":"Checkin response"}]}
  bool checkedin = false;
  void submitCheckin(ticketBookingNo, checkInDate, manualCheckInTag) async {
    DialogHelper.showLoading();
    // DialogHelper.showError("Invalid Credentails");
    service
        .apiCreateCheckIN(ticketBookingNo, checkInDate, manualCheckInTag)
        .then((value) {
      print(value.data);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          checkedin = true;
          update();
          var data2 = jsonDecode(value.data);

          if (data2["status"].toString() == "1") {
            DialogHelper.showErroDialog(description: "Checked In Successfully");
            print(data2);
          } else {
            DialogHelper.showErroRedDialog(description: "Already Checked In");
            print(data2);
          }
          break;
        case 1:
          DialogHelper.showError("No Internet");
          break;
        default:
          DialogHelper.showError("Something went wrong");
          break;
      }
    });
  }
}
