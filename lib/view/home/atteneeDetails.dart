import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticketerorganisers/controller/scanController.dart';
import 'package:ticketerorganisers/model/GuestListNewModel.dart';

import '../../theme/apptheme.dart';

class AttdendeeDetails extends StatelessWidget {
  const AttdendeeDetails({super.key});
  List changetoList(input) {
    // Step 1: Split the string by commas
    List<String> items = input.split(',');

    // Step 2: Trim whitespace from each item
    return items;
    print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Ticket",
            //style: AppTextStyles.headline1,
          )),
      body: GetBuilder<ScanController>(builder: (_controller) {
        return _controller.isLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attendee",
                              style: Get.theme.textTheme.labelSmall!
                                  .copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "${_controller.bookingDetails[0]["data"][0]["firstName"]}",
                              style: Get.theme.textTheme.headlineMedium!
                                  .copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/mail.svg",
                                  height: 12,
                                ),
                                Text(
                                  "  ${_controller.bookingDetails[0]["data"][0]["email"]}",
                                  style: Get.theme.textTheme.labelSmall!
                                      .copyWith(fontSize: 14),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            if (_controller.bookingDetails[0]["data"][0]
                                    ["mobile"] !=
                                null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone_android_rounded,
                                    size: 14,
                                  ),
                                  Text(
                                    "  ${_controller.bookingDetails[0]["data"][0]["mobile"]}",
                                    style: Get.theme.textTheme.labelSmall!
                                        .copyWith(fontSize: 14),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 20,
                            ),
                                   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Booking ID: ",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      "${_controller.bookingDetails[0]["data"][0]["newBookingNo"]}",
                                      style: Get.theme.textTheme.labelSmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Purchase date: ",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      "${_controller.bookingDetails[0]["data"][0]["bookingDate"]}",
                                      style: Get.theme.textTheme.labelSmall!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Method: ",
                                          style: Get.theme.textTheme.bodySmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text(
                                          "${_controller.bookingDetails[0]["data"][0]["paymode"]}",
                                          style: Get.theme.textTheme.labelSmall!
                                              .copyWith(fontSize: 14),
                                              maxLines: 1,
                                              
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Event Name: ",
                                          style: Get.theme.textTheme.bodySmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text(
                                          "${_controller.bookingDetails[0]["data"][0]["eventName"]}",
                                          style: Get.theme.textTheme.labelSmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                           ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: AppTheme.lightprimaryColor),
                        child: Center(
                          child: Text(
                            "Ticket Summary",
                            style: Get.theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    "Ticket: ",
                                    style: Get.theme.textTheme.labelSmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "1 x ${_controller.bookingDetails[0]["data"][0]["ticketName"]}",
                                    style: Get.theme.textTheme.labelSmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_controller.bookingDetails[0]["data"][0]
                          ["haveAddOnTag"])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add ons",
                                    style: Get.theme.textTheme.labelSmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      changetoList(_controller.bookingDetails[0]
                                                  ["data"][0]["addons"]
                                              .toString())
                                          .length,
                                      (index) {
                                        return Text(
                                          " ${changetoList(_controller.bookingDetails[0]["data"][0]["addons"].toString())[index]}",
                                          style: Get.theme.textTheme.labelSmall!
                                              .copyWith(fontSize: 14),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 30,
                      ),
                      if(!_controller.bookingDetails[0]["data"][0]["checkInExist"])
                      if(!_controller.checkedin)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _controller.submitCheckin(
                                _controller.bookingDetails[0]["data"][0]["newBookingNo"].toString(), DateFormat('dd-MMM-yyyy').format(DateTime.now()), true);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(208, 208, 208, 1),
                              ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            child: Center(
                              child: Text(
                                "Check-in",
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 14, color: AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CupertinoActivityIndicator(),
              );
      }),
    );
  }
}
