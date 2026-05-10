import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../routes/app_routes.dart";
import "../../../../core/services/auth_service.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/snackbar_helper.dart";

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? v) => FormValidator.validateEmail(v);

  String? validatePassword(String? v) => FormValidator.validatePassword(v);

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await AuthService.to.login(emailController.text, passwordController.text);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }
}
