import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../core/services/meeting_service.dart";
import "../../../../core/utils/snackbar_helper.dart";
import "../../../../data/models/meeting_note_model.dart";

class MeetingListController extends GetxController {
  final meetings = <MeetingNoteModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMeetings();
  }

  void loadMeetings() {
    isLoading.value = true;
    try {
      meetings.value = MeetingService.to.getAll();
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMeeting(String id) async {
    try {
      await MeetingService.to.delete(id);
      meetings.removeWhere((m) => m.id == id);
      SnackbarHelper.success("Notulen rapat dihapus");
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  void confirmDelete(MeetingNoteModel meeting) {
    Get.dialog(
      AlertDialog(
        title: const Text("Hapus Rapat"),
        content: Text("Konfirmasi hapus data dipilih"),
        actions: [
          TextButton(onPressed: Get.back, child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Get.back();
              deleteMeeting(meeting.id);
            },
            child: Text("Hapus", style: TextStyle(color: Get.theme.colorScheme.error)),
          ),
        ],
      ),
    );
  }
}
