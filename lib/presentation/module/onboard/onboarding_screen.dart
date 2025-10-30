import 'package:flutter/material.dart';
import 'package:world_cue/presentation/theme/text_style.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Onboarding Screen", style: AppTextTheme.bodyBoldStyle),
      ),
    );
  }
}
