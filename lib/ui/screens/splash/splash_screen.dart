import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../themes/app_colors.dart";
import "../../themes/app_text_styles.dart";
import "../../themes/app_theme.dart";
import "splash_controller.dart";

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppTheme.systemBarPrimary,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.description_outlined, size: 56, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text("MoM Note", style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 32)),
              const SizedBox(height: 8),
              Text("Minutes of Meeting", style: AppTextStyles.bodyLarge.copyWith(color: Colors.white70)),
              const SizedBox(height: 60),
              const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            ],
          ),
        ),
      ),
    );
  }
}
