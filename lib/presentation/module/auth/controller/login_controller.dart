import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_cue/presentation/common_widgets/toast.dart';
import 'package:world_cue/presentation/module/home/screens/home_screen.dart';
import 'package:world_cue/utils/constants.dart';
import 'package:world_cue/utils/shared_pref.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


class LoginController extends GetxController {
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

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // 🔹 Save user info in SharedPref
        await SharedPref.setString(SharedPrefConstants.userName, user.displayName ?? '');
        await SharedPref.setString(SharedPrefConstants.userEmail, user.email ?? '');
        await SharedPref.setString(SharedPrefConstants.userImage, user.photoURL ?? '');

        // 🔹 Save user info in Firestore
   /*     final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

        await userRef.set({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'photoUrl': user.photoURL ?? '',
          'lastLogin': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)); */// merge prevents overwriting existing data

        // 🔹 Save initial screen
        await SharedPref.setString(
          SharedPrefConstants.initScreen,
          SharedPrefConstants.homeScreen,
        );

        // 🔹 Navigate and show success
        Get.offAll(() => HomeScreen());
        showSuccessToast("Login Successfully.");
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

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    log('User signed out');
  }
}
