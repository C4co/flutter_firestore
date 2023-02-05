// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      birthDate: json['birthDate'] as int,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cpf': instance.cpf,
      'birthDate': instance.birthDate,
      'address': instance.address.toJson(),
    };
