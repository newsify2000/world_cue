import 'package:flutter/material.dart';

void moveTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
          ) {
            return screen;
          },
    ),
  );
}

///move to new screen and kill all previous routes
void moveAndKillAll(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
          ) {
            return screen;
          },
    ),
    (Route<dynamic> route) => false,
  );
}

///back to last screen
void backToPrevious(BuildContext context) {
  Navigator.pop(context);
}

///back to custom screen
void backUntil(BuildContext context, int noOfScreen) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= noOfScreen);
}
