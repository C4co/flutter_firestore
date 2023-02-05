// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      birthDate: json['birthDate'] as int,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      registration: json['registration'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cpf': instance.cpf,
      'birthDate': instance.birthDate,
      'address': instance.address.toJson(),
      'registration': instance.registration,
    };
