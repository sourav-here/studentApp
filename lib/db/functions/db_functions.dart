import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);


Future<void> saveStudent(StudentModel value) async {
  final studentList = await Hive.openBox<StudentModel>('student_list');
  await studentList.add(value);
}

Future<void> updateStudent(index, StudentModel value) async {
  final studentList = await Hive.openBox<StudentModel>('student_list');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentList.values);

  await studentList.putAt(index, value);
  getStudents();
}

Future<void> deleteStudent(int index) async {
  final studentList = await Hive.openBox<StudentModel>('student_list');
  await studentList.deleteAt(index);

  getStudents();
}

Future<void> getStudents() async {
  final studentlist = await Hive.openBox<StudentModel>('Student_list');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentlist.values);
}
