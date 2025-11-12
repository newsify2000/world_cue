import 'package:get/get.dart';
import 'package:world_cue/core/repository/gemini_service.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/features/auth/controller/auth_controller.dart';
import 'package:world_cue/features/bookmark/controller/bookmark_controller.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/news/controller/news_search_controller.dart';
import 'package:world_cue/features/profile/controller/profile_controller.dart';
import 'package:world_cue/features/trending_news/controller/trending_news_controller.dart';

class DISetup {
  static void setup() {
    ///Controllers
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NewsSearchController());
    Get.lazyPut(() => BookmarkController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(
      () => TrendingNewsController(
        service: GeminiService(),
      ),
    );
  }
}
