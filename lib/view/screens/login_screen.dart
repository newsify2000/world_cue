import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/controllers/login_controller.dart';
import 'package:world_cue/generated/assets.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';
import 'package:world_cue/view/common_widgets/helper_widgets.dart';
import 'package:world_cue/view/common_widgets/padding_helper.dart';
import 'package:world_cue/view/theme/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: appColorScheme(context).surface,
      body: Scaffold(
        backgroundColor: appColorScheme(context).primaryContainer,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                Assets.assetsImg,
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
                      Text(
                        "World Cue",
                        style: AppTextTheme.headingBoldStyle.copyWith(
                          color: appColorScheme(context).onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Real facts. No bias. Global updates\n you can trust.",
                        style: AppTextTheme.subtitleMediumStyle.copyWith(
                          color: appColorScheme(context).onPrimary,
                        ),
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
                                    color: appColorScheme(context).onPrimary,
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
                                        style: AppTextTheme.titleBoldStyle,
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
      ),
    );
  }
}
