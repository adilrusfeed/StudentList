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
        backgroundColor: const Color.fromARGB(255, 152, 54, 244),
      ),
      body: EditStudentForm(student: student),
      backgroundColor: Color.fromARGB(255, 218, 185, 248),
    );
  }
}

class EditStudentForm extends StatelessWidget {
  final Student student;

  EditStudentForm({required this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            // initialValue: student.name,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Class',
            ),
            // initialValue: student.classs.,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Date Of Birth',
            ),
            // initialValue: student.birth,
          ),
          SizedBox(height: 16),
          MaterialButton(
            color: Color.fromARGB(255, 92, 15, 146),
            onPressed: () {
              final updatedStudent = Student(
                image: student.image,
                name: student.name,
                classs: student.classs,
                birth: student.birth,
              );

              // Update the student in Hive
              StudentRepository().updateStudent(updatedStudent);

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
    );
  }
}
