import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../core/services/auth_service.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/snackbar_helper.dart";
import "../settings_controller.dart";

class UpdateProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = AuthService.to.currentUser;
    nameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  String? validateName(String? v) => FormValidator.validateRequired(v, fieldName: "Full name");

  String? validateEmail(String? v) => FormValidator.validateEmail(v);

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await AuthService.to.updateProfile(nameController.text, emailController.text);
      Get.find<SettingsController>().refreshUser();
      Get.back();
      SnackbarHelper.success("Profil berhasil diperbarui");
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }
}
