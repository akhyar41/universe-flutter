import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../../themes/app_text_styles.dart";
import "../../../_components/widgets/app_button.dart";
import "../../../_components/widgets/app_text_field.dart";
import "update_password_controller.dart";

class UpdatePasswordScreen extends GetView<UpdatePasswordController> {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perbarui Kata Sandi"), titleSpacing: 0),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text("Masukkan kata sandi saat ini dan pilih kata sandi baru.", style: AppTextStyles.bodyMedium),
              const SizedBox(height: 24),
              AppTextField(
                label: "Kata Sandi Saat Ini",
                hint: "Masukkan kata sandi saat ini",
                controller: controller.currentPasswordController,
                validator: controller.validateCurrent,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Kata Sandi Baru",
                hint: "Minimal 8 karakter",
                controller: controller.newPasswordController,
                validator: controller.validateNew,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Konfirmasi Kata Sandi Baru",
                hint: "Masukkan ulang kata sandi baru",
                controller: controller.confirmPasswordController,
                validator: controller.validateConfirm,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              Obx(
                () => AppButton(
                  label: "Perbarui Kata Sandi",
                  onPressed: controller.save,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
