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
      avatar: fields[5] as String,
      chatImagesSrc: fields[6] as String,
      chatVideosSrc: fields[7] as String,
      photos: (fields[8] as List).cast<String>(),
      messages: (fields[9] as List?)?.cast<IChatMessage>(),
      scriptDayIndex: fields[10] as int?,
      scriptMessageIndex: fields[11] as int?,
      hide: fields[12] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, IAssistant obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.assistantKey)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.chatImagesSrc)
      ..writeByte(7)
      ..write(obj.chatVideosSrc)
      ..writeByte(8)
      ..write(obj.photos)
      ..writeByte(9)
      ..write(obj.messages)
      ..writeByte(10)
      ..write(obj.scriptDayIndex)
      ..writeByte(11)
      ..write(obj.scriptMessageIndex)
      ..writeByte(12)
      ..write(obj.hide);
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
