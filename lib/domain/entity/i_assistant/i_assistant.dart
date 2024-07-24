// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

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
  final String avatarsSrc;
  @HiveField(6)
  final String chatImagesSrc;
  @HiveField(7)
  final String chatVideosSrc;
  @HiveField(8)
  final String profileSrc;
  @HiveField(9)
  final String scriptId;

  IAssistant({
    required this.id,
    required this.name,
    required this.age,
    required this.assistantKey,
    required this.avatarsSrc,
    required this.chatImagesSrc,
    required this.chatVideosSrc,
    required this.profileSrc,
    required this.scriptId,
  });

  IAssistant copyWith({
    String? id,
    String? name,
    String? age,
    String? assistantKey,
    String? avatarsSrc,
    String? chatImagesSrc,
    String? chatVideosSrc,
    String? profileSrc,
    String? scriptId,
  }) {
    return IAssistant(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      assistantKey: assistantKey ?? this.assistantKey,
      avatarsSrc: avatarsSrc ?? this.avatarsSrc,
      chatImagesSrc: chatImagesSrc ?? this.chatImagesSrc,
      chatVideosSrc: chatVideosSrc ?? this.chatVideosSrc,
      profileSrc: profileSrc ?? this.profileSrc,
      scriptId: scriptId ?? this.scriptId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'assistantKey': assistantKey,
      'avatarsSrc': avatarsSrc,
      'chatImagesSrc': chatImagesSrc,
      'chatVideosSrc': chatVideosSrc,
      'profileSrc': profileSrc,
      'scriptId': scriptId,
    };
  }

  factory IAssistant.fromMap(Map<String, dynamic> map) {
    return IAssistant(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as String,
      assistantKey: map['assistantKey'] as String,
      avatarsSrc: map['avatarsSrc'] as String,
      chatImagesSrc: map['chatImagesSrc'] as String,
      chatVideosSrc: map['chatVideosSrc'] as String,
      profileSrc: map['profileSrc'] as String,
      scriptId: map['scriptId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IAssistant.fromJson(String source) =>
      IAssistant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IAssistant(id: $id, name: $name, age: $age, assistantKey: $assistantKey, avatarsSrc: $avatarsSrc, chatImagesSrc: $chatImagesSrc, chatVideosSrc: $chatVideosSrc, profileSrc: $profileSrc, scriptId: $scriptId)';
  }

  @override
  bool operator ==(covariant IAssistant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        other.assistantKey == assistantKey &&
        other.avatarsSrc == avatarsSrc &&
        other.chatImagesSrc == chatImagesSrc &&
        other.chatVideosSrc == chatVideosSrc &&
        other.profileSrc == profileSrc &&
        other.scriptId == scriptId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        assistantKey.hashCode ^
        avatarsSrc.hashCode ^
        chatImagesSrc.hashCode ^
        chatVideosSrc.hashCode ^
        profileSrc.hashCode ^
        scriptId.hashCode;
  }
}
