import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../ui/themes/app_colors.dart";

abstract class SnackbarHelper {
  static void success(String message, {String title = "Berhasil"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static void error(String message, {String title = "Gagal"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static void info(String message, {String title = "Info"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      icon: const Icon(Icons.info, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 200),
    );
  }
}
