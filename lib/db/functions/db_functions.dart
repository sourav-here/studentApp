// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:student_list/model/data_model.dart';
// import 'package:student_list/liststudent.dart';
// import 'package:student_list/uistudent.dart';



// import 'package:hive/hive.dart';

// List<Map<String, dynamic>> students = [];
//   final studentList = Hive.box("student_list");

//   void reprint() {
//     final data = studentList.keys.map((key) {
//       final student = studentList.get(key);
//       return {
//         "key": key,
//         "name": student['name'],
//         "age": student['age'],
//         "number": student['number'],
//         'address': student['address']
//       };
//     }).toList();

//     setState(() {
//       students = data.reversed.toList();
//     });
//   }

//   Future<void> saveStudent(Map<String, dynamic> newStudent) async {
//     await studentList.add(newStudent);
//     reprint();
//   }

//   Future<void> updateStudent(int itemKey, Map<String, dynamic> student) async {
//     await studentList.put(itemKey, student);
//     reprint();
//   }
//   Future<dynamic> deleteStudent(int index) async {
//     await studentList.delete(index);
//     reprint();

//   }


//  Future getImageFromGallery() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {}
//     });
//   }

//   Future getImageFromCamera() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {}
//     });
//   }

//   void _reprint() {
//     final data = _studentList.keys.map((key) {
//       final student = _studentList.get(key);
//       return {
//         "key": key,
//         "name": student['name'],
//         "age": student['age'],
//         "number": student['number'],
//         'address': student['address']
//       };
//     }).toList();

//     setState(() {
//       _students = data.reversed.toList();
//       print(_students.length);
//     });
//   }

//   Future<void> _saveStudent(Map<String, dynamic> newStudent) async {
//     await _studentList.add(newStudent);
//     _reprint();
//   }

//   Future<void> _updateStudent(int itemKey, Map<String, dynamic> student) async {
//     await _studentList.put(itemKey, student);
//     _reprint();
//   }

//   Future<void> _deleteStudent(int itemKey) async {
//     await _studentList.delete(itemKey);
//     _reprint();

//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text('Student deleted')));
//   }

