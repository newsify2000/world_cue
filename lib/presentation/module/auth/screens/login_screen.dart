import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:world_cue/generated/assets.dart';
import 'package:world_cue/presentation/common_widgets/padding_helper.dart';
import 'package:world_cue/presentation/module/auth/controller/login_controller.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    final List<String> imageUrls = [
      'https://picsum.photos/id/237/600/900',
      'https://picsum.photos/id/238/600/900',
      'https://picsum.photos/id/239/600/900',
      'https://picsum.photos/id/240/600/900',
    ];

    return Scaffold(
      body: Stack(
        children: [
          /// Background carousel
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                height: screenHeight(percentage: 60),
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
              ),
              items: imageUrls.map((image) {
                return Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: screenWidth(),
                  alignment: Alignment.center,
                );
              }).toList(),
            ),
          ),

          /// Bottom container with login UI
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: screenHeight(percentage: 50),
              decoration: BoxDecoration(
                color: appColorScheme(context).primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Image.asset(
                      Assets.assetsLogoTransparent,
                      width: 120.w,
                      height: 120.w,
                    ),
                    Text(
                      "Welcome to",
                      style: AppTextTheme.displayBoldStyle.copyWith(
                        color: appColorScheme(context).onPrimary,
                      ),
                    ),
                    Text(
                      "World Cue",
                      style: AppTextTheme.headingBoldStyle.copyWith(
                        color: appColorScheme(context).error,
                      ),
                    ),
                    Text(
                      "Real facts. No bias. Global updates you can trust.",
                      style: AppTextTheme.titleMediumStyle.copyWith(
                        color: appColorScheme(context).onPrimary,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    /// Google Sign-In button
                    Obx(() {
                      return GestureDetector(
                        onTap: controller.isSigningIn.value
                            ? null
                            : controller.signInWithGoogle,
                        child: Container(
                          margin: padSym(horizontal: 48.w),
                          padding:
                          padSym(vertical: 8.h, horizontal: 24.w),
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: appColorScheme(context).onPrimary,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.isSigningIn.value)
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: appColorScheme(context).primary,
                                  ),
                                )
                              else ...[
                                SvgPicture.asset(
                                    Assets.assetsGoogleLoginButton),
                                SizedBox(width: 4.w),
                                Text(
                                  "Continue with Google",
                                  style: AppTextTheme.subtitleBoldStyle,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),

                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => log('Read Privacy Policy tapped'),
                        child: Text(
                          'Read Privacy Policy',
                          style: TextStyle(
                            color: appColorScheme(context).onPrimary,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: appColorScheme(context).onPrimary,
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
