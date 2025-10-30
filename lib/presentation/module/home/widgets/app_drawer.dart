import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/presentation/common_widgets/padding_helper.dart';
import 'package:world_cue/presentation/module/home/controller/home_controller.dart';
import 'package:world_cue/presentation/module/search/search_screen.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';

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
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Drawer(
      backgroundColor: appColorScheme(context).primaryContainer,
      child: Column(
        children: [
          // Scrollable categories section
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'Categories',
                    style: AppTextTheme.titleBoldStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
                  ),
                ),
                ...newsCategories.map((category) {
                  return ListTile(
                    leading: Icon(
                      Icons.label_outline,
                      color: appColorScheme(context).onPrimary,
                    ),
                    title: Text(
                      category,
                      style: AppTextTheme.bodyStyle.copyWith(
                        color: appColorScheme(context).onPrimary,
                      ),
                    ),
                    onTap: () {
                      Get.back(); // close drawer
                      controller.updateCategory(category.toLowerCase());
                    },
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => const SearchScreen()),
            child: Container(
              margin: padAll(value: 24.w),
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColorScheme(context).onSecondaryContainer,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                children: [
                  boxW16(),
                  Icon(
                    Icons.search_rounded,
                    color: appColorScheme(context).onPrimary,
                  ),
                  boxW8(),
                  Text(
                    "Search News",
                    style: AppTextTheme.bodyMediumStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
