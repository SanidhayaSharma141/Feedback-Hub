// import 'package:feedback_hub/main.dart';
// import 'package:feedback_hub/models/academic_record.dart';
// import 'package:flutter/material.dart';

// class FeedbackForm extends StatefulWidget {
//   const FeedbackForm({super.key});

//   @override
//   State<FeedbackForm> createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? message;
//   AcademicRecord? acadRecord;
//   List<String>? participants;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Feedback"),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(label: Text('Hostel Name')),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the hostel name.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     hostelName = value!;
//                   },
//                 ),
//                 const SizedBox(height: 10.0),
//                 DropdownButtonFormField(
//                   decoration: const InputDecoration(label: Text('Hostel Type')),
//                   items: dropdownItems,
//                   value: 'Boys',
//                   onChanged: (value) {
//                     setState(() {
//                       hostelType = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a hostel type.';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10.0),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Capacity'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the capacity.';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid number.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     capacity = int.parse(value!);
//                   },
//                 ),
//                 const SizedBox(height: 10.0),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: 'Number of Floors/Blocks'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the number of floors or blocks.';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid number.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     numberOfFloorsorBlocks = int.parse(value!);
//                   },
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   child: const Text(
//                     'Add Hostel',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
