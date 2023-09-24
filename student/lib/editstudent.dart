// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student/models/student.dart';
import 'package:student/db/data.dart';
import 'Studentdetailpage.dart';

class EditStudentPage extends StatelessWidget {
  final Student student;

  EditStudentPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: EditStudentForm(student: student),
      backgroundColor: Color.fromARGB(255, 195, 195, 195),
    );
  }
}

class EditStudentForm extends StatefulWidget {
  final Student student;

  EditStudentForm({required this.student});

  @override
  _EditStudentFormState createState() => _EditStudentFormState();
}

class _EditStudentFormState extends State<EditStudentForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    classController.text = widget.student.classs;
    dobController.text = widget.student.birth;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: classController,
              decoration: InputDecoration(
                labelText: 'Class',
                prefixIcon: Icon(Icons.school),
              ),
            ),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(
                labelText: 'Date Of Birth',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                final updatedStudent = Student(
                  image: widget.student.image,
                  name: nameController.text,
                  classs: classController.text,
                  birth: dobController.text,
                );

                StudentRepository()
                    .updateStudent(widget.student, updatedStudent);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentDetailPage(student: updatedStudent),
                  ),
                );
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
