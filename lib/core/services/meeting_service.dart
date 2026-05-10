import "package:get/get.dart";
import "package:uuid/uuid.dart";

import "../../../data/models/meeting_note_model.dart";
import "hive_service.dart";
import "storage_service.dart";

class MeetingService extends GetxService {
  static MeetingService get to => Get.find();

  final _hive = Get.find<HiveService>();
  final _storage = Get.find<StorageService>();

  String get _userId => _storage.getCurrentUserId()!;

  List<MeetingNoteModel> getAll() {
    return _hive.meetings.values.where((m) => m.userId == _userId).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  MeetingNoteModel? getById(String id) {
    final m = _hive.meetings.get(id);
    if (m == null || m.userId != _userId) return null;
    return m;
  }

  Future<void> create(MeetingNoteModel meeting) async {
    final now = DateTime.now();
    final id = const Uuid().v4();
    final newMeeting = MeetingNoteModel(
      id: id,
      userId: _userId,
      title: meeting.title,
      date: meeting.date,
      time: meeting.time,
      location: meeting.location,
      agenda: meeting.agenda,
      participants: meeting.participants,
      discussion: meeting.discussion,
      actionItems: meeting.actionItems,
      createdAt: now,
      updatedAt: now,
    );
    await _hive.meetings.put(id, newMeeting);
  }

  Future<void> update(String id, MeetingNoteModel meeting) async {
    final existing = _hive.meetings.get(id);
    if (existing == null || existing.userId != _userId) {
      throw Exception("Meeting not found");
    }
    final updated = existing.copyWith(
      title: meeting.title,
      date: meeting.date,
      time: meeting.time,
      location: meeting.location,
      agenda: meeting.agenda,
      participants: meeting.participants,
      discussion: meeting.discussion,
      actionItems: meeting.actionItems,
      updatedAt: DateTime.now(),
    );
    await _hive.meetings.put(id, updated);
  }

  Future<void> delete(String id) async {
    final existing = _hive.meetings.get(id);
    if (existing == null || existing.userId != _userId) {
      throw Exception("Meeting not found");
    }
    await _hive.meetings.delete(id);
  }
}
