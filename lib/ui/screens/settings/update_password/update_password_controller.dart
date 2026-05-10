import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../core/services/auth_service.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/snackbar_helper.dart";

class UpdatePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateCurrent(String? v) => FormValidator.validatePassword(v);

  String? validateNew(String? v) => FormValidator.validatePassword(v);

  String? validateConfirm(String? v) => FormValidator.validateConfirmPassword(v, newPasswordController.text);

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await AuthService.to.updatePassword(currentPasswordController.text, newPasswordController.text);
      Get.back();
      SnackbarHelper.success("Kata sandi berhasil diperbarui");
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }
}
