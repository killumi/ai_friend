// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_script_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IScriptMessageAdapter extends TypeAdapter<IScriptMessage> {
  @override
  final int typeId = 0;

  @override
  IScriptMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IScriptMessage(
      text: fields[0] as String,
      isPremium: fields[1] as bool,
      points: fields[2] as int,
      isScriptBot: fields[3] as bool?,
      action: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IScriptMessage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isPremium)
      ..writeByte(2)
      ..write(obj.points)
      ..writeByte(3)
      ..write(obj.isScriptBot)
      ..writeByte(4)
      ..write(obj.action);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IScriptMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
