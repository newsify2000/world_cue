import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:world_cue/generated/l10n.dart';
import 'package:world_cue/view/theme/text_style.dart';

class InternetConnectivityChecker extends StatefulWidget {
  final Widget child;

  const InternetConnectivityChecker({super.key, required this.child});

  @override
  InternetConnectivityCheckerState createState() =>
      InternetConnectivityCheckerState();
}

class InternetConnectivityCheckerState
    extends State<InternetConnectivityChecker> {
  bool _isConnected = true;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // Listen for changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // Check initial status
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    setState(() {
      _isConnected = results.isNotEmpty &&
          results.any((result) => result != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: _isConnected ? 0 : 50,
          color: Colors.red,
          child: Center(
            child: Text(
              S.of(context).noInternetConnection,
              style: AppTextTheme.bodyMediumStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
