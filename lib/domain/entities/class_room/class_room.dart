import 'package:json_annotation/json_annotation.dart';

part 'class_room.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassRoom {
  int number;
  String name;
  String teacherId;
  List<String> students;

  ClassRoom({
    required this.number,
    required this.name,
    required this.teacherId,
    required this.students,
  });

  factory ClassRoom.fromJson(Map<String, dynamic> json) =>
      _$ClassRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ClassRoomToJson(this);
}
