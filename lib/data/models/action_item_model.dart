import "package:hive/hive.dart";

class ActionItemModel {
  final String? id;
  final String description;
  final String assignedTo;
  final DateTime dueDate;
  final bool isCompleted;

  const ActionItemModel({
    this.id,
    required this.description,
    required this.assignedTo,
    required this.dueDate,
    this.isCompleted = false,
  });

  ActionItemModel copyWith({String? description, String? assignedTo, DateTime? dueDate, bool? isCompleted}) {
    return ActionItemModel(
      id: id,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class ActionItemAdapter extends TypeAdapter<ActionItemModel> {
  @override
  final int typeId = 1;

  @override
  ActionItemModel read(BinaryReader reader) {
    final count = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < count; i++) reader.readByte(): reader.read()};
    return ActionItemModel(
      id: fields[0] as String?,
      description: fields[1] as String,
      assignedTo: fields[2] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(fields[3] as int),
      isCompleted: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ActionItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.assignedTo)
      ..writeByte(3)
      ..write(obj.dueDate.millisecondsSinceEpoch)
      ..writeByte(4)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => other is ActionItemAdapter && typeId == other.typeId;
}
