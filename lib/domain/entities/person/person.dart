import 'package:json_annotation/json_annotation.dart';
import '/domain/domain.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  String name;
  String email;
  String cpf;
  int birthDate;
  Address address;

  Person({
    required this.name,
    required this.email,
    required this.cpf,
    required this.birthDate,
    required this.address,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
