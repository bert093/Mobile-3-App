// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile3_app/config/Api.dart';

// class Userview extends StatefulWidget {
//   const Userview({super.key});

//   @override
//   State<Userview> createState() => _UserViewState();
// }

// class _UserViewState extends State<Userview> {


//   @override
//   void initState() {
//     super.initState();
//   }

//   List _listData = [];

//   Future _getData() async {
//     try {
//       final respon = await http.get(Uri.parse(Api.getDataUser));
//       if (respon.statusCode==200) {
//         var data = jsonDecode(respon.body) ['result']; //* butuh dart convert
//         print(data);
//         setState(() => _listData = data);
//       } else {
//         print(respon.statusCode);
//       } 
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User'),
//       ),
//       body: DataTable(columns: [
//         DataColumn(label: Text('id')),
//         DataColumn(label: Text('username')),
//         DataColumn(label: Text('email')),
//         DataColumn(label: Text('password')),
//       ], rows: List<DataRow>.generate(_listData.length, (index) =>
//       DataRow(
//         cells:
//         DataCell(Text(_listData[index] ['id'])),
//         DataCell(Text(_listData[index] ['id'])),
//         DataCell(Text(_listData[index] ['id'])),
//         DataCell(Text(_listData[index] ['id'])),
//         DataCell(
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Edit')
//               ),
//               SizedBox(width: 20),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('none')
//               ),
//               // SizedBox(width: 20),
//               // ElevatedButton(
//               //   onPressed: () {},
//               //   child: Text('none2'),
//               // ),
//               // SizedBox(width: 20),
//               // ElevatedButton(
//               //   onPressed: () {},
//               //   child: Text('none3'),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       )),
//     );
//   }
// }