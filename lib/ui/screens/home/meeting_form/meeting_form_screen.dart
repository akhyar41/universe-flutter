import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../core/utils/date_formatter.dart";
import "../../../_components/widgets/app_button.dart";
import "../../../_components/widgets/app_text_field.dart";
import "../../../themes/app_colors.dart";
import "../../../themes/app_text_styles.dart";
import "meeting_form_controller.dart";

class MeetingFormScreen extends GetView<MeetingFormController> {
  const MeetingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("Form Rapat"),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: "Judul Rapat",
                hint: "Masukkan judul rapat",
                controller: controller.titleController,
                validator: (v) => controller.validateRequired(v, field: "Judul"),
                prefixIcon: Icons.title,
              ),
              const SizedBox(height: 16),
              _SectionLabel(label: "Tanggal & Waktu"),
              Obx(
                () => InkWell(
                  onTap: () => controller.pickDateTime(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: AppColors.textSecondary, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          "${DateFormatter.toDisplayDate(controller.selectedDate.value)}  ${controller.selectedTime.value}",
                          style: AppTextStyles.bodyMedium,
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Lokasi",
                hint: "Masukkan lokasi rapat",
                controller: controller.locationController,
                validator: (v) => controller.validateRequired(v, field: "Lokasi"),
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Agenda",
                hint: "Jelaskan agenda rapat",
                controller: controller.agendaController,
                validator: (v) => controller.validateRequired(v, field: "Agenda"),
                maxLines: 3,
                prefixIcon: Icons.list_alt,
              ),
              const SizedBox(height: 16),
              _SectionLabel(label: "Peserta"),
              _ParticipantsSection(controller: controller),
              const SizedBox(height: 16),
              AppTextField(
                label: "Diskusi / Catatan",
                hint: "Masukkan hasil diskusi dan catatan rapat",
                controller: controller.discussionController,
                maxLines: 5,
                prefixIcon: Icons.notes,
              ),
              const SizedBox(height: 32),
              Obx(() => AppButton(label: "Simpan", onPressed: controller.save, isLoading: controller.isLoading.value)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: AppTextStyles.labelLarge),
    );
  }
}

class _ParticipantsSection extends StatelessWidget {
  final MeetingFormController controller;

  const _ParticipantsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ...controller.participants.asMap().entries.map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  e.value.isNotEmpty ? e.value[0].toUpperCase() : "?",
                  style: const TextStyle(color: AppColors.primary, fontSize: 12),
                ),
              ),
              title: Text(e.value, style: AppTextStyles.bodyMedium),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => controller.removeParticipant(e.key),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => _showAddParticipantDialog(context),
            icon: const Icon(Icons.person_add_outlined),
            label: const Text("Tambah Peserta"),
          ),
        ],
      ),
    );
  }

  void _showAddParticipantDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text("Tambah Peserta"),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Nama peserta"),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text("Batal")),
          TextButton(
            onPressed: () {
              controller.addParticipant(nameCtrl.text);
              Get.back();
            },
            child: const Text("Tambah"),
          ),
        ],
      ),
    );
  }
}
