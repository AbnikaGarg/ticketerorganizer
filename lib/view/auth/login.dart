import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketerorganisers/controller/authController.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';
import 'package:ticketerorganisers/view/auth/forgetpassword.dart';
import '../../components/button.dart';
import '../../components/dialogs.dart';
import '../../components/input_field.dart';
import '../../service/shared_pref.dart';
import '../../utils/app_images.dart';
import '../../utils/app_urls.dart';
import 'components/social_logins.dart';
import 'dart:io' show Platform;

class Login extends StatelessWidget {
  Login({super.key});
  final loginformKey = GlobalKey<FormState>();
  List socialLogis = [
    {
      "title": "Continue with Google",
      "logo": "assets/images/google.png",
      "webview": "google",
    },
    {
      "title": "Continue with Facebook",
      "logo": "assets/images/facebook.png",
      "webview": "facebook",
    },
    {
      "title": "Continue with Apple",
      "logo": "assets/images/apple.png",
      "webview": "apple",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///  backgroundColor: Get.theme.cardColor,
      body: GetBuilder<AuthController>(builder: (_controller) {
        return SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  Images.logo,
                  //    color: Get.theme.canvasColor,
                  height: 70,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  AppUrls.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 28),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Form(
                    key: loginformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        MyTextField(
                            preicon: SvgPicture.asset("assets/icons/mail.svg",
                                height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                            textEditingController: _controller.email,
                            validation: (value) {
                              RegExp emailValidatorRegExp = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value.trim())) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                            hintText: "yourmail@gmail.com",
                            color: const Color(0xff585A60)),
                        MyTextField(
                            isSuffixIcon: true,
                            preicon: SvgPicture.asset("assets/icons/lock.svg",
                                height: 5.h, width: 5.w, fit: BoxFit.scaleDown),
                            textEditingController: _controller.password,
                            obsecureText: !_controller.passwordLoginVisibility,
                            ontapSuffix: () {
                              _controller.showPassword();
                            },
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                            hintText: "your password",
                            color: const Color(0xff585A60)),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: CupertinoSwitch(
                                      // This bool value toggles the switch.
                                      value: _controller.isRemember,
                                      activeColor: AppTheme.primaryColor,
                                      onChanged: (bool value) {
                                        _controller.isRemeberChange();
                                        // This is called when the user toggles the switch.
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Text(" Remember Me",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0))),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(ForgetPassword());
                                },
                                child: Text("Forget Password?",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          child: Button(
                              tittle: "Sign in",
                              tap: () {
                                if (loginformKey.currentState!.validate()) {
                                  _controller.submitLogin();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "OR",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 16,
                ),
                ...List.generate(socialLogis.length, (index) {
                    if (!Platform.isIOS && index == 2) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SocialLogin(
                      assets: socialLogis[index]["logo"],
                      tittle: socialLogis[index]["title"],
                      webview: socialLogis[index]["webview"],
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don't have an account? ",
                //       style: Theme.of(context).textTheme.bodySmall,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //         // Get.to(SignUp());
                //         },
                //         child: Text("Sign up!",
                //             style:
                //                 Theme.of(context).textTheme.bodySmall!.copyWith(
                //                       color: Colors.blue,
                //                     )))
                //   ],
                // ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
