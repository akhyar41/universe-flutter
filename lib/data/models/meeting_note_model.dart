import "package:hive/hive.dart";
import "action_item_model.dart";

class MeetingNoteModel {
  final String id;
  final String userId;
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final String agenda;
  final List<String> participants;
  final String discussion;
  final List<ActionItemModel> actionItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MeetingNoteModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.agenda,
    required this.participants,
    required this.discussion,
    required this.actionItems,
    required this.createdAt,
    required this.updatedAt,
  });

  MeetingNoteModel copyWith({
    String? title,
    DateTime? date,
    String? time,
    String? location,
    String? agenda,
    List<String>? participants,
    String? discussion,
    List<ActionItemModel>? actionItems,
    DateTime? updatedAt,
  }) {
    return MeetingNoteModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      agenda: agenda ?? this.agenda,
      participants: participants ?? this.participants,
      discussion: discussion ?? this.discussion,
      actionItems: actionItems ?? this.actionItems,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MeetingNoteAdapter extends TypeAdapter<MeetingNoteModel> {
  @override
  final int typeId = 2;

  @override
  MeetingNoteModel read(BinaryReader reader) {
    final count = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < count; i++) reader.readByte(): reader.read()};
    return MeetingNoteModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      date: DateTime.fromMillisecondsSinceEpoch(fields[3] as int),
      time: fields[4] as String,
      location: fields[5] as String,
      agenda: fields[6] as String,
      participants: (fields[7] as List).cast<String>(),
      discussion: fields[8] as String,
      actionItems: (fields[9] as List).cast<ActionItemModel>(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(fields[10] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(fields[11] as int),
    );
  }

  @override
  void write(BinaryWriter writer, MeetingNoteModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.date.millisecondsSinceEpoch)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.agenda)
      ..writeByte(7)
      ..write(obj.participants)
      ..writeByte(8)
      ..write(obj.discussion)
      ..writeByte(9)
      ..write(obj.actionItems)
      ..writeByte(10)
      ..write(obj.createdAt.millisecondsSinceEpoch)
      ..writeByte(11)
      ..write(obj.updatedAt.millisecondsSinceEpoch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => other is MeetingNoteAdapter && typeId == other.typeId;
}
