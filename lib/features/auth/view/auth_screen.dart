import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/app_data.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/url_launcher.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/glass_back_button.dart';
import 'package:world_cue/core/widgets/helper_widgets.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/auth/controller/auth_controller.dart';
import 'package:world_cue/generated/assets.dart';
import 'package:world_cue/generated/l10n.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: appColorScheme(context).primaryContainer,
      body: Stack(
        children: [
          // ---- Background Image ----
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

          // ---- Bottom Content ----
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
                      S.of(context).realFactsNoBiasGlobalUpdatesnYouCanTrust,
                      style: context.subtitleMediumStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),

                    // ---- Google Login Button ----
                    Obx(
                      () => controller.isSigningIn.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            ).paddingAll(20.w)
                          : GestureDetector(
                              onTap: controller.signInWithGoogle,
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
                                      S.of(context).continueWithGoogle,
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

          // ---- Top More Button ----
          Positioned(
            top: 64.h,
            right: 16.w,
            child: GlassButton(
              onTap: () => _showMoreOptions(context,controller),
              icon: Icons.more_vert_rounded,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------
  // ---------------------  MORE OPTIONS SHEET --------------------------
  // --------------------------------------------------------------------
  void _showMoreOptions(BuildContext context,AuthController controller) {
    Get.bottomSheet(
      Container(
        padding: padAll(value: 16.w),
        decoration: BoxDecoration(
          color: appColorScheme(context).onPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Wrap(
          children: [
            // ---- Privacy Policy ----
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(
                S.of(context).readPrivacyPolicy,
                style: context.bodyMediumStyle,
              ),
              onTap: () async {
                UrlLauncher.urlLauncher(
                  "https://www.worldcue.news/privacy-policy",
                  context,
                );

                Get.back();
              },
            ),

            // ---- Change Language ----
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(
                S.of(context).appLanguage,
                style: context.bodyMediumStyle,
              ),
              onTap: () {
                Get.back();
                _showLanguageSheet(context,controller);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------
  // ---------------------- LANGUAGE BOTTOM SHEET -----------------------
  // --------------------------------------------------------------------
  void _showLanguageSheet(BuildContext context,AuthController controller) {
    Get.bottomSheet(
      // Use Column instead of Wrap to manage the fixed header and scrolling list
      Container(
        padding: padAll(value: 16.w),
        decoration: BoxDecoration(
          color: appColorScheme(context).onPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        // Change from Wrap to Column
        child: Column(
          // Important: Constrain the height of the entire bottom sheet
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                S.of(context).selectLanguage,
                style: context.titleMediumStyle,
              ),
            ),
            boxH16(),
            // Constrain the height of the ListView.builder
            ConstrainedBox(
              constraints: BoxConstraints(
                // Set a maximum height (e.g., 50% of screen height)
                maxHeight: 0.45.sh,
              ),
              child: ListView.builder(
                // Use a proper List View inside the constrained box
                shrinkWrap: true,
                // This is key when in a Column/constrained space
                itemCount: appLanguages.length,
                itemBuilder: (BuildContext context, int index) {
                  // Assuming 'appLanguages' is accessible (it's defined in app_data.dart based on imports)
                  // The type casting 'as String' is safe if your data is structured as expected.
                  final language = appLanguages[index];
                  final code = language["code"] as String;
                  final label = language["label"] as String;

                  return ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(label),
                    onTap: () {
                      controller.setAppLanguage(code);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
