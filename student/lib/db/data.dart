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

   void updateStudent(Student originalStudent, Student updatedStudent) {
    final studentIndex =
        _studentBox.values.toList().indexWhere((student) => student == originalStudent);
    if (studentIndex != -1) {
      _studentBox.putAt(studentIndex, updatedStudent);
    }
  }

  Future<void> deleteStudent(int index) async {
    _studentBox.deleteAt(index);
  }
}
