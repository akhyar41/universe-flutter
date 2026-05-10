import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:omni_datetime_picker/omni_datetime_picker.dart";

import "../../../../core/services/meeting_service.dart";
import "../../../../core/utils/date_formatter.dart";
import "../../../../core/utils/form_validator.dart";
import "../../../../core/utils/snackbar_helper.dart";
import "../../../../data/models/meeting_note_model.dart";
import "../meeting_list/meeting_list_controller.dart";

class MeetingFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final agendaController = TextEditingController();
  final discussionController = TextEditingController();

  final selectedDate = DateTime.now().obs;
  final selectedTime = "".obs;
  final participants = <String>[].obs;

  final isLoading = false.obs;
  final isEditing = false.obs;

  MeetingNoteModel? _editingMeeting;

  @override
  void onInit() {
    super.onInit();
    selectedTime.value = DateFormatter.timeFromDateTime(DateTime.now());

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args["meeting"] != null) {
      _editingMeeting = args["meeting"] as MeetingNoteModel;
      _populateFields(_editingMeeting!);
      isEditing.value = true;
    }
  }

  void _populateFields(MeetingNoteModel m) {
    titleController.text = m.title;
    locationController.text = m.location;
    agendaController.text = m.agenda;
    discussionController.text = m.discussion;
    selectedDate.value = m.date;
    selectedTime.value = m.time;
    participants.value = List.from(m.participants);
  }

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    agendaController.dispose();
    discussionController.dispose();
    super.onClose();
  }

  Future<void> pickDateTime(BuildContext context) async {
    final result = await showOmniDateTimePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      transitionBuilder: (context, anim1, anim2, child) => child,
      transitionDuration: Duration.zero,
    );
    if (result != null) {
      selectedDate.value = result;
      selectedTime.value = DateFormatter.timeFromDateTime(result);
    }
  }

  void addParticipant(String name) {
    if (name.trim().isNotEmpty) participants.add(name.trim());
  }

  void removeParticipant(int index) => participants.removeAt(index);

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    final meeting = MeetingNoteModel(
      id: _editingMeeting?.id ?? "",
      userId: "",
      title: titleController.text.trim(),
      date: selectedDate.value,
      time: selectedTime.value,
      location: locationController.text.trim(),
      agenda: agendaController.text.trim(),
      participants: participants.toList(),
      discussion: discussionController.text.trim(),
      actionItems: [],
      createdAt: _editingMeeting?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      if (isEditing.value && _editingMeeting != null) {
        await MeetingService.to.update(_editingMeeting!.id, meeting);
        Get.find<MeetingListController>().loadMeetings();
        Get.back();
        SnackbarHelper.success("Notulen rapat diperbarui");
      } else {
        await MeetingService.to.create(meeting);
        Get.find<MeetingListController>().loadMeetings();
        Get.back();
        SnackbarHelper.success("Notulen rapat disimpan");
      }
    } catch (e) {
      SnackbarHelper.error(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading.value = false;
    }
  }

  String? validateRequired(String? v, {String field = "Kolom ini"}) =>
      FormValidator.validateRequired(v, fieldName: field);
}
