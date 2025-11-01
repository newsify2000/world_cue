import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/presentation/module/bookmark/bookmark_screen.dart';
import 'package:world_cue/presentation/module/home/screens/home_screen.dart';
import 'package:world_cue/presentation/module/home/widgets/app_drawer.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';

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
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: _selectedIndex == 0,
      drawerEdgeDragWidth: screenWidth(percentage: 20),
      body: PageView(
        controller: _pageController,
        physics: (_selectedIndex == 0)
            ? const ClampingScrollPhysics()
            : (_selectedIndex == _pages.length - 1)
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: _pages,
      ),

      // 👇 Bottom Nav
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 20.h,
          left: screenWidth(percentage: 25),
          right: screenWidth(percentage: 25),
        ),
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: Colors.white.withValues(alpha: 0.1),
        ),
        child: Row(
          children: [
            _buildNavItem("Home", Icons.home_rounded, 0),
            _buildNavItem("Bookmark", Icons.bookmark_rounded, 1),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 20.w,
                    color: isSelected
                        ? appColorScheme(context).onPrimary
                        : Colors.grey,
                  ),
                  boxH4(),
                  Text(
                    title,
                    style: AppTextTheme.labelStyle.copyWith(
                      color: isSelected
                          ? appColorScheme(context).onPrimary
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ).paddingOnly(
              left: index == 0 ? 16.w : 0,
              right: index == 1 ? 16.w : 0,
            ),
      ),
    );
  }
}
