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
              const SizedBox(height: 180),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: const Icon(Icons.description_outlined, size: 120, color: AppColors.primary),
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
