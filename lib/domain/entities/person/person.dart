import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  final String id;
  final String name;
  final String email;
  final String image;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
