import 'package:json_annotation/json_annotation.dart';
import '/domain/domain.dart';

part 'school.g.dart';

@JsonSerializable(explicitToJson: true)
class School {
  String name;
  Address address;
  List<String> teachers = [];
  List<String> students = [];
  List<String> classes = [];

  School({
    required this.name,
    required this.address,
  });

  addTeacher(String teacher) {
    teachers.add(teacher);
  }

  addStudent(String student) {
    students.add(student);
  }

  addClassRoom(String classRoom) {
    classes.add(classRoom);
  }

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
