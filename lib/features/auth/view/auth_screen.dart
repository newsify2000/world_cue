import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/helper_widgets.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/auth/controller/auth_controller.dart';
import 'package:world_cue/generated/assets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
        backgroundColor: appColorScheme(context).primaryContainer,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                Assets.assetsLogin,
                fit: BoxFit.fitHeight,
                width: screenWidth(),
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  height: screenHeight(percentage: 40),
                  decoration: BoxDecoration(
                    color: appColorScheme(context).primaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // App logo
                      Center(
                        child: Image.asset(
                          Assets.assetsLogoTransparent,
                          height: 100.h,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // App name + tagline
                      Text("World Cue", style: context.headingBoldStyle),
                      SizedBox(height: 8.h),
                      Text(
                        "Real facts. No bias. Global updates\n you can trust.",
                        style: context.subtitleMediumStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),

                      Obx(
                        () => controller.isSigningIn.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              ).paddingAll(20.w)
                            : GestureDetector(
                                onTap: () {
                                  controller.signInWithGoogle();
                                },
                                child: Container(
                                  margin: padSym(
                                    horizontal: 24.w,
                                    vertical: 16.h,
                                  ),
                                  height: 52.h,
                                  width: screenWidth(),
                                  decoration: BoxDecoration(
                                    color: appColorScheme(
                                      context,
                                    ).onPrimary,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.r),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: vector(
                                          Assets.assetsGoogleLoginButton,
                                        ),
                                      ),
                                      Text(
                                        "Continue with Google",
                                        style: context.titleBoldStyle,
                                      ).paddingOnly(right: 48.w),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}
