import 'package:get/get.dart';
import 'package:world_cue/features/auth/controller/auth_controller.dart';
import 'package:world_cue/features/bookmark/controller/bookmark_controller.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/news/controller/news_search_controller.dart';

import '../../features/profile/controller/profile_controller.dart';

class DISetup {
  static void setup() {
    ///Controllers
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NewsSearchController());
    Get.lazyPut(() => BookmarkController());
    Get.lazyPut(() => ProfileController());
  }
}
