import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/controller/splashController.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';

import '../../utils/app_urls.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              controller.image,
              height: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppUrls.appName,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppTheme.primaryColor),
            ),
             SizedBox(
              height: 20,
            ),
            Text(
              "Organiser",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22)
            )
          ],
        ),
      ),
    );
  }
}
