// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as String?,
      name: json['name'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..teachers =
          (json['teachers'] as List<dynamic>).map((e) => e as String).toList()
      ..students =
          (json['students'] as List<dynamic>).map((e) => e as String).toList()
      ..classes =
          (json['classes'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address.toJson(),
      'teachers': instance.teachers,
      'students': instance.students,
      'classes': instance.classes,
    };
