// // import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:student_list/model/data_model.dart';
// import 'liststudent.dart';
// import 'uistudent.dart';

// class ShowStudent extends StatefulWidget {
//   const ShowStudent({super.key});

//   @override
//   State<ShowStudent> createState() => _ShowStudentState();
// }

// class _ShowStudentState extends State<ShowStudent> {

//    void callDisplayFunction(BuildContext context, int? itemKey) {
//     // Create an instance of HomePage
//     HomePage homePage = HomePage();
//     homePage._display(context, itemKey);
//     }
//   bool _isSearch = false;
//   List<Map<String, dynamic>> _students = [];
//   final _studentList = Hive.box("student_list");
//   final TextEditingController _searchController = TextEditingController();

//   void _display(){
//     Null;
//   }

//   void _toggleSearch() {
//     setState(() {
//       _isSearch = !_isSearch;
//       if (!_isSearch) {
//         _searchController.clear();
//       }
//     });
//   }

//   void _searchStudent() {
//     String searchTerm = _searchController.text.toLowerCase();

//     final filteredStudents = _students.where((student) {
//       return student['name'].toLowerCase().contains(searchTerm) ||
//           student['age'].toString().contains(searchTerm) ||
//           student['number'].contains(searchTerm) ||
//           student['address'].toLowerCase().contains(searchTerm);
//     }).toList();

//     setState(() {
//       _students = filteredStudents;
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
//     });
//   }

//   Future<dynamic> _deleteStudent(int index) async {
//     await _studentList.delete(index);
//     _reprint();

//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text('Student deleted')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: _isSearch ? _buildSearchAppBar() : _buildNormalAppBar(),
//         body: ListView.builder(
//           itemCount: _students.length,
//           itemBuilder: (context, index) {
//             final currentStudent = _students[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => DisplayStudentDetails(
//                           name: currentStudent['name'],
//                           age: currentStudent['age'].toString(),
//                           number: currentStudent['number'],
//                           address: currentStudent['address'],
//                           // imagePath: currentStudent['image'],
//                         )));
//               },
//               child: Card(
//                 color: const Color.fromARGB(255, 79, 244, 79),
//                 margin: const EdgeInsets.all(10),
//                 elevation: 3,
//                 child: ListTile(
//                   leading: const
//                       //  CircleAvatar(
//                       //     backgroundImage: _pickedImagePath != null
//                       //         ? FileImage(File(_pickedImagePath!))
//                       //         : AssetImage('assets/user-3296.png')),

//                       CircleAvatar(
//                           // backgroundImage: _pickedImagePath != null
//                           //     ? FileImage(_pickedImagePath!)
//                           //     : AssetImage("assets/user-3296.png") as ImageProvider,
//                           ),
//                   title: Text(currentStudent['name']),
//                   subtitle: Text(currentStudent['age'].toString()),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () =>
//                               _display(context, currentStudent['key']),
//                           icon: const Icon(Icons.edit)),
//                       IconButton(
//                           onPressed: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                       scrollable: true,
//                                       title: const Text('Delete'),
//                                       content: const Text('Confirm?'),
//                                       actions: [
//                                         ElevatedButton(
//                                             onPressed: () {
//                                               _deleteStudent(
//                                                   currentStudent['key']);
//                                               var isDeleted = true;
//                                               if (isDeleted == true) {
//                                                 Navigator.pop(context);
//                                               }
//                                             },
//                                             child: const Text("Ok")),
//                                         TextButton(
//                                             onPressed: () =>
//                                                 Navigator.pop(context),
//                                             child: const Text("No"))
//                                       ],
//                                     ));
//                           },
//                           icon: const Icon(Icons.delete)),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _display(context, null),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }

//   AppBar _buildNormalAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: const Text('S T U D E N T S'),
//       backgroundColor: const Color.fromARGB(255, 79, 244, 79),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: _toggleSearch,
//         ),
//       ],
//     );
//   }

//   AppBar _buildSearchAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color.fromARGB(255, 79, 244, 79),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: _toggleSearch,
//       ),
//       title: TextFormField(
//         controller: _searchController,
//         decoration: const InputDecoration(
//           hintText: 'Search here...',
//           border: InputBorder.none,
//         ),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => const HomePage())),

//             // Navigator.pop(context),
//             icon: const Icon(Icons.close)),
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () => _searchStudent(),
//         ),
//       ],
//     );
//   }
// }
