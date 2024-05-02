// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'i_chat_message.g.dart';

@HiveType(typeId: 3)
class IChatMessage extends HiveObject {
  @HiveField(0)
  final DateTime? date;

  @HiveField(1)
  final bool? isBot;

  // type: video/image/text
  @HiveField(2)
  final String type;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final bool isPremiumContent;

  @HiveField(5)
  final Uint8List? mediaData;

  bool get isVideo => type.contains('video');
  bool get isImage => type.contains('image');
  bool get isText => type.contains('text');

  IChatMessage({
    required this.date,
    required this.isBot,
    required this.type,
    required this.content,
    required this.isPremiumContent,
    this.mediaData,
  });

  IChatMessage copyWith({
    DateTime? date,
    bool? isBot,
    String? type,
    String? content,
    bool? isPremiumContent,
    Uint8List? mediaData,
  }) {
    return IChatMessage(
      date: date ?? this.date,
      isBot: isBot ?? this.isBot,
      type: type ?? this.type,
      content: content ?? this.content,
      isPremiumContent: isPremiumContent ?? this.isPremiumContent,
      mediaData: mediaData ?? this.mediaData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'isBot': isBot,
      'type': type,
      'content': content,
      'isPremiumContent': isPremiumContent,
      'mediaData': mediaData,
    };
  }

  factory IChatMessage.fromMap(Map<String, dynamic> map) {
    return IChatMessage(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      isBot: map['isBot'] != null ? map['isBot'] as bool : true,
      type: map['type'] as String,
      content: map['content'] as String,
      isPremiumContent: map['isPremiumContent'] as bool,
      mediaData: map['mediaData'] != null ? map['data'] as Uint8List : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IChatMessage.fromJson(String source) =>
      IChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IChatMessage(date: $date, isBot: $isBot, type: $type, content: $content, isPremiumContent: $isPremiumContent, mediaData: $mediaData)';
  }

  @override
  bool operator ==(covariant IChatMessage other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.isBot == isBot &&
        other.type == type &&
        other.content == content &&
        other.isPremiumContent == isPremiumContent &&
        other.mediaData == mediaData;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        isBot.hashCode ^
        type.hashCode ^
        content.hashCode ^
        isPremiumContent.hashCode ^
        mediaData.hashCode;
  }
}




// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:hive/hive.dart';

// part 'i_chat_message.g.dart';

// @HiveType(typeId: 3)
// class IChatMessage extends HiveObject {
//   @HiveField(0)
//   final DateTime? date;

//   @HiveField(1)
//   final bool? isBot;

//   // type: video/image/text
//   @HiveField(2)
//   final String type;

//   @HiveField(3)
//   final String content;

//   @HiveField(4)
//   final bool isPremiumContent;

//   @HiveField(5)
//   final Uint8List? mediaData;

//   IChatMessage({
//     required this.date,
//     required this.isBot,
//     required this.type,
//     required this.content,
//     required this.isPremiumContent,
//   });

//   IChatMessage copyWith({
//     DateTime? date,
//     bool? isBot,
//     String? type,
//     String? content,
//     bool? isPremiumContent,
//   }) {
//     return IChatMessage(
//       date: date ?? this.date,
//       isBot: isBot ?? this.isBot,
//       type: type ?? this.type,
//       content: content ?? this.content,
//       isPremiumContent: isPremiumContent ?? this.isPremiumContent,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'date': date?.millisecondsSinceEpoch,
//       'isBot': isBot ?? true,
//       'type': type,
//       'content': content,
//       'isPremiumContent': isPremiumContent,
//     };
//   }

//   factory IChatMessage.fromMap(Map<String, dynamic> map) {
//     return IChatMessage(
//       date: map['date'] != null
//           ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
//           : DateTime.now(),
//       isBot: map['isBot'] != null ? map['isBot'] as bool : true,
//       type: map['type'] as String,
//       content: map['content'] as String,
//       isPremiumContent: map['isPremiumContent'] as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory IChatMessage.fromJson(String source) =>
//       IChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'IChatMessage(date: $date, isBot: $isBot, type: $type, content: $content, isPremiumContent: $isPremiumContent)';
//   }

//   @override
//   bool operator ==(covariant IChatMessage other) {
//     if (identical(this, other)) return true;

//     return other.date == date &&
//         other.isBot == isBot &&
//         other.type == type &&
//         other.content == content &&
//         other.isPremiumContent == isPremiumContent;
//   }

//   @override
//   int get hashCode {
//     return date.hashCode ^
//         isBot.hashCode ^
//         type.hashCode ^
//         content.hashCode ^
//         isPremiumContent.hashCode;
//   }
// }
