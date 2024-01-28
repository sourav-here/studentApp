import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


class DisplayStudentDetails extends StatelessWidget {
  final String name;
  final String age;
  final String address;
  final String number;
  // final String imagePath;

  const DisplayStudentDetails({
    super.key,
    required this.name,
    required this.age,
    required this.address,
    required this.number,
    // required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 244, 79),
        title: const Center(child: Text("D E T A I L S")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 79, 244, 79),
              ),
              child: const CircleAvatar(
                radius: 80,
                backgroundImage:
                    AssetImage("assets/user-3296.png"),
              ),
            ),
            const SizedBox(height: 5),
            Details(
              title: 'Name',
              content: name,
            ),
            const SizedBox(
              height: 10,
            ),
            Details(
              title: 'Age',
              content: age,
            ),
            const SizedBox(
              height: 10,
            ),
            Details(
              title: 'Address',
              content: address,
            ),
            const SizedBox(
              height: 10,
            ),
            Details(
              title: 'Number',
              content: number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 79, 244, 79),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Back",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20,color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String title;
  final String content;

  const Details({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: const Color.fromARGB(255, 79, 244, 79),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
