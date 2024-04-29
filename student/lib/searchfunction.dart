import 'package:student/screens/homepage.dart';
import 'package:flutter/material.dart';

import 'models/student.dart';

class StudentSearchDelegate extends SearchDelegate<String> {
  final List<Student> students;
  final Function(String) onSearch;

  StudentSearchDelegate(this.students, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final Student student = students[index];
        return ListTile(
          title: Text(student.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Student> suggestionList = students.where((student) {
      final nameLower = student.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final Student student = suggestionList[index];
        return ListTile(
          textColor: Color.fromARGB(255, 43, 0, 255),
          title: Text(student.name),
          onTap: () {
            onSearch(student.name);
            close(context, student.name);
          },
        );
      },
    );
  }
}
