import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/db/model/data_model.dart';

class EditScreen extends StatefulWidget {
  EditScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.number,
      required this.address,
      required this.index,
      this.imagePath});

  final String name;
  final int age;
  final int number;
  final String address;
  final int index;

  dynamic imagePath;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();

  File? _image;

  @override
  void initState() {
    _nameController.text = widget.name;
    _ageController.text = widget.age.toString();
    _numberController.text = widget.number.toString();
    _addressController.text = widget.address;
    // _imagePick = widget.imagePath != '' ? File(widget.imagePath) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 79, 244, 79),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 79, 244, 79),
        title: const Text("EDIT STUDENT"),
      ),
      body: Form(
        key: _formKey,
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
              const Positioned(
                child: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.add_a_photo ,
                  color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true),
                ],
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Age';
                  }
                  return null;
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Phone number';
                  }
                  return null;
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
                    ),
                  ),
                  hintText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Address';
                  }
                  return null;
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
                  if (_formKey.currentState!.validate()) {
                    updateDetails();
                    clearText();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Color.fromARGB(255, 79, 244, 79),
                  ),
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
                  'Back',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Color.fromARGB(255, 79, 244, 79),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  void clearText() {
    _nameController.clear();
    _ageController.clear();
    _numberController.clear();
    _addressController.clear();
    setState(() {
      _image = null;
    });
  }

  Future<void> updateDetails() async {
    final newname = _nameController.text.trim();
    final newage = _ageController.text.trim();
    final newplace = _addressController.text.trim();
    final newphone = _numberController.text.trim();
    // final newimage = _image!.path;

    if (newname.isEmpty ||
        newage.isEmpty ||
        newplace.isEmpty ||
        newphone.isEmpty 
        ) {
      return;
    } else {
      final update = StudentModel(
          name: newname,
          age: int.parse(newage),
          address: newplace,
          number: int.parse(newphone),
          
          key: null);

      updateStudent(widget.index, update);
      Navigator.pop(context);
    }
  }

  void _getNewImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicker =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker == null) return;
    setState(() {
      _image = File(imagePicker.path);
    });
  }
}
