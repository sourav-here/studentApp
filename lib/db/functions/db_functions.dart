import 'package:hive_flutter/hive_flutter.dart';

class StudentOperations {
  static List<Map<String, dynamic>> reprint(Box studentList) {
    final data = studentList.keys.map((key) {
      final student = studentList.get(key);
      return {
        "key": key,
        "name": student['name'],
        "age": student['age'],
        "number": student['number'],
        'address': student['address']
      };
    }).toList();

    return data.reversed.toList();
  }

  static Future<void> saveStudent(Box studentList, Map<String, dynamic> newStudent) async {
    await studentList.add(newStudent);
  }

  static Future<void> updateStudent(Box studentList, int itemKey, Map<String, dynamic> student) async {
    await studentList.put(itemKey, student);
  }

  static Future<void> deleteStudent(Box studentList, int index) async {
    await studentList.delete(index);
  }
}






//--------------------------------------------


 // void reprint() {
  //   final data = studentList.keys.map((key) {
  //     final student = studentList.get(key);
  //     return {
  //       "key": key,
  //       "name": student['name'],
  //       "age": student['age'],
  //       "number": student['number'],
  //       'address': student['address']
  //     };
  //   }).toList();

  //   setState(() {
  //     students = data.reversed.toList();
  //   });
  // }

  // Future<void> saveStudent(Map<String, dynamic> newStudent) async {
  //   await saveStudent(newStudent);
  //   reprint();
  // }

  // Future<void> updateStudent(int itemKey, Map<String, dynamic> student) async {
  //   await updateStudent(itemKey, student);
  //   reprint();
  // }

  // Future<dynamic> deleteStudent(int index) async {
  //   await deleteStudent(index);
  //   reprint();
  // }