// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_script_message_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IScriptMessageDataAdapter extends TypeAdapter<IScriptMessageData> {
  @override
  final int typeId = 1;

  @override
  IScriptMessageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IScriptMessageData(
      id: fields[0] as int,
      description: fields[1] as String,
      messages: (fields[2] as List).cast<IScriptMessage>(),
      textfieldAvailable: fields[3] as bool?,
      answer: (fields[5] as List?)?.cast<IChatMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, IScriptMessageData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.messages)
      ..writeByte(3)
      ..write(obj.textfieldAvailable)
      ..writeByte(5)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IScriptMessageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
