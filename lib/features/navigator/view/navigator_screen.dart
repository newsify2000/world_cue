import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/features/bookmark/view/bookmark_screen.dart';
import 'package:world_cue/features/home/view/home_screen.dart';
import 'package:world_cue/features/navigator/view/app_drawer.dart';
import 'package:world_cue/features/trending_news/views/trending_news_screen.dart';
import 'package:world_cue/generated/l10n.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late final PageController _pageController;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _pages = [
      HomeScreen(onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer()),
      TrendingNewsScreen(),
      BookmarkScreen(
        onBackClick: () {
          setState(() => _selectedIndex = 0);
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      extendBody: true,
      drawer: AppDrawer(
        onCloseDrawer: () => _scaffoldKey.currentState?.closeDrawer(),
      ),
      drawerEnableOpenDragGesture: _selectedIndex == 0,
      drawerEdgeDragWidth: screenWidth(percentage: 20),
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: _pages,
      ),

      // 👇 Bottom Nav
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 20.h,
          left: screenWidth(percentage: 15),
          right: screenWidth(percentage: 15),
        ),
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: appColorScheme(
            context,
          ).onPrimaryContainer.withValues(alpha: 0.1),
        ),
        child: Row(
          children: [
            _buildNavItem(S.of(context).home, Icons.home_rounded, 0),
            _buildNavItem("Trending", Icons.trending_up_rounded, 1),
            // 👈 New tab
            _buildNavItem(S.of(context).bookmark, Icons.bookmark_rounded, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, int index) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          );
        },
        behavior: HitTestBehavior.translucent,
        child:
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 20.w,
                    color: isSelected
                        ? appColorScheme(context).onPrimaryContainer
                        : Colors.grey,
                  ),
                  boxH4(),
                  Text(
                    title,
                    style: context.labelStyle.copyWith(
                      color: isSelected
                          ? appColorScheme(context).onPrimaryContainer
                          : appColorScheme(context).tertiaryContainer,
                    ),
                  ),
                ],
              ),
            ).paddingOnly(
              left: index == 0 ? 16.w : 0,
              right: index == 2 ? 16.w : 0,
            ),
      ),
    );
  }
}
