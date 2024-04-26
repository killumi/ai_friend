// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/entity/i_script_message/i_script_message.dart';

part 'i_script_message_data.g.dart';

@HiveType(typeId: 1)
class IScriptMessageData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final List<IScriptMessage> messages;

  @HiveField(3)
  final bool? textfieldAvailable;

  @HiveField(5)
  final List<IChatMessage>? answer;

  IScriptMessageData({
    required this.id,
    required this.description,
    required this.messages,
    this.textfieldAvailable,
    this.answer,
  });

  IScriptMessageData copyWith({
    int? id,
    String? description,
    List<IScriptMessage>? messages,
    bool? textfieldAvailable,
    List<IChatMessage>? answer,
  }) {
    return IScriptMessageData(
      id: id ?? this.id,
      description: description ?? this.description,
      messages: messages ?? this.messages,
      textfieldAvailable: textfieldAvailable ?? this.textfieldAvailable,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'messages': messages.map((x) => x.toMap()).toList(),
      'textfieldAvailable': textfieldAvailable,
      'answer': answer == null ? [] : answer!.map((x) => x.toMap()).toList(),
    };
  }

  factory IScriptMessageData.fromMap(Map<String, dynamic> map) {
    return IScriptMessageData(
      id: map['id'] as int,
      description: map['description'] as String,
      messages: List<IScriptMessage>.from(
        (map['messages'] as List<dynamic>).map<IScriptMessage>(
          (x) => IScriptMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      textfieldAvailable: map['textfieldAvailable'] != null
          ? map['textfieldAvailable'] as bool
          : false,
      answer: map['answer'] != null
          ? List<IChatMessage>.from(
              (map['answer'] as List<dynamic>).map<IChatMessage?>(
                (x) => IChatMessage.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IScriptMessageData.fromJson(String source) =>
      IScriptMessageData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IScriptMessageData(id: $id, description: $description, messages: $messages, textfieldAvailable: $textfieldAvailable, answer: $answer)';
  }

  @override
  bool operator ==(covariant IScriptMessageData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        listEquals(other.messages, messages) &&
        other.textfieldAvailable == textfieldAvailable &&
        listEquals(other.answer, answer);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        messages.hashCode ^
        textfieldAvailable.hashCode ^
        answer.hashCode;
  }
}
