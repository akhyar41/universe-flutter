import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../themes/app_colors.dart";
import "../../themes/app_text_styles.dart";
import "settings_controller.dart";

class SettingsTab extends GetView<SettingsController> {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Obx(() => _ProfileHeader(name: controller.user.value?.name ?? "—", email: controller.user.value?.email ?? "—")),
        const SizedBox(height: 16),
        _SettingsSection(
          title: "Akun",
          items: [
            _SettingsItem(
              icon: Icons.person_outline,
              label: "Perbarui Profil",
              onTap: controller.navigateToUpdateProfile,
            ),
            _SettingsItem(
              icon: Icons.lock_outline,
              label: "Perbarui Kata Sandi",
              onTap: controller.navigateToUpdatePassword,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SettingsSection(
          title: "Tentang",
          items: [
            Obx(
              () => _SettingsItem(
                icon: Icons.info_outline,
                label: "Versi Aplikasi",
                trailing: Text(controller.appVersion.value, style: AppTextStyles.bodySmall),
                onTap: null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: controller.logout,
          icon: const Icon(Icons.logout, color: AppColors.error),
          label: const Text("Keluar", style: TextStyle(color: AppColors.error)),
          style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.error)),
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileHeader({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.h3),
                  const SizedBox(height: 2),
                  Text(email, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary)),
        ),
        Card(child: Column(children: items)),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItem({required this.icon, required this.label, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTextStyles.bodyMedium),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
