import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_cue/features/news/model/news_model.dart';
import 'package:world_cue/core/repository/news_repository.dart';

import '../../../core/storage/shared_pref.dart';
import '../../../core/widgets/toast.dart';
import '../../auth/view/auth_screen.dart';

class ProfileController extends GetxController {

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      await SharedPref.deleteAll();
      Get.to(() => AuthScreen());
    } catch (e) {
      showErrorToast('Logout failed: $e');
    }
  }

}
