import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile3_app/config/Api.dart';
import 'package:mobile3_app/page/register.dart';
import 'package:mobile3_app/page/updateDataUserView.dart';

class Userview extends StatefulWidget {
  const Userview({super.key});

  @override
  State<Userview> createState() => _UserViewState();
}

class _UserViewState extends State<Userview> {


  @override
  void initState() {
    super.initState();
    _getData();
  }

  List _listData = [];

  Future _getData() async {
    try {
      final respon = await http.get(Uri.parse(Api.getDataUser));
      if (respon.statusCode==200) {
        var data = jsonDecode(respon.body) ['result']; //* butuh dart convert
        print(data);
        setState(() => _listData = data);
      } else {
        print(respon.statusCode);
      } 
    } catch (e) {
      print(e);
    }
  }

    Future _deleteData(String id) async {
      try{
      var response = await http.post(Uri.parse(Api.deleteDataUser), // Mengambil URL endpoint API dari Api.register, mengonversinya ke objek Uri.
      headers: {'Content-type': 'application/x-www-form-urlencoded'}, //* Header Content-type: application/x-www-form-urlencoded memberi tahu server bahwa data dikirim dalam format application/x-www-form-urlencoded, format yang umum untuk mengirim data form dalam HTTP.
      body: ({'id' : id}), // Data pengguna diubah menjadi JSON dengan user.toJson(), yang mengonversi objek User menjadi format Map<String, dynamic> yang kompatibel dengan permintaan HTTP.
      );
      if (response.statusCode == 200) { // Memeriksa apakah server mengembalikan status 200, yang menunjukkan permintaan berhasil diproses oleh server.
        var responseBody = jsonDecode(response.body); // jsonDecode(response.body): Jika permintaan berhasil, response.body berisi respons dalam format JSON. Fungsi jsonDecode mengubah JSON string menjadi objek Map<String, dynamic> yang dapat digunakan dalam kode.
        if (responseBody['status'] == 200) { // Memeriksa apakah respons dari server juga menunjukkan keberhasilan (misalnya, server mengembalikan status: 200 dalam JSON).
          print("$responseBody['result']");
        } else {
          print("$responseBody['result']");
        }
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
        centerTitle: true,
      ),
      body: Column( //* saya wrap menjadi Column
        children: [
          SingleChildScrollView(
            child: DataTable(columns: [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Password')),
              DataColumn(label: Text('aksi')),
              // DataColumn(label: Text('dimas')),
            ], rows: List<DataRow>.generate(_listData.length, (index) =>
            DataRow(
              cells: [
                DataCell(Text(_listData[index]['id'])),
                DataCell(Text(_listData[index]['username'])),
                DataCell(Text(_listData[index]['email'])),
                DataCell(Text(_listData[index]['password'])),
                DataCell(
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(
                              builder: (context) => UpdateDataUserView(
                                userData: _listData[index],
                              ),
                            ),
                          );
                        },
                        child: Text('Update'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          _deleteData(_listData[index]['id']);
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Userview(),
                            ),
                          );
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            )),
          ),
          SizedBox(height: 15), //* saya tambahkan ini
          ElevatedButton.icon(
            onPressed: () => {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => Register(),
                ),
              ),
            },
            label: Text('Register'),
            icon: Icon(Icons.app_registration_outlined),
          )
        ],
      ),
    );
  }
}