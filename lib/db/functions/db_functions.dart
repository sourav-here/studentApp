import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);


void saveStudent(StudentModel value) {
  final studentList = Hive.box('studentList');

  studentList.add(value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

void updateStudent(index, StudentModel value) {
  final studentData = Hive.box('studentList');
  studentListNotifier.notifyListeners();
  studentData.putAt(index, value);
}

void deleteStudent(int index) {
  final studentList = Hive.box('studentList');
  studentList.deleteAt(index);
  studentListNotifier.notifyListeners();
}
