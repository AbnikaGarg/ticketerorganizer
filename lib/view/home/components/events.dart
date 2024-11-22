import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/model/eventModel.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';

import '../../../components/date_converter.dart';
import '../../../controller/homepageController.dart';

class BottomSheetClass {
  static void openShareButtomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      GetBuilder<HomepageController>(builder: (_controller) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (() {
            //  Get.back();
            if (_controller.evendIds.isEmpty) {
              Get.dialog(
                //  context: Get.context,//
                CupertinoAlertDialog(
                  title: const Text('Event'),
                  insetAnimationCurve: Curves.linear,
                  insetAnimationDuration: const Duration(milliseconds: 500),
                  content: const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Please select event first then proceed",
                    ),
                  ),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      /// This parameter indicates this action is the default,
                      /// and turns the action's text to bold text.
                      isDefaultAction: true,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                    CupertinoDialogAction(
                      /// This parameter indicates the action would perform
                      /// a destructive action such as deletion, and turns
                      /// the action's text color to red.
                      isDestructiveAction: true,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              );
            }
          }),
          child: DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.85,
              maxChildSize: 0.96,
              builder: (_, controller) {
                return Container(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: DefaultTabController(
                      length: 2,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TabBar(
                                indicatorWeight: 8,
                                dividerHeight: 1,
                                tabs: [
                                  Tab(text: 'Live Events'),
                                  Tab(text: 'Past Events'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (_controller.isLoadedEvents)
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      TabContent(
                                        data: _controller.eventList,
                                      ),
                                      Center(child: Text("No Events found"))
                                      // TabContent(data: _controller.eventList),
                                    ],
                                  ),
                                )
                              else
                                CupertinoActivityIndicator(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
              }),
        );
      }),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final List<EventModelData> data;
  var ontap;
  TabContent({required this.data, this.ontap});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView.builder(
            //controller: controller,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!data[index].isSelected!) {
                      Get.find<HomepageController>().selectEvent(
                          data[index].eventId.toString(),
                          data[index].eventName);
                    }
                  },
                  child: Row(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            value: 0.1,
                            strokeWidth: 2,
                            backgroundColor: AppTheme.homePagecolor3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryColor),
                          ),
                        ),
                        Center(
                            child: Text(
                          '1%',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                      ]),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data[index].eventName}",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "${data[index].eventType}",
                                      style: Get.theme.textTheme.displayMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "${DateConverter.formatDate(DateTime.parse(data[index].startDate.toString()))}",
                                      style: Get.theme.textTheme.displayMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (!Get.find<HomepageController>()
                                .evendIds
                                .contains(data[index].eventId.toString()))
                              Text(
                                "Select",
                                style: Get.theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 14, color: AppTheme.primaryColor),
                              )
                            else
                              Text(
                                "Selected",
                                style: Get.theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 14, color: Colors.green),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        : Center(child: Text("No Events found"));
  }
}
