import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility class for handling URL launches within the application.
class UrlLauncher {
  /// Attempts to launch a given URL in the appropriate manner.
  ///
  /// This function first checks if the URL can be launched. If it can,
  /// it attempts to launch it using [launchUrl]. If the launch fails,
  /// it prints an error message to the console.

  static Future<void> launchURL(String url, BuildContext context) async {
    // 1. Create a Uri object from the URL string.
    final Uri uri = Uri.parse(url);

    // 2. Check if the URL can be launched.
    // We use canLaunchUrl(uri) to verify the device can handle the URL scheme.
    if (await canLaunchUrl(uri)) {
      try {
        // 3. Attempt to launch the URL.
        // We use LaunchMode.externalApplication to open the link in the device's
        // default browser (which is usually the most reliable method).
        final success = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (!success) {
          // If launchUrl returns false, the operation failed.
          log('Error: Could not launch $url');
        }
      } catch (e) {
        // Handle any exceptions during the launch process.
        log('Exception caught while launching $url: $e');
      }
    } else {
      // 4. Handle cases where the URL scheme is not supported.
      log('Error: Could not find application to launch $url');
      // In a production app, you might show a user-friendly message here:
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Could not open the link.')),
      // );
    }
  }
}
