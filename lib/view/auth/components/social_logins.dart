import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/view/auth/components/web_view.dart';

import '../../../theme/apptheme.dart';

class SocialLogin extends StatelessWidget {
  final String assets;
  final String tittle;
  final String webview;
  SocialLogin({
    super.key,
    required this.assets,
    required this.tittle,
    required this.webview,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => webView(
                  url:
                      "https://apiloginv2.ticketer.sg/VendorLogin/social-login?loginfrom=$webview&returnUrl=mobile", type: webview,
                )));
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color:Get.theme.scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(211, 211, 219, 0.243),
              blurRadius: 2.0,
              spreadRadius: 2,
              offset: Offset(
                1,
                1,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: Image.asset(
                assets,
                height: 26,
                color:webview=="apple"?  Get.theme.canvasColor:null,
              ),
            ),
            Text(tittle, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
