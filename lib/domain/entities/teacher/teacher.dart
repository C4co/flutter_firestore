import 'package:json_annotation/json_annotation.dart';
import '/domain/domain.dart';

part 'teacher.g.dart';

@JsonSerializable(explicitToJson: true)
class Teacher extends Person {
  late String registration;
  late List<String> classes = [];

  Teacher({
    required super.name,
    required super.email,
    required super.cpf,
    required super.birthDate,
    required super.address,
    required String registration,
  });

  addDiscipline({required String classRoomId}) {
    classes.add(classRoomId);
  }

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
