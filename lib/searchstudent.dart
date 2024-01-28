// // import 'package:flutter/material.dart';

// // class SearchStudentPage extends StatelessWidget {
// //   final TextEditingController _searchController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: TextField(
// //           controller: _searchController,
// //           decoration: const InputDecoration(
// //             hintText: 'Search student...',
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.search),
// //             onPressed: () {
// //               String searchText = _searchController.text;
// //               // Call a function to search and display details from the database
// //               // You may implement this function according to your database structure
// //               // For example: _searchStudentDetails(searchText);
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Center(
// //         child: Text('Search Student Page'),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class SearchStudentPage extends StatefulWidget {
//   const SearchStudentPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _SearchStudentPageState createState() => _SearchStudentPageState();
// }

// class _SearchStudentPageState extends State<SearchStudentPage> {
//   final TextEditingController _searchController = TextEditingController();

//   // Create your searchStudent function here

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           decoration: const InputDecoration(
//             hintText: 'Search Student',
//             border: InputBorder.none,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Call your searchStudent function here
//             },
//             icon: const Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: Container(
//         // Implement your search results display here
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'uistudent.dart';

// class SearchPage extends StatelessWidget {
//   final Function toggleSearch;
//   final Function searchStudent;
//   final TextEditingController searchController;

//   const SearchPage({
//     required this.toggleSearch,
//     required this.searchStudent,
//     required this.searchController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color.fromARGB(255, 79, 244, 79),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: toggleSearch,
//       ),
//       title: TextFormField(
//         controller: searchController,
//         decoration: const InputDecoration(
//           hintText: 'Search here...',
//           border: InputBorder.none,
//         ),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () =>
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const HomePage())),
//             icon: const Icon(Icons.close)),
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: searchStudent,
//         ),
//       ],
//     );
//   }
// }
