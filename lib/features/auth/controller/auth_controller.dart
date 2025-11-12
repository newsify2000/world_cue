import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/widgets/toast.dart';
import 'package:world_cue/features/navigator/view/navigator_screen.dart';
import 'package:world_cue/generated/l10n.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final RxBool isSigningIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isSigningIn.value = true;

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        showErrorToast('Sign-in cancelled by user.');
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user != null) {
        // 🔹 Save user info in SharedPref
        await SharedPref.setString(SharedPrefConstants.userId, user.uid);
        await SharedPref.setString(
          SharedPrefConstants.userName,
          user.displayName ?? '',
        );
        await SharedPref.setString(
          SharedPrefConstants.userEmail,
          user.email ?? '',
        );
        await SharedPref.setString(
          SharedPrefConstants.userImage,
          user.photoURL ?? '',
        );

        // 🔹 Save user info in Firestore
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);

        await userRef.set({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'photoUrl': user.photoURL ?? '',
          'lastLogin': FieldValue.serverTimestamp(),
          'fcmToken': SharedPref.getString(SharedPrefConstants.fcmToken),
        }, SetOptions(merge: true));

        // 🔹 Save initial screen
        await SharedPref.setString(
          SharedPrefConstants.initScreen,
          SharedPrefConstants.homeScreen,
        );

        // 🔹 Navigate and show success
        Get.offAll(() => NavigatorScreen());
      } else {
        showErrorToast('Google sign-in failed.');
      }
    } catch (e, s) {
      log('❌ Google sign-in failed: $e');
      log(s.toString());
      showErrorToast('Google sign-in failed: $e');
    } finally {
      isSigningIn.value = false;
    }
  }

  void setAppLanguage(String code) {
    SharedPref.setString(SharedPrefConstants.language, code);
    S.load(Locale(code));
    Get.back();
    Get.updateLocale(Locale(code));
  }
}
