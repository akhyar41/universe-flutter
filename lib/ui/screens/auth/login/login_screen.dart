import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../routes/app_routes.dart";
import "../../../themes/app_colors.dart";
import "../../../themes/app_text_styles.dart";
import "../../../themes/app_theme.dart";
import "../../../_components/widgets/app_button.dart";
import "../../../_components/widgets/app_text_field.dart";
import "login_controller.dart";

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        systemOverlayStyle: AppTheme.systemBarLight,
        automaticallyImplyLeading: false,
        shape: const Border(),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Selamat Datang", style: AppTextStyles.h1),
                    const SizedBox(height: 8),
                    Text(
                      "Masuk ke akun MoM Note Anda",
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 40),
                    AppTextField(
                      label: "Email",
                      hint: "Masukkan email Anda",
                      controller: controller.emailController,
                      validator: controller.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: "Kata Sandi",
                      hint: "Masukkan kata sandi Anda",
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () =>
                          AppButton(label: "Masuk", onPressed: controller.login, isLoading: controller.isLoading.value),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun? ",
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.register),
                          child: Text(
                            "Daftar",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
