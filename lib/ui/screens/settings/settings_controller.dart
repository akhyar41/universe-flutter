import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../routes/app_routes.dart";
import "../../../core/services/auth_service.dart";
import "../../../data/models/user_model.dart";

class SettingsController extends GetxController {
  final user = Rx<UserModel?>(null);
  final appVersion = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadVersion();
    user.value = AuthService.to.currentUser;
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
  }

  void refreshUser() {
    user.value = AuthService.to.currentUser;
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text("Keluar"),
        content: const Text("Konfirmasi keluar aplikasi"),
        actions: [
          TextButton(onPressed: Get.back, child: const Text("Batal")),
          TextButton(
            onPressed: () async {
              Get.back();
              await AuthService.to.logout();
              Get.offAllNamed(AppRoutes.login);
            },
            child: Text("Keluar", style: TextStyle(color: Get.theme.colorScheme.error)),
          ),
        ],
      ),
    );
  }

  void navigateToUpdateProfile() => Get.toNamed(AppRoutes.updateProfile);

  void navigateToUpdatePassword() => Get.toNamed(AppRoutes.updatePassword);
}
