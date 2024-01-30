import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomSheetWidget {
  static void show(
    BuildContext context,
    File? image,
    Function setImage,
    Function getImageFromGallery,
    TextEditingController nameController,
    TextEditingController ageController,
    TextEditingController numberController,
    TextEditingController addressController,
    GlobalKey<FormState> formKey,
    Function saveOrUpdateStudent,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 5,
      builder: (_) => Container(
        key: formKey,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
          color: Color.fromARGB(255, 79, 244, 79),
        ),
        height: 750,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: image != null ? FileImage(image) : null,
                child: image == null
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
                controller: nameController,
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
                controller: ageController,
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
                controller: numberController,
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
                controller: addressController,
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
                  if (formKey.currentState?.validate() == true) {
                    saveOrUpdateStudent();
                    nameController.text = '';
                    ageController.text = '';
                    numberController.text = '';
                    addressController.text = '';
                    Navigator.of(context).pop();
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
}
