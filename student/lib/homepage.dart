import 'dart:io';
import 'package:student/searchfunction.dart';
import 'package:flutter/material.dart';
import 'AddStudent.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text("studentKart"),
        backgroundColor: Color.fromARGB(255, 151, 60, 255),
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
              color: Color.fromARGB(255, 153, 74, 255),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.8,
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  backgroundImage: student.image != null
                      ? FileImage(File(student.image))
                      : null,
                  child: student.image == null
                      ? Icon(Icons.image, size: 30)
                      : null,
                ),
                title: Text(student.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditStudentPage(student: student)),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 202, 174, 255),
                              title: Text('Confirm Deletion'),
                              content: Text(
                                  'Are you sure you want to delete this student?'),
                              elevation: 25,
                              shadowColor: Color.fromARGB(255, 255, 0, 0),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    int studentIndex =
                                        students.indexOf(student);
                                    studentRepository
                                        .deleteStudent(studentIndex);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 157, 68, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addstudent()),
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 210, 194, 239),
    );
  }
}
