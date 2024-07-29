// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'i_script_day.g.dart';

@HiveType(typeId: 2)
class IScriptDay extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<IScriptMessageData> data;

  IScriptDay({
    required this.id,
    required this.data,
  });

  IScriptDay copyWith({
    int? id,
    List<IScriptMessageData>? data,
  }) {
    return IScriptDay(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory IScriptDay.fromMap(Map<String, dynamic> map) {
    return IScriptDay(
      id: map['id'] as int,
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
  String toString() => 'IScriptDay(id: $id, data: $data)';

  @override
  bool operator ==(covariant IScriptDay other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.data, data);
  }

  @override
  int get hashCode => id.hashCode ^ data.hashCode;
}
