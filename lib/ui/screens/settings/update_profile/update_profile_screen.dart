import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../../themes/app_text_styles.dart";
import "../../../_components/widgets/app_button.dart";
import "../../../_components/widgets/app_text_field.dart";
import "update_profile_controller.dart";

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perbarui Profil"), titleSpacing: 0),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text("Edit informasi profil Anda di bawah ini.", style: AppTextStyles.bodyMedium),
              const SizedBox(height: 24),
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
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              Obx(
                () => AppButton(
                  label: "Perbarui Profil",
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
