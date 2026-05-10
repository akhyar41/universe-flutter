import "package:flutter/material.dart";
import "package:get/get.dart";

import "../_components/empty_state_widget.dart";
import "../_components/meeting_card.dart";
import "../../../routes/app_routes.dart";
import "../../../themes/app_colors.dart";
import "meeting_list_controller.dart";

class MeetingListTab extends GetView<MeetingListController> {
  const MeetingListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.meetings.isEmpty) {
          return EmptyStateWidget(
            title: "Belum Ada Notulen",
            subtitle: "Ketuk + untuk membuat notulen rapat pertama Anda",
            icon: Icons.event_note_outlined,
          );
        }
        return RefreshIndicator(
          onRefresh: () async => controller.loadMeetings(),
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: controller.meetings.length,
            itemBuilder: (context, index) {
              final meeting = controller.meetings[index];
              return RepaintBoundary(
                child: MeetingCard(
                  meeting: meeting,
                  onTap: () => Get.toNamed(AppRoutes.meetingForm, arguments: {"meeting": meeting}),
                  onDelete: () => controller.confirmDelete(meeting),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(AppRoutes.meetingForm);
          controller.loadMeetings();
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
