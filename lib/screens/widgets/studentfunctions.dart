import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/db/model/data_model.dart';
import 'studentdetails.dart';
import 'studentfields.dart';

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
    _nameController.text = widget.name;
    _ageController.text = widget.age.toString();
    _numberController.text = widget.number.toString();
    _addressController.text = widget.address;
    super.initState();
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

  void display(BuildContext context, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          students.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _ageController.text = existingItem['age'];
      _numberController.text = existingItem['number'];
      _addressController.text = existingItem['address'];
    }

    BottomSheetWidget.show(
      context,
      _image,
      (File image) {
        setState(() {
          _image = image;
        });
      },
      getImageFromGallery,
      _nameController,
      _ageController,
      _numberController,
      _addressController,
      _formkey,
      () {
        if (itemKey == null) {
          saveStudent({
            "name": _nameController.text,
            'age': _ageController.text,
            'number': _numberController.text,
            'address': _addressController.text,
          } as StudentModel);
        }

        if (itemKey != null) {
          updateStudent(itemKey, {
            "name": _nameController.text,
            "age": _ageController.text,
            "number": _numberController.text,
            "address": _addressController.text,
          } as StudentModel);
        }
      },
    );
  }
  

  

  @override
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