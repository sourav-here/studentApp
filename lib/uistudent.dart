import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:student_list/db/functions/db_functions.dart';
// import 'package:student_list/showstudent.dart';
// import 'package:student_list/model/data_model.dart';
import 'liststudent.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearch = false;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    reprint();
  }

  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearch = !_isSearch;
      if (!_isSearch) {
        _searchController.clear();
      }
    });
  }

  void searchStudent() {
    String searchTerm = _searchController.text.toLowerCase();

    final filteredStudents = students.where((student) {
      return student['name'].toLowerCase().contains(searchTerm) ||
          student['age'].toString().contains(searchTerm) ||
          student['number'].contains(searchTerm) ||
          student['address'].toLowerCase().contains(searchTerm);
    }).toList();

    setState(() {
      students = filteredStudents;
    });
  }

  Future<void> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  List<Map<String, dynamic>> students = [];
  final studentList = Hive.box("student_list");

  void reprint() {
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

    setState(() {
      students = data.reversed.toList();
    });
  }

  Future<void> saveStudent(Map<String, dynamic> newStudent) async {
    await studentList.add(newStudent);
    reprint();
  }

  Future<void> updateStudent(int itemKey, Map<String, dynamic> student) async {
    await studentList.put(itemKey, student);
    reprint();
  }

  Future<dynamic> deleteStudent(int index) async {
    await studentList.delete(index);
    reprint();
  }

  void display(BuildContext context, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          students.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _ageController.text = existingItem['age'];
      _numberController.text = existingItem['number'];
      _addressController.text = existingItem['address'];
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        elevation: 5,
        builder: (_) => Container(
              key: _formkey,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                color: Color.fromARGB(255, 79, 244, 79),
              ),
              height: 750,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.person,
                            size: 70,
                          )
                        : null,
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: getImageFromGallery,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                          allow: true)
                    ],
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _numberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 50,
                            )),
                        hintText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size(120, 45),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (itemKey == null) {
                        saveStudent({
                          "name": _nameController.text,
                          'age': _ageController.text,
                          'number': _numberController.text,
                          'address': _addressController.text,
                        });
                      }

                      if (itemKey != null) {
                        updateStudent(itemKey, {
                          "name": _nameController.text,
                          "age": _ageController.text,
                          "number": _numberController.text,
                          "address": _addressController.text,
                        });
                      }

                      _nameController.text = '';
                      _ageController.text = '';
                      _numberController.text = '';
                      _addressController.text = '';

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      itemKey == null ? 'Create New' : 'Update',
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color: Color.fromARGB(255, 79, 244, 79)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(120, 45),
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color.fromARGB(255, 79, 244, 79)),
                      )),
                ],
              ),
            ));
  }

  @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: ShowStudent(),
  //   );
  // }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: _isSearch ? _buildSearchAppBar() : _buildNormalAppBar(),
        body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final currentStudent = students[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DisplayStudentDetails(
                          name: currentStudent['name'],
                          age: currentStudent['age'].toString(),
                          number: currentStudent['number'],
                          address: currentStudent['address'],
                          // imagePath: currentStudent['image'],
                        )));
              },
              child: Card(
                color: const Color.fromARGB(255, 79, 244, 79),
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.person,
                          )
                        : null,
                  ),
                  title: Text(currentStudent['name']),
                  subtitle: Text(currentStudent['age'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () =>
                              display(context, currentStudent['key']),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      scrollable: true,
                                      title: const Text('Delete'),
                                      content: const Text('Confirm?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              deleteStudent(
                                                  currentStudent['key']);
                                              var isDeleted = true;
                                              if (isDeleted == true) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Ok")),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("No"))
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => display(context, null),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _buildNormalAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('S T U D E N T S'),
      backgroundColor: const Color.fromARGB(255, 79, 244, 79),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }

  _buildSearchAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 79, 244, 79),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _toggleSearch,
      ),
      title: TextFormField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search here...',
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage())),
            icon: const Icon(Icons.close)),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => searchStudent(),
        ),
      ],
    );
  }
}
