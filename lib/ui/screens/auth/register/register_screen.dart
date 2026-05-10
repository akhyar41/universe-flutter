import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../themes/app_colors.dart";
import "../../../themes/app_text_styles.dart";
import "../../../themes/app_theme.dart";
import "../../../_components/widgets/app_button.dart";
import "../../../_components/widgets/app_text_field.dart";
import "register_controller.dart";

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        systemOverlayStyle: AppTheme.systemBarLight,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Buat Akun", style: AppTextStyles.h1),
                    const SizedBox(height: 8),
                    Text(
                      "Bergabung dengan MoM Note untuk mengelola notulen rapat Anda",
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      label: "Nama Lengkap",
                      hint: "Masukkan nama lengkap Anda",
                      controller: controller.nameController,
                      validator: controller.validateName,
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
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
                      hint: "Minimal 8 karakter",
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: "Konfirmasi Kata Sandi",
                      hint: "Masukkan ulang kata sandi Anda",
                      controller: controller.confirmPasswordController,
                      validator: controller.validateConfirmPassword,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppButton(
                        label: "Daftar",
                        onPressed: controller.register,
                        isLoading: controller.isLoading.value,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun? ",
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: Get.back,
                          child: Text(
                            "Masuk",
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
