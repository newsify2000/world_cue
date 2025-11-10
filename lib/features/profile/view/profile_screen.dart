import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/app_data.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/profile/controller/profile_controller.dart';
import 'package:world_cue/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
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
            _buildSettingsCard(context, controller),
            boxH16(),
            Text(S.of(context).other, style: context.titleMediumStyle),
            boxH16(),
            _buildOtherCard(context, controller),
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
      tag: "profile_container",
      child: Material(
        child: Container(
          padding: padSym(vertical: 16.h),
          decoration: BoxDecoration(
            color: appColorScheme(
              context,
            ).onPrimaryContainer.withValues(alpha: 0.1),
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

  Widget _buildSettingsCard(
    BuildContext context,
    ProfileController controller,
  ) {
    return Container(
      padding: padSym(vertical: 16.h),
      decoration: BoxDecoration(
        color: appColorScheme(
          context,
        ).onPrimaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          menuCard(
            context,
            Icons.language_rounded,
            S.of(context).appLanguage,
            () => _showLanguageSheet(context, controller),
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

  Widget _buildOtherCard(BuildContext context, ProfileController controller) {
    return Container(
      padding: padSym(vertical: 16.h),
      decoration: BoxDecoration(
        color: appColorScheme(
          context,
        ).onPrimaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          menuCard(
            context,
            Icons.rate_review_rounded,
            S.of(context).rateUs,
            () {
              openAppInStore(context); // implement in Utilities
            },
          ),
          menuCard(context, Icons.share_rounded, S.of(context).shareApp, () {
            shareAppLink(); // implement in Utilities
          }),
          menuCard(context, Icons.privacy_tip, S.of(context).privacyPolicy, () {
            openPrivacyPolicy(context); // implement in Utilities
          }),
          menuCard(context, Icons.gavel, S.of(context).termsConditions, () {
            openTnC(context); // implement in Utilities
          }),
          menuCard(context, Icons.logout_rounded, S.of(context).logout, () {
            _confirmLogout(context, controller);
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
  // ---------------- LANGUAGE BOTTOM SHEET ----------------
  void _showLanguageSheet(BuildContext context, ProfileController controller) {
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
              child: Text(
                S.of(context).selectTheme,
                style: context.titleMediumStyle,
              ),
            ),
            boxH16(),
            ListTile(
              leading: const Icon(Icons.light_mode_rounded),
              title: Text(S.of(context).light, style: context.bodyMediumStyle),
              onTap: () {
                SharedPref.setString("theme", "light");
                Get.changeThemeMode(ThemeMode.light);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_rounded),
              title: Text(S.of(context).dark, style: context.bodyMediumStyle),
              onTap: () {
                SharedPref.setString("theme", "dark");
                Get.changeThemeMode(ThemeMode.dark);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_brightness_rounded),
              title: Text(
                S.of(context).systemDefault,
                style: context.bodyMediumStyle,
              ),
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
  void _confirmLogout(BuildContext context, ProfileController controller) {
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
            onPressed: () {
              controller.logout();
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
