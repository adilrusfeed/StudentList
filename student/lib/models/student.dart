import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 1)
class Student {
  Student(
      {required this.name,
      required this.classs,
      required this.birth,
      required this.image});
  @HiveField(0)
  String name;

  @HiveField(1)
  dynamic classs;

  @HiveField(2)
  String birth;

  @HiveField(3)
  dynamic image;


}
