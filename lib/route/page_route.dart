import 'package:get/get.dart';
import 'package:ticketerorganisers/view/auth/login.dart';
import 'package:ticketerorganisers/view/home/atteneeDetails.dart';
import 'package:ticketerorganisers/view/home/qr_checkin.dart';

import 'package:ticketerorganisers/view/splash/splash_screen.dart';

import '../bindings/auth_bindings.dart';
import '../bindings/rootbindings.dart';
import '../bindings/scan_bindings.dart';
import '../bindings/splash_bindings.dart';
import '../view/home/bottombar.dart';

class AppPage {
  static var list = [
    GetPage(
        name: "/splash",
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: "/", page: () =>  DashboardScreen(), binding: RootBinding()),
    GetPage(
        name: "/scanqr",
        page: () => QrCheckin(),
        binding: ScanBindings()),
         GetPage(
        name: "/manualcheckin",
        page: () => AttdendeeDetails(),
        binding: ScanBindings()),
    GetPage(
      name: "/login",
      page: () => Login(),
      fullscreenDialog: true,
      binding: AuthBindings(),
    ),
    //  GetPage(
    //   name: "/checkout",
    //   page: () => CheckOut(),

    // ),
    // GetPage(
    //   name: "/webview",
    //   page: () => webView(
    //     url: '',
    //     type: '',
    //   ),
    // ),
    // GetPage(
    //     name: "/eventDetail/:id",
    //     page: () => EventDetails(),
    //     binding: EventBindings()),
    //      GetPage(
    //     name: "/vendorDeatils",
    //     page: () => VendorDetails(),
    //     binding: VendorBinding()),
    // GetPage(
    //   name: "/ticketDetails/:id",
    //   page: () => TicketDetails(),
    //   binding: TicketDetailsBinding(),
    //   transition: Transition.zoom,
    //   transitionDuration: Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    // ),
  ];
}
