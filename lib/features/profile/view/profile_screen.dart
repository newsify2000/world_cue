import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/auth/view/auth_screen.dart';
import 'package:world_cue/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileUrl = SharedPref.getString(SharedPrefConstants.userImage);
    final name = SharedPref.getString(SharedPrefConstants.userName);
    final firstName = name?.split(" ").first ?? "";
    final lastName = name?.split(" ").length == 2 ? name!.split(" ")[1] : "";
    final email = SharedPref.getString(SharedPrefConstants.userEmail);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(S.of(context).profile, style: context.titleBoldStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(
              context,
              profileUrl,
              firstName,
              lastName,
              name,
              email,
            ),
            boxH16(),
            Text(S.of(context).appSettings, style: context.titleMediumStyle),
            boxH16(),
            _buildSettingsCard(context),
            boxH16(),
            Text(S.of(context).other, style: context.titleMediumStyle),
            boxH16(),
            _buildOtherCard(context),
          ],
        ).paddingAll(16.w),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    String? url,
    String firstName,
    String lastName,
    String? name,
    String? email,
  ) {
    return Hero(
      tag:"profile_container",
      child: Material(
        child: Container(
          padding: padSym(vertical: 16.h),
          decoration: BoxDecoration(
            color: appColorScheme(context).onPrimary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 32.r,
              backgroundImage: NetworkImage(
                url ??
                    "https://avatar.iran.liara.run/username?username=$firstName+$lastName",
              ),
            ),
            title: Text(name ?? "", style: context.titleBoldStyle),
            subtitle: Text(email ?? "", style: context.labelStyle),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Container(
      padding: padSym(vertical: 16.h),
      decoration: BoxDecoration(
        color: appColorScheme(context).onPrimary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          menuCard(
            context,
            Icons.language_rounded,
            S.of(context).appLanguage,
            () => _showLanguageSheet(context),
          ),
          menuCard(
            context,
            Icons.light_mode_rounded,
            S.of(context).appTheme,
            () => _showThemeSheet(context),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCard(BuildContext context) {
    return Container(
      padding: padSym(vertical: 16.h),
      decoration: BoxDecoration(
        color: appColorScheme(context).onPrimary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          menuCard(context, Icons.rate_review_rounded, S.of(context).rateUs, () {
            Utilities.openAppInStore(); // implement in Utilities
          }),
          menuCard(context, Icons.share_rounded, S.of(context).shareApp, () {
            Utilities.shareAppLink(); // implement in Utilities
          }),
          menuCard(context, Icons.logout_rounded, S.of(context).logout, () {
            _confirmLogout(context);
          }, isLast: true),
        ],
      ),
    );
  }

  Widget menuCard(
    BuildContext context,
    IconData icon,
    String title,
    Function onTap, {
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(8.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon),
              boxW16(),
              Expanded(child: Text(title, style: context.bodyStyle)),
              Icon(Icons.arrow_forward_ios_rounded, size: 16.sp),
            ],
          ),
          if (!isLast) Divider().paddingSymmetric(vertical: 4.h),
        ],
      ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
    );
  }

  // ---------------- LANGUAGE BOTTOM SHEET ----------------
  void _showLanguageSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: padAll(value: 16.w),
        decoration: BoxDecoration(
          color: appColorScheme(context).onPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Wrap(
          children: [
            Center(
              child: Text(S.of(context).selectLanguage, style: context.titleMediumStyle),
            ),
            boxH16(),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("English"),
              onTap: () {
                SharedPref.setString("language", "en");
                S.load(const Locale('en'));
                Get.back();
                Get.updateLocale(const Locale('en'));
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("हिन्दी"),
              onTap: () {
                SharedPref.setString("language", "hi");
                S.load(const Locale('hi'));
                Get.back();
                Get.updateLocale(const Locale('hi'));
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- THEME BOTTOM SHEET ----------------
  void _showThemeSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: padAll(value: 16.w),
        decoration: BoxDecoration(
          color: appColorScheme(context).onPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Wrap(
          children: [
            Center(
              child: Text(S.of(context).selectTheme, style: context.titleMediumStyle),
            ),
            boxH16(),
            ListTile(
              leading: const Icon(Icons.light_mode_rounded),
              title:  Text(S.of(context).light,style: context.bodyMediumStyle),
              onTap: () {
                SharedPref.setString("theme", "light");
                Get.changeThemeMode(ThemeMode.light);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_rounded),
              title:  Text(S.of(context).dark,style: context.bodyMediumStyle),
              onTap: () {
                SharedPref.setString("theme", "dark");
                Get.changeThemeMode(ThemeMode.dark);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_brightness_rounded),
              title:  Text(S.of(context).systemDefault,style: context.bodyMediumStyle,),
              onTap: () {
                SharedPref.setString("theme", "system");
                Get.changeThemeMode(ThemeMode.system);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- LOGOUT CONFIRMATION ----------------
  void _confirmLogout(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(S.of(context).logout, style: context.titleBoldStyle),
        content: Text(
          S.of(context).areYouSureYouWantToLogout,
          style: context.bodyStyle,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(S.of(context).cancel, style: context.bodyStyle),
          ),
          TextButton(
            onPressed: () async {
              await SharedPref.deleteAll();
              Get.to(() => AuthScreen());
            },
            child: Text(
              S.of(context).logout,
              style: context.bodyBoldStyle.copyWith(
                color: appColorScheme(context).error,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

class Utilities {
  static void openAppInStore() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.worldcue.app";
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  static void shareAppLink() {
    Share.share(
      "Check out this app: https://play.google.com/store/apps/details?id=com.worldcue.app",
    );
  }
}
