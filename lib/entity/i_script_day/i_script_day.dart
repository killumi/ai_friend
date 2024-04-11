// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:ai_friend/entity/i_script_message_data/i_script_message_data.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'i_script_day.g.dart';

@HiveType(typeId: 2)
class IScriptDay extends HiveObject {
  @HiveField(0)
  final int day;

  @HiveField(1)
  final List<IScriptMessageData> data;

  IScriptDay({
    required this.day,
    required this.data,
  });

  IScriptDay copyWith({
    int? day,
    List<IScriptMessageData>? data,
  }) {
    return IScriptDay(
      day: day ?? this.day,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory IScriptDay.fromMap(Map<String, dynamic> map) {
    return IScriptDay(
      day: map['day'] as int,
      data: List<IScriptMessageData>.from(
        (map['data'] as Iterable<dynamic>).map<IScriptMessageData>(
          (x) => IScriptMessageData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory IScriptDay.fromJson(String source) =>
      IScriptDay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IScriptDay(day: $day, data: $data)';

  @override
  bool operator ==(covariant IScriptDay other) {
    if (identical(this, other)) return true;

    return other.day == day && listEquals(other.data, data);
  }

  @override
  int get hashCode => day.hashCode ^ data.hashCode;
}
