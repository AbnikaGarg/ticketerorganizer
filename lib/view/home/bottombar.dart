import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketerorganisers/view/home/home.dart';
import 'package:ticketerorganisers/view/home/profile.dart';
import '../../controller/homepageController.dart';
import '../../service/shared_pref.dart';
import '../../theme/apptheme.dart';
import 'checkin.dart';
import 'components/drawer.dart';
import 'components/events.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final _page1 = GlobalKey<NavigatorState>();
  final _page2 = GlobalKey<NavigatorState>();
  final _page3 = GlobalKey<NavigatorState>();
  final _page4 = GlobalKey<NavigatorState>();
  final c = Get.put<HomepageController>(HomepageController());
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      builder: (controller) => Scaffold(
        key: _key,
        //   backgroundColor: Colors.grey.shade100,
        drawer: NavBarDraerr(),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            iconTheme: IconThemeData(color: AppTheme.ticketBackground),
            backgroundColor: AppTheme.primaryColor,
            title: GestureDetector(
              onTap: () {
                Get.put<HomepageController>(HomepageController());
                BottomSheetClass.openShareButtomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Seedha Takeover by ",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .labelSmall!
                  //       .copyWith(
                  //           fontSize: 12,
                  //           color: AppTheme.whiteBackgroundColor),
                  // ),
                  PreferenceUtils.getString('eventId') == ""
                      ? Text(
                          "Select Event ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 14,
                                  color: AppTheme.whiteBackgroundColor),
                        )
                      : Flexible(
                          child: Text(
                            "${PreferenceUtils.getString('eventname')} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14,
                                    color: AppTheme.whiteBackgroundColor),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Icon(Icons.arrow_drop_down,
                      size: 22, color: AppTheme.whiteBackgroundColor)
                ],
              ),
            ),
            actions: [
              Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteBackgroundColor.withOpacity(0)),
                  child: Container())
            ],
          ),
        ),
        body: IndexedStack(
          index: controller.tabIndex,
          children: [
          //  HomePage(),
            //   HomePage(),
            //   Navigator(
            //   key:_page1,
            //   onGenerateRoute: (route) => MaterialPageRoute(
            //     settings: route,
            //     builder: (context) => CheckIN(),
            //   ),
            // ),
            CheckIN(),
            // Center(
            //   child: Text("Sell Tickets"),
            // ),
            Profile(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Get.theme.shadowColor.withOpacity(0.6),
                  blurRadius: 2,
                  spreadRadius: 2),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            elevation: 0,
            selectedLabelStyle: GoogleFonts.inter(
              //  color: Get.theme.cardColor,
              fontSize: 11, height: 3,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
            unselectedItemColor: Get.theme.canvasColor,
            unselectedIconTheme: IconThemeData(color: AppTheme.ligthIconcolor),
            selectedIconTheme: IconThemeData(color: AppTheme.primaryColor),
            selectedItemColor: AppTheme.primaryColor,
            unselectedLabelStyle: GoogleFonts.inter(
              //  color: Get.theme.cardColor,
              fontSize: 11,
              letterSpacing: 0, height: 3,
              fontWeight: FontWeight.w500,
            ),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              // BottomNavigationBarItem(
              //     activeIcon: SvgPicture.asset(
              //       "assets/icons/dashboard.svg",
              //       height: 18,
              //       fit: BoxFit.cover,
              //       color: AppTheme.primaryColor,
              //     ),
              //     icon: SvgPicture.asset(
              //       "assets/icons/dashboard.svg",
              //       height: 18,
              //       fit: BoxFit.cover,
              //       color: Get.theme.canvasColor,
              //     ),
              //     label: 'Dashboard'),
              // // BottomNavigationBarItem(
              // //     activeIcon: SvgPicture.asset(
              // //       "assets/icons/ticket2.svg",
              // //       height: 18,
              // //       fit: BoxFit.cover,
              // //       color: AppTheme.primaryColor,
              // //     ),
              // //     icon: SvgPicture.asset(
              // //       "assets/icons/ticket2.svg",
              // //       height: 18,
              // //       fit: BoxFit.cover,
              // //       color: Get.theme.canvasColor,
              // //     ),
              // //     label: 'Sell Tickets'),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    "assets/icons/scan.svg",
                    height: 18,
                    fit: BoxFit.cover,
                    color: AppTheme.primaryColor,
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/scan.svg",
                    height: 18,
                    fit: BoxFit.cover,
                    color: Get.theme.canvasColor,
                  ),
                  label: 'Check In'.tr),
              // BottomNavigationBarItem(
              //     activeIcon: SvgPicture.asset(
              //       "assets/icons/message.svg",
              //       height: 18,
              //       fit: BoxFit.cover,
              //       color: AppTheme.primaryColor,
              //     ),
              //     icon: SvgPicture.asset(
              //       "assets/icons/message.svg",
              //       height: 18,
              //       fit: BoxFit.cover,
              //       color: Get.theme.canvasColor,
              //     ),
              //     label: 'Tickets'),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    "assets/icons/orders.svg",
                    height: 18,
                    fit: BoxFit.cover,
                    color: AppTheme.primaryColor,
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/orders.svg",
                    height: 18,
                    fit: BoxFit.cover,
                    color: Get.theme.canvasColor,
                  ),
                  label: 'Profile')
            ],
            onTap: (val) {
              FocusScope.of(context).unfocus();
              if (val == 1) {
                _key.currentState!.openDrawer();
              } else {
                controller.changeTabIndex(val);
              }
            },
            currentIndex: controller.tabIndex,
          ),
        ),
      ),
    );
  }
}
