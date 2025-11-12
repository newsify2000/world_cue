import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/navigation/navigation.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/utils/app_data.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/news/view/news_search_screen.dart';
import 'package:world_cue/features/profile/view/profile_screen.dart';
import 'package:world_cue/generated/l10n.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onCloseDrawer;

  const AppDrawer({super.key, this.onCloseDrawer});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Drawer(
      child: Column(
        children: [
          boxH48(),
          searchView(context).paddingOnly(top: 16.h),
          boxH16(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(S.of(context).categories, style: context.titleBoldStyle),
                ),
                ...newsCategories.map((categoryMap) {
                  return ListTile(
                    leading: Icon(Icons.label_outline),
                    title: Text(categoryMap["label"] ?? "", style: context.bodyStyle),
                    onTap: () {
                      Get.back(); // close drawer
                      controller.updateCategory(categoryMap["slug"] ?? "breaking-news");
                    },
                  );
                }),
              ],
            ),
          ),
          profileSection(context).paddingAll(16.w).paddingOnly(bottom: 8.h),
        ],
      ),
    );
  }

  Widget profileSection(BuildContext context) {
    var profileUrl = SharedPref.getString(SharedPrefConstants.userImage);
    var name = SharedPref.getString(SharedPrefConstants.userName) ?? '';
    var parts = name.trim().split(RegExp(r'\s+')); // split by any whitespace
    var firstName = parts.isNotEmpty ? parts[0] : '';
    var lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    var email = SharedPref.getString(SharedPrefConstants.userEmail);
    return GestureDetector(
      onTap: () {
        moveTo(context, ProfileScreen());
        onCloseDrawer?.call();
      },
      child: Hero(
        tag:"profile_container",
        child: Container(
          decoration: BoxDecoration(
            color: appColorScheme(context).onPrimaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                profileUrl ??
                    "https://avatar.iran.liara.run/username?username=$firstName+$lastName",
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            title: Text(name, style: context.titleBoldStyle),
            subtitle: Text(email ?? "", style: context.labelStyle),
          ),
        ),
      ),
    );
  }

  Widget searchView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsSearchScreen());
        onCloseDrawer?.call();
      },
      child: Hero(
        tag:"search_container",
        child: Container(
          margin: padOnly(left: 16.w, right: 16.w),
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColorScheme(context).onPrimaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            children: [
              boxW16(),
              Icon(
                Icons.search_rounded,
                color: appColorScheme(context).onPrimaryContainer,
              ),
              boxW8(),
              Text(S.of(context).searchNews, style: context.bodyMediumStyle),
            ],
          ),
        ),
      ),
    );
  }
}
