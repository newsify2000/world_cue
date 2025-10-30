import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final RxBool isSigningIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isSigningIn.value = true;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // 2. Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // 3. Create a new credential for Firebase
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        log(
          '✅ Google sign-in successful: ${FirebaseAuth.instance.currentUser?.displayName}',
        );
      }
    } catch (e, s) {
      log('❌ Google sign-in failed: $e');
      log(s.toString());
      Get.snackbar('Error', 'Google sign-in failed');
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
