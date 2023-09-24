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
    return Center(
      // Center the entire form
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align items vertically at the center
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Edit Name field with an Icon
            TextFormField(
              initialValue: student.name,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person), // Customize the icon here
              ),
            ),

            // Edit Class field with an Icon
            TextFormField(
              initialValue: student.classs,
              decoration: InputDecoration(
                labelText: 'Class',
                prefixIcon: Icon(Icons.school), // Customize the icon here
              ),
            ),

            // Edit Date Of Birth field with an Icon
            TextFormField(
              initialValue: student.birth,
              decoration: InputDecoration(
                labelText: 'Date Of Birth',
                prefixIcon:
                    Icon(Icons.calendar_today), // Customize the icon here
              ),
            ),

            SizedBox(height: 22),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 92, 15, 146), // Background color
                textStyle: TextStyle(
                  fontSize: 18, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
                padding: EdgeInsets.symmetric(vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Circular border radius
                ),
              ),
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
      ),
    );
  }
}
