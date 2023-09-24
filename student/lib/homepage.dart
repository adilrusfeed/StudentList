// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:student/searchfunction.dart';
import 'package:flutter/material.dart';
import 'addstudent.dart';
import 'Studentdetailpage.dart';
import 'db/data.dart';
import 'editstudent.dart';
import 'models/student.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StudentRepository studentRepository = StudentRepository();
  List<Student> students = [];
  String searchQuery = '';

  // Function to refresh the home screen
  Future<void> refreshHomeScreen() async {
    setState(() {
      students = studentRepository.getAllStudent();
    });
  }

  @override
  void initState() {
    super.initState();
    students = studentRepository.getAllStudent();
  }

  void searchStudents(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Student> filterStudents() {
    return students.where((student) {
      final nameLower = student.name.toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Student> filteredStudents = filterStudents();

    refreshHomeScreen();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Student Data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: StudentSearchDelegate(students, searchStudents),
              );
              if (query != null) {
                searchStudents(query);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh), // Refresh icon
            onPressed: () {
              // Trigger the refresh here
              refreshHomeScreen();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredStudents.length,
        itemBuilder: (context, index) {
          final Student student = filteredStudents[index];

          return Container(
            height: 70,
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 255, 255, 255),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 30.8,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    backgroundImage: student.image != null
                        ? FileImage(File(student.image))
                        : null,
                    child: student.image == null
                        ? Icon(Icons.image, size: 30)
                        : null,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(student.name),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: IconButton(
                        color: Color.fromARGB(255, 0, 0, 0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditStudentPage(student: student)),
                          );
                        },
                        tooltip: 'Edit',
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                title: Text(
                                  'Confirm Deletion!',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: Text(
                                  'Are you sure you want to delete this student?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      int studentIndex =
                                          students.indexOf(student);
                                      studentRepository
                                          .deleteStudent(studentIndex);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        tooltip: 'Delete',
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailPage(student: student)),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addstudent()),
            );
          },
          label: Text(
            "Add Student",
            style: TextStyle(fontSize: 14),
          ),
          icon: Icon(Icons.add),
          tooltip: 'Add Student',
          splashColor: Colors.amber,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 191, 0),
    );
  }
}
