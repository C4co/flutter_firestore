// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      name: json['name'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      birthDate: json['birthDate'] as int,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      registration: json['registration'] as String,
    )..classes =
        (json['classes'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cpf': instance.cpf,
      'birthDate': instance.birthDate,
      'address': instance.address.toJson(),
      'registration': instance.registration,
      'classes': instance.classes,
    };
