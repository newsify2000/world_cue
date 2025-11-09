import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/padding_helper.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/news/view/news_search_screen.dart';

const List<String> newsCategories = [
  'General',
  'World',
  'Nation',
  'Business',
  'Technology',
  'Entertainment',
  'Sports',
  'Science',
  'Health',
];

class AppDrawer extends StatelessWidget {
  final VoidCallback? onSearchClicked;

  const AppDrawer({super.key, this.onSearchClicked});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Drawer(
      child: Column(
        children: [
          boxH48(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: searchView(context)),
              PopupMenuButton<String>(
                color: appColorScheme(context).primaryContainer,
                icon: Icon(
                  Icons.more_vert,
                  color: appColorScheme(context).onPrimaryContainer,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onSelected: (value) async {
                  if (value == 'logout') {
                    await controller.signOut();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout_rounded),
                        SizedBox(width: 8.w),
                        Text('Logout', style: context.bodyStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 16.h),
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
                  child: Text('Categories', style: context.titleBoldStyle),
                ),
                ...newsCategories.map((category) {
                  return ListTile(
                    leading: Icon(Icons.label_outline),
                    title: Text(category, style: context.bodyStyle),
                    onTap: () {
                      Get.back(); // close drawer
                      controller.updateCategory(category.toLowerCase());
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
    return Container(
      decoration: BoxDecoration(
        color: appColorScheme(context).onPrimary,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            SharedPref.getString(SharedPrefConstants.userImage)!,
          ),
        ),
        title: Text(
          SharedPref.getString(SharedPrefConstants.userName)!,
          style: context.titleBoldStyle,
        ),
        subtitle: Text(
          SharedPref.getString(SharedPrefConstants.userEmail)!,
          style: context.labelStyle,
        ),
      ),
    );
  }

  Widget searchView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsSearchScreen());
        onSearchClicked?.call();
      },
      child: Container(
        margin: padOnly(left: 16.w, right: 16.w),
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColorScheme(context).onPrimary,
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
            Text("Search News", style: context.bodyMediumStyle),
          ],
        ),
      ),
    );
  }
}
