import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/generated/l10n.dart';

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

  void setAppLanguage(String langCode) {
    SharedPref.setString(SharedPrefConstants.language, langCode);
    S.load( Locale(langCode));
    Get.back();
    Get.updateLocale( Locale(langCode));
  }
}
