// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_assistant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IAssistantAdapter extends TypeAdapter<IAssistant> {
  @override
  final int typeId = 4;

  @override
  IAssistant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IAssistant(
      id: fields[1] as String,
      name: fields[2] as String,
      age: fields[3] as String,
      assistantKey: fields[4] as String,
      avatarsSrc: fields[5] as String,
      chatImagesSrc: fields[6] as String,
      chatVideosSrc: fields[7] as String,
      profileSrc: fields[8] as String,
      scriptId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IAssistant obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.assistantKey)
      ..writeByte(5)
      ..write(obj.avatarsSrc)
      ..writeByte(6)
      ..write(obj.chatImagesSrc)
      ..writeByte(7)
      ..write(obj.chatVideosSrc)
      ..writeByte(8)
      ..write(obj.profileSrc)
      ..writeByte(9)
      ..write(obj.scriptId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IAssistantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
