import 'dart:convert';
import '../../config/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile3d1/page/updateDataUserView.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  List _listData = [];

  Future _getData() async {
    try {
      final respon = await http.get(Uri.parse(Api.getDataUser));
      if (respon.statusCode == 200) {
        var data = jsonDecode(respon.body)['result'];
        print(data);
        setState(() => _listData = data);
      } else {
        print(respon.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future _delete(String id) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteDataUser),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'id': id});
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          print("$responseBody['result']");
        } else {
          print("$responseBody['result']");
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => Text("Server eror"),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
            columns: [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Password')),
              DataColumn(label: Text('Aksi')),
            ],
            rows: List<DataRow>.generate(
                _listData.length,
                (index) => DataRow(cells: [
                      DataCell(Text(_listData[index]['id'])),
                      DataCell(Text(_listData[index]['username'])),
                      DataCell(Text(_listData[index]['email'])),
                      DataCell(Text(_listData[index]['password'])),
                      DataCell(Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateUserView(
                                    userData: _listData[index],
                                  ),
                                )),
                            child: Text('Edit'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton( //* menambahkan ini
                            onPressed: () {
                              _delete(_listData[index]['id']);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserView(),
                                  ));
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      )),
                    ]))),
      ),
    );
  }
}
