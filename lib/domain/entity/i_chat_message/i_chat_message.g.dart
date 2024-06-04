// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_chat_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IChatMessageAdapter extends TypeAdapter<IChatMessage> {
  @override
  final int typeId = 3;

  @override
  IChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IChatMessage(
      date: fields[0] as DateTime?,
      isBot: fields[1] as bool?,
      type: fields[2] as String,
      content: fields[3] as String,
      isPremiumContent: fields[4] as bool,
      mediaData: fields[5] as Uint8List?,
      isLiked: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, IChatMessage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.isBot)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.isPremiumContent)
      ..writeByte(5)
      ..write(obj.mediaData)
      ..writeByte(6)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
