// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_script_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IScriptDayAdapter extends TypeAdapter<IScriptDay> {
  @override
  final int typeId = 2;

  @override
  IScriptDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IScriptDay(
      day: fields[0] as int,
      data: (fields[1] as List).cast<IScriptMessageData>(),
    );
  }

  @override
  void write(BinaryWriter writer, IScriptDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IScriptDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
