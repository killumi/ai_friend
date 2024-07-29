// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:intl/intl.dart';

part 'i_assistant.g.dart';

@HiveType(typeId: 4)
class IAssistant extends HiveObject {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String age;
  @HiveField(4)
  final String assistantKey;
  @HiveField(5)
  final String avatar;
  @HiveField(6)
  final String chatImagesSrc;
  @HiveField(7)
  final String chatVideosSrc;
  @HiveField(8)
  final List<String> photos;
  @HiveField(9)
  List<IChatMessage>? messages;
  @HiveField(10)
  int? scriptDayIndex;
  @HiveField(11)
  int? scriptMessageIndex;
  @HiveField(12)
  bool? hide;

  // photos: List<String>.from(
  //       (map['photos'] as List).map((item) => item as String)),

  IAssistant({
    required this.id,
    required this.name,
    required this.age,
    required this.assistantKey,
    required this.avatar,
    required this.chatImagesSrc,
    required this.chatVideosSrc,
    required this.photos,
    this.messages,
    this.scriptDayIndex,
    this.scriptMessageIndex,
    this.hide,
  });

  IAssistant copyWith({
    String? id,
    String? name,
    String? age,
    String? assistantKey,
    String? avatar,
    String? chatImagesSrc,
    String? chatVideosSrc,
    List<String>? photos,
    List<IChatMessage>? messages,
    int? scriptDayIndex,
    int? scriptMessageIndex,
    bool? hide,
  }) {
    return IAssistant(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      assistantKey: assistantKey ?? this.assistantKey,
      avatar: avatar ?? this.avatar,
      chatImagesSrc: chatImagesSrc ?? this.chatImagesSrc,
      chatVideosSrc: chatVideosSrc ?? this.chatVideosSrc,
      photos: photos ?? this.photos,
      messages: messages ?? this.messages,
      scriptDayIndex: scriptDayIndex ?? this.scriptDayIndex,
      scriptMessageIndex: scriptMessageIndex ?? this.scriptMessageIndex,
      hide: hide ?? this.hide,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'assistantKey': assistantKey,
      'avatar': avatar,
      'chatImagesSrc': chatImagesSrc,
      'chatVideosSrc': chatVideosSrc,
      'photos': photos,
      'messages': messages?.map((x) => x.toMap()).toList() ?? [],
      'scriptDayIndex': scriptDayIndex,
      'scriptMessageIndex': scriptMessageIndex,
      'hide': hide,
    };
  }

  String getDate(IChatMessage message) {
    final dateTime = message.date!;
    final dayFormat = DateFormat('dd');
    final monthFormat = DateFormat('MM');
    final timeFormat = DateFormat('HH:mm');

    final day = dayFormat.format(dateTime);
    final month = monthFormat.format(dateTime);
    final time = timeFormat.format(dateTime);

    return '$day.$month $time';
  }

  factory IAssistant.fromMap(Map<String, dynamic> map) {
    return IAssistant(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as String,
      assistantKey: map['assistantKey'] as String,
      avatar: map['avatar'] as String,
      chatImagesSrc: map['chatImagesSrc'] as String,
      chatVideosSrc: map['chatVideosSrc'] as String,
      photos: List<String>.from(
          (map['photos'] as List).map((item) => item as String)),
      messages: map['messages'] != null
          ? List<IChatMessage>.from(
              (map['messages'] as List<dynamic>).map<IChatMessage?>(
                (x) => IChatMessage.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      scriptDayIndex:
          map.containsKey('scriptDayIndex') ? map['scriptDayIndex'] as int : 0,
      scriptMessageIndex: map.containsKey('scriptMessageIndex')
          ? map['scriptMessageIndex'] as int
          : 0,
      hide: map['hide'] != null ? map['hide'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory IAssistant.fromJson(String source) =>
      IAssistant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IAssistant(id: $id, name: $name, age: $age, assistantKey: $assistantKey, avatar: $avatar, chatImagesSrc: $chatImagesSrc, chatVideosSrc: $chatVideosSrc, photos: $photos, messages: $messages, scriptDayIndex: $scriptDayIndex, scriptMessageIndex: $scriptMessageIndex, hide: $hide)';
  }

  @override
  bool operator ==(covariant IAssistant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        other.assistantKey == assistantKey &&
        other.avatar == avatar &&
        other.chatImagesSrc == chatImagesSrc &&
        other.chatVideosSrc == chatVideosSrc &&
        listEquals(other.photos, photos) &&
        other.hide == hide;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        assistantKey.hashCode ^
        avatar.hashCode ^
        chatImagesSrc.hashCode ^
        chatVideosSrc.hashCode ^
        photos.hashCode ^
        hide.hashCode;
  }
}
