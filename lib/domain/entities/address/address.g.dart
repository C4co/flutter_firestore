// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      streetName: json['streetName'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      cep: json['cep'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'streetName': instance.streetName,
      'city': instance.city,
      'district': instance.district,
      'cep': instance.cep,
      'number': instance.number,
    };
