import 'package:hive/hive.dart';
import 'package:student/models/student.dart';

class StudentRepository {
  final Box<Student> _studentBox = Hive.box<Student>('studentbox');

  List<Student> getAllStudent() {
    return _studentBox.values.toList();
  }

  void addStudent(Student student) {
    _studentBox.add(student);
  }

  void updateStudent(Student updatedStudent) {
    final studentIndex =
        _studentBox.values.toList().indexWhere((student) => student == student);
    if (studentIndex != -1) {
      _studentBox.putAt(studentIndex, updatedStudent);
    }
  }

  void deleteStudent(int index) {
    _studentBox.deleteAt(index);
  }
}
