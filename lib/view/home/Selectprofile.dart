import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ticketerorganisers/controller/selectProfileController.dart';
import 'package:ticketerorganisers/model/GuestListNewModel.dart';

import '../../controller/homepageController.dart';
import '../../theme/apptheme.dart';
import 'components/drawer.dart';

class SelectProfilePage extends StatelessWidget {
  SelectProfilePage({
    super.key,
  });
  final aaa = Get.put<SelectProfileController>(SelectProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: NavBarDraerr(),
      appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Select a profile",
            //style: AppTextStyles.headline1,
          )),
      body: GetBuilder<SelectProfileController>(builder: (controller) {
        return controller.isLoadedVendor
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      if (controller.userList.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.userList.first.data!.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                // if (!controller.userList.first.data![index]
                                //     .isSelected!) {
                                  controller.selectVendor(
                                      controller.userList.first.data![index]);
                              //  }
                              },
                              child: Row(
                                children: [
                                  if (controller.userList.first.data![index]
                                          .logoImage !=
                                      "")
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "${controller.userList.first.data![index].logoImagePath.toString()}${controller.userList.first.data![index].logoImage.toString()}",
                                              )),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    )
                                  else
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.userList.first.data![index].name.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "${controller.userList.first.data![index].email.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    ),
                                  ),
                                  if (!controller.userList.first.data![index]
                                      .isSelected!)
                                    Text(
                                      "Select",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              color: AppTheme.primaryColor),
                                    )
                                  else
                                    Text(
                                      "Selected",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              color: Colors.green),
                                    )
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Container(
                            child: Text("No Record found"),
                          ),
                        )
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
