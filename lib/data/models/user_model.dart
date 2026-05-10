import "package:hive/hive.dart";

class UserModel {
  final String id;
  final String name;
  final String email;
  final String passwordHash;

  const UserModel({required this.id, required this.name, required this.email, required this.passwordHash});

  UserModel copyWith({String? name, String? email, String? passwordHash}) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }
}

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final count = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < count; i++) reader.readByte(): reader.read()};
    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      passwordHash: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.passwordHash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => other is UserAdapter && typeId == other.typeId;
}
