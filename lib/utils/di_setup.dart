import 'package:get/get.dart';
import 'package:world_cue/controllers/login_controller.dart';
import 'package:world_cue/controllers/bookmark_controller.dart';
import 'package:world_cue/controllers/home_controller.dart';
import 'package:world_cue/controllers/news_search_controller.dart';

class DISetup {
  static void setup() {
    ///Controllers
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NewsSearchController());
    Get.lazyPut(() => BookmarkController());
  }
}
