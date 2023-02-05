import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String streetName;
  String city;
  String district;
  String cep;
  String number;

  Address({
    required this.streetName,
    required this.city,
    required this.district,
    required this.cep,
    required this.number,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
