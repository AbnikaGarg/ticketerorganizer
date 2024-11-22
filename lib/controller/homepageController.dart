import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticketerorganisers/model/VendorListModel.dart';
import '../components/dialogs.dart';
import '../model/GuestListNewModel.dart';
import '../model/eventModel.dart';
import '../service/event_repo.dart';
import '../service/shared_pref.dart';
import '../view/home/Selectprofile.dart';
import '../view/home/components/events.dart';

class HomepageController extends GetxController {
  var tabIndex = 0;
  final parameters = Get.parameters;
  void changeTabIndex(int index) {
    tabIndex = index;
    debugPrint(index.toString());
    if (index == 0 && !isLoadedGuests) {
      if (PreferenceUtils.getString('eventId') != "" &&
          PreferenceUtils.getString('eventId') != null) {
        getCheckGuestList();
      }
    }
    update();
  }

  var vendorDetails;
  final searchController = TextEditingController();
  FocusNode focus = FocusNode();
  @override
  void onInit() {
    if (parameters.isNotEmpty) {
      tabIndex = int.parse(parameters["pageIndex"].toString());
      update();
    }
    final rawJson = PreferenceUtils.getString('vendorProfile') ?? '';
    //vendorId

    if (rawJson != '') {
      final res = json.decode(rawJson);
      vendorDetails = res;

      update();
      getEvents();
    }
    if (PreferenceUtils.getString('eventId') == "" ||
        PreferenceUtils.getString('eventId') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BottomSheetClass.openShareButtomSheet();
      });
    }
    else{
      getCheckGuestList();
    }
    //   res["vendorId"].toString();
    //
    // } else {
    //   getvendorList();
    //   Get.to(SelectProfilePage());
    // }

    super.onInit();
  }

  final service = EventService();
  List<EventModelData> eventList = [];
  List<GuestListNewModel> guestList = [];
  List<GuestListNewModelData> guestList2 = [];
  List<VendorListModel> userList = [];

  bool isLoadedEvents = false;
  bool isLoadedGuests = false;
  bool isLoadedVendor = false;

  void getEvents() async {
    eventList.clear();
    service.apiGetEvents(vendorDetails["vendorCode"], 1, 100).then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedEvents = true;
          final decodedData = jsonDecode(value.data);
          List<EventModel> EventList = [];
          EventList.add(EventModel.fromJson(decodedData));

          eventList = EventList.first.data!;
          var eventId = PreferenceUtils.getString('eventId') ?? "";
          var eventname = PreferenceUtils.getString('eventname') ?? "";
          //vendorId

          if (eventId != '') {
            evendIds = eventId.split(',');
            // int index = eventList.indexWhere(
            //     (element) => element.eventId.toString() == eventId.toString());
            // eventList[index].isSelected = true;
          }
           if (eventname != '') {
            eventNameList = eventname.split(',');
            // int index = eventList.indexWhere(
            //     (element) => element.eventId.toString() == eventId.toString());
            // eventList[index].isSelected = true;
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
          isLoadedEvents = true;
          update();
          break;
      }
    });
  }

  void getCheckGuestList() async {
    guestList.clear();
    service
        .apiGetGuestList(PreferenceUtils.getString("eventId"), DateFormat('dd-MM-yyyy').format(DateTime.now()))
        .then((value) {
      switch (value.statusCode) {
        case 200:
          isLoadedGuests = true;
          final decodedData = jsonDecode(value.data);

          guestList.add(GuestListNewModel.fromJson(decodedData));
          if (guestList.isNotEmpty) {
            guestList2 = guestList.first.data!;
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
          isLoadedGuests = true;
          guestList.clear();
          guestList2.clear();

          update();
          break;
      }
    });
  }

  searchList(String query) async {
    if (query.isNotEmpty) {
      guestList2 = guestList.first.data!
          .where((elem) =>
              elem.name!.toLowerCase().contains(query) ||
              elem.bookingNo!.toLowerCase().contains(query) ||
              elem.mobile!.toLowerCase().contains(query) ||
              elem.emailId!.toLowerCase().contains(query) ||
              elem.ticketName!.toLowerCase().contains(query))
          .toList();
    } else {
      guestList2 = guestList.first.data!;
    }
    update();
  }

  List evendIds = [];
  List eventNameList = [];

  selectEvent(eventid, eventname) {
    // if (eventid != '') {
    //   int index = eventList.indexWhere(
    //       (element) => element.eventId.toString() == eventid.toString());
    //   eventList[index].isSelected = true;
    // }
    if (eventid != '') {
      // for (var event in eventList) {
      //   event.isSelected = event.eventId.toString() == eventid.toString();
      // }
      if (evendIds.contains(eventid)) {
        evendIds.remove(eventid);
       
      } else {
        evendIds.add(eventid);
           DialogHelper.showErroDialog(description: "Event Selected");
      }
    }
    if (eventname != "") {
      if (eventNameList.contains(eventname)) {
        eventNameList.remove(eventname);
      } else {
        eventNameList.add(eventname);
      }
    }
    String resultEventId = evendIds.join(',');
    String resultEventName = eventNameList.join(',');
    print(resultEventName);
    PreferenceUtils.setString("eventId", resultEventId.toString());
    PreferenceUtils.setString("eventname", resultEventName.toString());

    //Get.back();
  
    isLoadedGuests = false;
    update();
    getCheckGuestList();
  }

  openVendor() {
    Get.back();

    Get.to(SelectProfilePage());
  }
}
