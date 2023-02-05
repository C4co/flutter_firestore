// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRoom _$ClassRoomFromJson(Map<String, dynamic> json) => ClassRoom(
      number: json['number'] as int,
      name: json['name'] as String,
      teacherId: json['teacherId'] as String,
      students:
          (json['students'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClassRoomToJson(ClassRoom instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'teacherId': instance.teacherId,
      'students': instance.students,
    };
