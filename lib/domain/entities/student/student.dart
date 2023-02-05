import 'package:json_annotation/json_annotation.dart';
import '/domain/domain.dart';

part 'student.g.dart';

@JsonSerializable(explicitToJson: true)
class Student extends Person {
  late String registration;

  Student({
    required super.name,
    required super.email,
    required super.cpf,
    required super.birthDate,
    required super.address,
    required String registration,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
