// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/models/student.dart';
import 'homepage.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Student Details'),
      ),
      body: Center(
        child: Container(
          height: 350,
          child: Card(
            color: Color.fromARGB(255, 255, 247, 0),
            child: Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 25,
              shadowColor: Color.fromARGB(255, 255, 255, 255),
              margin: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.8,
                      backgroundColor: Color.fromARGB(255, 154, 153, 153),
                      backgroundImage: student.image != null
                          ? FileImage(File(student.image))
                          : null,
                      child: student.image == null
                          ? Icon(Icons.image, size: 40)
                          : null,
                    ),
                    SizedBox(height: 20),
                    Text('Name: ${student.name}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Class: ${student.classs}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Birthday: ${student.birth}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to the homepage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Color.fromARGB(255, 0, 0, 0), // Background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32), // Increase button size
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 18, // Text size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 91, 91, 91),
    );
  }
}
