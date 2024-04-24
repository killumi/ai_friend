// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
part 'i_script_message.g.dart';

@HiveType(typeId: 0)
class IScriptMessage extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isPremium;

  @HiveField(2)
  final int points;

  @HiveField(3)
  final bool? isScriptBot;

  @HiveField(4)
  final String? action;

  @HiveField(5)
  final List<IChatMessage>? answer;

  IScriptMessage({
    required this.text,
    required this.isPremium,
    required this.points,
    this.isScriptBot,
    this.action,
    this.answer,
  });

  IScriptMessage copyWith({
    String? text,
    bool? isPremium,
    int? points,
    bool? isScriptBot,
    String? action,
    List<IChatMessage>? answer,
  }) {
    return IScriptMessage(
      text: text ?? this.text,
      isPremium: isPremium ?? this.isPremium,
      points: points ?? this.points,
      isScriptBot: isScriptBot ?? this.isScriptBot,
      action: action ?? this.action,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isPremium': isPremium,
      'points': points,
      'isScriptBot': isScriptBot,
      'action': action ?? '',
      'answer': answer == null ? [] : answer!.map((x) => x.toMap()).toList(),
    };
  }

  factory IScriptMessage.fromMap(Map<String, dynamic> map) {
    return IScriptMessage(
      text: map['text'] as String,
      isPremium: map['isPremium'] as bool,
      points: map['points'] as int,
      isScriptBot:
          map['isScriptBot'] != null ? map['isScriptBot'] as bool : null,
      action: map['action'] != null ? map['action'] as String : '',
      answer: map['answer'] != null
          ? List<IChatMessage>.from(
              (map['answer'] as Iterable<dynamic>).map<IChatMessage?>(
                (x) => IChatMessage.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory IScriptMessage.fromJson(String source) =>
      IScriptMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IScriptMessage(text: $text, isPremium: $isPremium, points: $points, isScriptBot: $isScriptBot, action: $action, answer: $answer)';
  }

  @override
  bool operator ==(covariant IScriptMessage other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.isPremium == isPremium &&
        other.points == points &&
        other.isScriptBot == isScriptBot &&
        other.action == action &&
        listEquals(other.answer, answer);
  }

  @override
  int get hashCode {
    return text.hashCode ^
        isPremium.hashCode ^
        points.hashCode ^
        isScriptBot.hashCode ^
        action.hashCode ^
        answer.hashCode;
  }
}
