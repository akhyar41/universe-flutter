import "package:get/get.dart";
import "package:hive_flutter/hive_flutter.dart";
import "../../../data/models/user_model.dart";
import "../../../data/models/action_item_model.dart";
import "../../../data/models/meeting_note_model.dart";

class HiveService extends GetxService {
  static const String _usersBox = "users";
  static const String _meetingsBox = "meetings";

  late final Box<UserModel> users;
  late final Box<MeetingNoteModel> meetings;

  Future<HiveService> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ActionItemAdapter());
    Hive.registerAdapter(MeetingNoteAdapter());
    users = await Hive.openBox<UserModel>(_usersBox);
    meetings = await Hive.openBox<MeetingNoteModel>(_meetingsBox);
    return this;
  }
}
