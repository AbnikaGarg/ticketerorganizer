import 'dart:async';
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

class SelectProfileController extends GetxController {
  @override
  void onInit() {
    
    super.onInit();
    Timer(const Duration(seconds: 2), () {
    getvendorList();
    });
  }

  final service = EventService();

  List<VendorListModel> userList = [];

  bool isLoadedEvents = false;
  bool isLoadedGuests = false;
  bool isLoadedVendor = false;

  List<VendorListModel> vendorList = [];

  void getvendorList() async {
    userList.clear();
    service.apiGetUserList().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedVendor = true;
          final decodedData = jsonDecode(value.data);

          userList.add(VendorListModel.fromJson(decodedData));
          final rawJson = PreferenceUtils.getString('vendorProfile') ?? '';
          //vendorId

          if (rawJson != '') { final res = json.decode(rawJson);
            int index = userList.first.data!.indexWhere((element) =>
                element.vendorId.toString() == res["vendorId"].toString());
            userList.first.data![index].isSelected = true;
          }
          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoadedVendor = true;
          update();
          break;
      }
    });
  }

  selectVendor(response) {
        PreferenceUtils().remove("eventId");
      PreferenceUtils().remove("eventname");
    PreferenceUtils.setString("vendorProfile", json.encode(response.toJson()));
    DialogHelper.showErroDialog(description: "Oraniser Selected");
    Get.offAllNamed("/");
  }
}
