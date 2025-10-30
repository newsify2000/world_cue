import 'package:get/get.dart';
import 'package:world_cue/presentation/module/auth/controller/login_controller.dart';
import 'package:world_cue/presentation/module/home/controller/home_controller.dart';
import 'package:world_cue/presentation/module/search/news_search_controller.dart';

class DISetup {
  static void setup() {
    ///Controllers
    Get.put(LoginController());
    Get.put(HomeController());
    Get.put(NewsSearchController());
  }
}
