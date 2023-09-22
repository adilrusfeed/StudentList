import 'package:student/models/student.dart';

import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 180, 49, 255),
        title: Text('Student Details'),
      ),
      body: Center(
        child: Container(
          height: 350,
          child: Card(
            color: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 25,
            shadowColor: Color.fromARGB(255, 185, 34, 255),
            margin: EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundColor: const Color.fromARGB(255, 143, 87, 87),
                  ),
                  SizedBox(height: 20),
                  Text('Name: ${student.name}'),
                  Text('Class: ${student.classs}'),
                  Text('Birthday: ${student.birth}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
