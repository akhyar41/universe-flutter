import "package:flutter/material.dart";
import "../../themes/app_colors.dart";

class AppLoader extends StatelessWidget {
  final bool fullScreen;

  const AppLoader({super.key, this.fullScreen = false});

  @override
  Widget build(BuildContext context) {
    final indicator = const CircularProgressIndicator(color: AppColors.primary);
    if (fullScreen) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }
    return indicator;
  }
}
