import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../routes/app_routes.dart";
import "../../../../core/services/auth_service.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/snackbar_helper.dart";

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateName(String? v) => FormValidator.validateRequired(v, fieldName: "Full name");

  String? validateEmail(String? v) => FormValidator.validateEmail(v);

  String? validatePassword(String? v) => FormValidator.validatePassword(v);

  String? validateConfirmPassword(String? v) => FormValidator.validateConfirmPassword(v, passwordController.text);

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await AuthService.to.register(nameController.text, emailController.text, passwordController.text);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }
}
