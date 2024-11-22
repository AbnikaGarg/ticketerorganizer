import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketerorganisers/controller/homepageController.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';
import 'package:ticketerorganisers/view/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/dialogs.dart';
import '../../../service/shared_pref.dart';
import '../../../utils/app_images.dart';
import '../Selectprofile.dart';

class NavBarDraerr extends StatefulWidget {
  @override
  State<NavBarDraerr> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarDraerr> {
  void dialog() {
    DialogHelper.showLoading();
    Future.delayed(Duration(milliseconds: 400), () {
      PreferenceUtils().remove("token");
      PreferenceUtils().remove("eventId");
      PreferenceUtils().remove("eventname");
      PreferenceUtils().remove("vendorProfile");

      Get.offAllNamed("/login");
    });

    //   PreferenceUtils().remove("Token");
    //    PreferenceUtils().remove("Token");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width / 1.5,
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                child: Column(
                    // Remove padding
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Select a profile",
                        style: Get.theme.textTheme.headlineLarge!
                            .copyWith(fontSize: 20),
                      ),
                      // Divider(
                      // //  color: Colors.grey[300],
                      // ),
                      SizedBox(
                        height: 30.h,
                      ),
                      if (PreferenceUtils.getString('vendorProfile') != "")
                        GestureDetector(
                          onTap: () {
                            Get.find<HomepageController>().openVendor();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border:
                                    Border.all(color: Get.theme.shadowColor)),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/switch.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                if (Get.find<HomepageController>()
                                        .vendorDetails["logoImage"] !=
                                    "")
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "${Get.find<HomepageController>().vendorDetails["logoImagePath"].toString()}${Get.find<HomepageController>().vendorDetails["logoImage"].toString()}",
                                            )),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  )
                                else
                                  Image.asset(
                                    "assets/images/br.png",
                                    height: 45,
                                  ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    "${Get.find<HomepageController>().vendorDetails["name"]}",
                                    style: Get.theme.textTheme.bodySmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 30,
                      ),
                     GestureDetector(
                        onTap: () {
                          Get.dialog(
                            //  context: Get.context,//
                            CupertinoAlertDialog(
                              title: const Text('Delete Account'),
                              insetAnimationCurve: Curves.linear,
                              insetAnimationDuration:
                                  const Duration(milliseconds: 500),
                              content: const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Are you sure you want to delete your account",
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
                                  onPressed: () async {
                                   ///  Get.find<HomepageController>().deleteAccount();
                                  },
                                  child: const Text('Continue'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: Get.theme.shadowColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 20,
                                color: AppTheme.primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Delete Account",
                                style: Get.theme.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            //  context: Get.context,//
                            CupertinoAlertDialog(
                              title: const Text('Logout'),
                              insetAnimationCurve: Curves.linear,
                              insetAnimationDuration:
                                  const Duration(milliseconds: 500),
                              content: const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Are you sure you want to logout",
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
                                    dialog();
                                  },
                                  child: const Text('Logout'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: Get.theme.shadowColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20,
                                color: AppTheme.primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logout",
                                style: Get.theme.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      )
                    ]))));
  }
}
