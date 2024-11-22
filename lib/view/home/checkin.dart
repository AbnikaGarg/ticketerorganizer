import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';
import 'package:ticketerorganisers/view/home/atteneeDetails.dart';

import '../../components/input_field.dart';
import '../../controller/homepageController.dart';
import '../../service/shared_pref.dart';
import 'qr_checkin.dart';

class CheckIN extends StatelessWidget {
  const CheckIN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PreferenceUtils.getString('eventId') == ""
          ? Container()
          : Container(
              padding: const EdgeInsets.all(2),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppTheme.primaryColor, AppTheme.primaryColor]),
                borderRadius: BorderRadius.circular(100),
              ),
              child: FloatingActionButton(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                elevation: 0,
                onPressed: () {
                  Get.toNamed("/scanqr");
                  // controller.changeTabIndex(2);
                },
                shape: RoundedRectangleBorder(
                  // side: BorderSide(width: 4, color: AppColors.purpleColor, ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    height: 24,
                    "assets/icons/scan.svg",
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
      body: GetBuilder<HomepageController>(builder: (_controller) {
        return PreferenceUtils.getString('eventId') == ""
            ? Center(child: Text("Please Select Event for Check In"))
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            //cursorColor: AppTheme.blueColor,
                            style: TextStyle(fontSize: 14),
                            onChanged: (value) {
                              _controller.searchList(value);
                            },
                            decoration: InputDecoration(
                              fillColor: AppTheme.whiteBackgroundColor,
                              filled: false,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppTheme.primaryColor,
                              ),
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              hintText: "Search your attendees",
                              hintStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.bordercolor,
                                    width: 0.6,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.bordercolor,
                                    width: 0.6,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: AppTheme.bordercolor,
                                    width: 0.6,
                                  )),
                            )),
                        // MyTextField(
                        //     preicon: Icon(Icons.search),
                        //     // textEditingController: _controller.email,

                        //     hintText: "Search your attendees",
                        //     color: const Color(0xff585A60)),
                        SizedBox(
                          height: 20,
                        ),
                        if (_controller.isLoadedGuests)
                          if (_controller.guestList2.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _controller.guestList2.length > 0
                                  ? _controller.guestList2.length
                                  : 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/manualcheckin", parameters: {
                                      "data": _controller
                                          .guestList2[index].newBookingNo!,
                                           "checkinid": _controller
                                          .guestList2[index].checkInId.toString()
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Get.theme.shadowColor)),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _controller
                                                  .guestList2[index].name!,
                                              style: Get
                                                  .theme.textTheme.bodySmall!
                                                  .copyWith(fontSize: 14),
                                            ),
                                            Text(
                                              "${_controller.guestList2[index].qty} tickets",
                                              style: Get
                                                  .theme.textTheme.labelSmall!
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/mail.svg", height: 12,),
                                            Text(
                                              "  ${_controller.guestList2[index].emailId}",
                                              style: Get.theme.textTheme
                                                  .labelSmall!
                                                  .copyWith(fontSize: 14),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ), SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                           Icon(Icons.phone_android_rounded, size: 14,),
                                            Text(
                                              "  ${_controller.guestList2[index].mobile}",
                                              style: Get.theme.textTheme
                                                  .labelSmall!
                                                  .copyWith(fontSize: 14),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                       
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${_controller.guestList2[index].newBookingNo}",
                                              style: Get.theme.textTheme
                                                  .displayMedium!
                                                  .copyWith(fontSize: 14),
                                            ),
                                            if (_controller.guestList2[index]
                                                .haveAddOnTag!)
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/icons/check.svg"),
                                                  Text(
                                                    " Add-ons",
                                                    style: Get.theme.textTheme
                                                        .labelSmall!
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                         Text(
                                              "${_controller.guestList2[index].ticketName}",
                                              style: Get
                                                  .theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: AppTheme
                                                          .primaryColor),
                                            ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          else
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No Customer Found"),
                              ),
                            )
                        else
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
