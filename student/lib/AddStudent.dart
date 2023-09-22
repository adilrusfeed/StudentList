// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Studentdetailpage.dart';
import 'db/data.dart';
import 'models/student.dart';

class Addstudent extends StatefulWidget {
  @override
  _AddstudentState createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final StudentRepository studentRepository = StudentRepository();

  // images function
  final ImagePicker imagePicker = ImagePicker();
  PickedFile? pickedImage;

  Future<void> _pickImage() async {
    final picked = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 188, 54, 255),
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialButton(
              color: Color.fromARGB(255, 163, 54, 242),
              onPressed: _pickImage,
              child: Text("Add Image"),
            ),
            pickedImage != null
                ? Image.file(
                    File(pickedImage!.path),
                    width: 100,
                    height: 100,
                  )
                : Container(),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: classController,
              decoration: InputDecoration(
                labelText: 'Class',
              ),
            ),
            TextField(
              controller: birthController,
              decoration: InputDecoration(
                labelText: 'D.O.B',
              ),
            ),
            SizedBox(height: 16),
            MaterialButton(
              color: Color.fromARGB(255, 163, 54, 242),
              onPressed: () {
                final Student newStudent = Student(
                  image: pickedImage?.path ?? '',
                  name: nameController.text,
                  classs: classController.text,
                  birth: birthController.text,
                );

                studentRepository.addStudent(newStudent);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          StudentDetailPage(student: newStudent)),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 203, 255),
    );
  }
}
