import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/db/model/data_model.dart';
import 'package:student_list/screens/widgets/studentfields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   _nameController.text = widget.name;
  //   _ageController.text = widget.age.toString();
  //   _numberController.text = widget.number.toString();
  //   _addressController.text = widget.address;
  //   super.initState();
  // }

  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _searchController = TextEditingController();

  void display(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 5,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
          color: Color.fromARGB(255, 79, 244, 79),
        ),
        height: 750,
        child: Form(
          key: _formkey,
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
                  icon: Icon(Icons.add_a_photo),
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
                  if (_formkey.currentState!.validate()) {
                    addButtonClicked();
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 79, 244, 79),
          title: const Center(child: Text("S T U D E N T")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 79, 244, 79),
          onPressed: () {
            display(context);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: const StudentUi());
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

  Future<void> addButtonClicked() async {
    final value = StudentModel(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        number: int.parse(_numberController.text),
        address: _addressController.text,
        // image: _image!.path,
        key: null);
    saveStudent(value);
    Navigator.pop(context);
  }

  void _getImage() async {
    final ImagePicker picker = ImagePicker();
    final File? imagePicker =
        (await picker.pickImage(source: ImageSource.gallery)) as File?;
    if (imagePicker == null) return;
    setState(() {
      _image = File(imagePicker.path);
    });
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: _isSearch ? _buildSearchAppBar() : _buildNormalAppBar(),
//         body: ListView.builder(
//           itemCount: students.length,
//           itemBuilder: (context, index) {
//             final currentStudent = students[index];
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
//                   leading: CircleAvatar(
//                     backgroundImage: _image != null ? FileImage(_image!) : null,
//                     child: _image == null
//                         ? const Icon(
//                             Icons.person,
//                           )
//                         : null,
//                   ),
//                   title: Text(currentStudent['name']),
//                   subtitle: Text(currentStudent['age'].toString()),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () =>
//                               display(context, currentStudent['key']),
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
//                                               deleteStudent(
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
//           onPressed: () => display(context, null),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }

//   _buildNormalAppBar() {
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

//   _buildSearchAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color.fromARGB(255, 79, 244, 79),
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
//             icon: const Icon(Icons.close)),
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () => searchStudent(),
//         ),
//       ],
//     );
//   }
// }