import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticketerorganisers/components/dialogs.dart';
import '../../service/event_repo.dart';
import '../../theme/apptheme.dart';

class QrCheckin extends StatefulWidget {
  const QrCheckin({super.key});

  @override
  State<QrCheckin> createState() => _nameState();
}

class _nameState extends State<QrCheckin> {
  List changetoList(input) {
    // Step 1: Split the string by commas
    List<String> items = input.split(',');

    // Step 2: Trim whitespace from each item
    return items;
  }

  Barcode? result;
  String response = "";

  ///final controller = MobileScannerController();
  int counter = 0;
  void dialog() {
    Get.dialog(
        transitionCurve: FlippedCurve(Curves.linear),
        transitionDuration: Duration(milliseconds: 300),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Color(0x8C333335).withOpacity(0.1),
                            //       offset: Offset(1, 1),
                            //       blurRadius: 4.0,
                            //       spreadRadius: 2),
                            // ],
                            color: response == "1"
                                ? Color.fromRGBO(49, 215, 169, 1)
                                : response == "0"
                                    ? Color.fromRGBO(234, 228, 99, 1)
                                    : Color.fromRGBO(234, 99, 99, 1),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Center(
                              child: Text(
                            response == "1"
                                ? "Valid Ticket"
                                : response == "0"
                                    ? "Already Checked-in"
                                    : "Invalid Tickets",
                            style: Get.theme.textTheme.headlineMedium!.copyWith(
                                fontSize: 16,
                                color: AppTheme.whiteBackgroundColor),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   "Attendee",
                      //   style: Get.theme.textTheme.labelSmall!
                      //       .copyWith(fontSize: 16),
                      // ),
                      // SizedBox(
                      //   height: 6,
                      // ),
                      Row(
                        children: [
                            SvgPicture.asset(
                            "assets/icons/person.svg",
                            height: 16,
                            fit: BoxFit.cover,
                          ),
                          Flexible(
                            child: Text(
                              " ${bodyRes[0]["firstName"]}",
                              style: Get.theme.textTheme.headlineMedium!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ],
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
                          Flexible(
                            child: Text(
                              "  ${bodyRes[0]["email"].toString()}",
                              style: Get.theme.textTheme.labelSmall!
                                  .copyWith(fontSize: 14),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                        if (bodyRes[0]["mobile"].toString() != "null")
                      SizedBox(
                        height: 6,
                      ),
                      if (bodyRes[0]["mobile"].toString() != "null")
                        Row(
                          children: [
                            Icon(
                              Icons.phone_android_rounded,
                              size: 14,
                            ),
                            Text(
                              "  ${bodyRes[0]["mobile"]}",
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
                        children: [
                          Text(
                            "Ticket",
                            style: Get.theme.textTheme.labelSmall!
                                .copyWith(fontSize: 14),
                          ),
                          Text(
                            bodyRes[0]["ticketName"].toString(),
                            style: Get.theme.textTheme.labelSmall!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (bodyRes[0]["haveAddOnTag"])
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    changetoList(
                                            bodyRes[0]["addons"].toString())
                                        .length,
                                    (index) {
                                      return Text(
                                        " ${changetoList(bodyRes[0]["addons"].toString())[index]}",
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
                      SizedBox(
                        height: 9,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                               resetscan();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(208, 208, 208, 1),
                              ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Text(
                              "Continue",
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 14, color: AppTheme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  final service = EventService();
  var bodyRes;
  void _submit(code) {
    DialogHelper.showLoading();
    service
        .apiCreateCheckIN(
            code, DateFormat('dd-MMM-yyyy').format(DateTime.now()), false)
        .then((value) {
      print("JJj");

      DialogHelper.hideLoading();

      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.data);

          bodyRes = data2["data"];

          if (data2["status"].toString() == "1") {
            response = "1";
          } else {
            response = "0";
          }
          dialog();
          setState(() {});
          break;
        case 1:
          DialogHelper.showErroRedDialog(description: "No Internet");
          break;
        default:
          DialogHelper.showErroRedDialog(description: "Invalid Barcode");
          response = "2";
          setState(() {});
          break;
      }
    });
  }

  resetscan() async {
    if (mounted) {
      qRViewController!.resumeCamera();
      setState(() {
        counter = 0;
        result = null;
        response = "";
        bodyRes = "";
      });
    }
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qRViewController;
  // @override
  // void dispose() async {
  //   // Stop listening to lifecycle changes.

  //   super.dispose();
  //   // Finally, dispose of the controller.
  //   await controller.dispose();
  // }
  void _onQRViewCreated(QRViewController controller) {
    qRViewController = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      counter++;
      controller.pauseCamera();
      setState(() {
        result = scanData;
        if (counter == 1) {
          _submit(result!.code);
        }
      });
    });
  }

  @override
  void dispose() {
    qRViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qRViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qRViewController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "QR Scan",
        //style: AppTextStyles.headline1,
      )),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            if (response != "")
              GestureDetector(
                onTap: () {
                  dialog();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x8C333335).withOpacity(0.1),
                            offset: Offset(1, 1),
                            blurRadius: 4.0,
                            spreadRadius: 2),
                      ],
                      color: response == "1"
                          ? Color.fromRGBO(49, 215, 169, 1)
                          : response == "0"
                              ? Color.fromRGBO(234, 228, 99, 1)
                              : Color.fromRGBO(234, 99, 99, 1),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                        child: Text(
                      response == "1"
                          ? "Valid Ticket"
                          : response == "0"
                              ? "Already Checked-in"
                              : "Invalid Tickets",
                      style: Get.theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 16, color: AppTheme.whiteBackgroundColor),
                    )),
                  ),
                ),
              )
            else
              Text(
                "Align the Qr Code within\nthe frame for scan",
                style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 280,
              width: 280,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderLength: 20,
                    borderColor: AppTheme.primaryColor),
              ),
            ),
            // child: MobileScanner(
            //     overlayBuilder: (context, constraints) {
            //       return Container(
            //         color:i>0? AppTheme.darkTextColor:Colors.transparent,
            //       );
            //     },
            //     controller: controller,
            //     onDetect: _handleBarcode)),
            SizedBox(
              height: 30,
            ),
            if (response != "")
              GestureDetector(
                onTap: () {
                  resetscan();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(208, 208, 208, 1),
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    "Continue Scan",
                    style: Get.theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 14, color: AppTheme.primaryColor),
                  ),
                ),
              ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 22),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             "1 x ame",
            //             style: Get.theme.textTheme.labelSmall!
            //                 .copyWith(fontSize: 14),
            //           ),

            //             Text(
            //               "1 x ame",
            //               style: Get.theme.textTheme.labelSmall!
            //                   .copyWith(fontSize: 14),
            //             ),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
// {
//   "status": 0,
//   "message": "Already Scanned",
//   "data": [
//     {
//       "eventId": 0,
//       "ticketBookingNo": null,
//       "ticketDate": null,
//       "manualCheckInTag": 0,
//       "errorCode": 0,
//       "errorDesc": "Already Scanned"
//     }
//   ]
// }