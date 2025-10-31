import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/generated/assets.dart';
import 'package:world_cue/presentation/common_widgets/helper_widgets.dart';
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
      backgroundColor: appColorScheme(context).primaryContainer,
      body: Column(
        children: [
          Spacer(),
          Obx(
            () => controller.isSigningIn.value
                ? Center(child: CircularProgressIndicator()).paddingAll(20.w)
                : GestureDetector(
                    onTap: () {
                      controller.signInWithGoogle();
                    },
                    child: Container(
                      margin: padSym(horizontal: 24.w, vertical: 16.h),
                      height: 52.h,
                      width: screenWidth(),
                      decoration: BoxDecoration(
                        color: appColorScheme(context).onPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(100.r)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: vector(Assets.assetsGoogleLoginButton),
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
      ).paddingAll(16.w),
    );
  }
}
