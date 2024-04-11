// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
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

  IScriptMessage({
    required this.text,
    required this.isPremium,
    required this.points,
    this.isScriptBot,
    this.action,
  });

  IScriptMessage copyWith({
    String? text,
    bool? isPremium,
    int? points,
    bool? isScriptBot,
    String? action,
  }) {
    return IScriptMessage(
      text: text ?? this.text,
      isPremium: isPremium ?? this.isPremium,
      points: points ?? this.points,
      isScriptBot: isScriptBot ?? this.isScriptBot,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isPremium': isPremium,
      'points': points,
      'isScriptBot': isScriptBot,
      'action': action,
    };
  }

  factory IScriptMessage.fromMap(Map<String, dynamic> map) {
    return IScriptMessage(
      text: map['text'] as String,
      isPremium: map['isPremium'] as bool,
      points: map['points'] as int,
      isScriptBot:
          map['isScriptBot'] != null ? map['isScriptBot'] as bool : true,
      action: map['action'] != null ? map['action'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IScriptMessage.fromJson(String source) =>
      IScriptMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IScriptMessage(text: $text, isPremium: $isPremium, points: $points, isScriptBot: $isScriptBot, action: $action)';
  }

  @override
  bool operator ==(covariant IScriptMessage other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.isPremium == isPremium &&
        other.points == points &&
        other.isScriptBot == isScriptBot &&
        other.action == action;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        isPremium.hashCode ^
        points.hashCode ^
        isScriptBot.hashCode ^
        action.hashCode;
  }
}
