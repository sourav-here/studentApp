import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/db/model/data_model.dart';
import 'package:student_list/screens/widgets/editpage.dart';
import 'package:student_list/screens/widgets/studentdetails.dart';

class StudentUi extends StatefulWidget {
  const StudentUi({super.key});

  @override
  State<StudentUi> createState() => _ListUiState();
}

class _ListUiState extends State<StudentUi> {
  final _searchController = TextEditingController();
  String search = '';
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('studentList'),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final allStudents = Hive.box('studentList');
            return ValueListenableBuilder(
                valueListenable: Hive.box('studentList').listenable(),
                builder: (ctx, Box box, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 30, right: 30, bottom: 5),
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (String? value) {
                            setState(() {
                              search = value.toString();
                            });
                          },
                          style: const TextStyle(
                              color:  Color.fromARGB(255, 79, 244, 79)),
                          cursorColor: const Color.fromARGB(255, 79, 244, 79),
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Search',
                              labelStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allStudents.length,
                          itemBuilder: (context, index) {
                            final data =
                                allStudents.getAt(index) as StudentModel;
                            late String position = data.name.toString();
                            if (_searchController.text.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DisplayStudentDetails(
                                            name: data.name!,
                                            age: data.age.toString(),
                                            address: data.address,
                                            number: data.number.toString(),
                                            // imagePath: data.image!,
                                          )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: data.image != null
                                          ? FileImage(File(data.image!))
                                          : const AssetImage(
                                                  'assets/user-3296.png')
                                              as ImageProvider),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditScreen(
                                                          index: index,
                                                          name: data.name!,
                                                          age: data.age,
                                                          number: data.number,
                                                          address: data.address,
                                                          imagePath: data.image,
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(255, 79, 244, 79),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                useSafeArea: true,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      scrollable: true,
                                                      title:
                                                          const Text('Delete'),
                                                      content: const Text(
                                                          'Confirm?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        const Color
                                                                            .fromARGB(255, 79, 244, 79)),
                                                            onPressed: () {
                                                              deleteStudent(
                                                                  index);
                                                              isDeleted = true;
                                                              if (isDeleted ==
                                                                  true) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: const Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              'NO',
                                                              style: TextStyle(
                                                                  color: Color.fromARGB(255, 79, 244, 79)
                                                                      ),
                                                            ))
                                                      ],
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(255, 79, 244, 79),
                                          )),
                                    ],
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(data.name!,style: const TextStyle(color: Color.fromARGB(255, 79, 244, 79)),),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(style: const TextStyle(color: Color.fromARGB(255, 79, 244, 79)),data.age.toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if (position.toLowerCase().contains(
                                _searchController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DisplayStudentDetails(
                                            name: data.name!,
                                            age: data.age.toString(),
                                            address: data.address,
                                            number: data.number.toString(),
                                            // imagePath: data.image!,
                                          )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: data.image != null
                                          ? FileImage(File(data.image!))
                                          : const AssetImage(
                                                  'assets/user-3296.png')
                                              as ImageProvider),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditScreen(
                                                          index: index,
                                                          name: data.name!,
                                                          age: data.age,
                                                          number: data.number,
                                                          address: data.address,
                                                          imagePath: data.image,
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(255, 79, 244, 79)
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                useSafeArea: true,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      scrollable: true,
                                                      title:
                                                          const Text('Delete'),
                                                      content: const Text(
                                                          'Confirm?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey),
                                                            onPressed: () {
                                                              deleteStudent(
                                                                  index);
                                                              isDeleted = true;
                                                              if (isDeleted ==
                                                                  true) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Ok",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'No'))
                                                      ],
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(255, 79, 244, 79),
                                          )),
                                    ],
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(position),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('age: ${data.age.toString()}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
