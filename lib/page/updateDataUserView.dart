import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile3_app/config/Api.dart';
import 'package:mobile3_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:mobile3_app/page/userview.dart';

class UpdateDataUserView extends StatefulWidget {
  const UpdateDataUserView({super.key, this.userData});

  final Map<String, dynamic>? userData; //* tanda ? adalah null safety

  @override
  State<UpdateDataUserView> createState() => _UpdateDataUserView();
}

class _UpdateDataUserView extends State<UpdateDataUserView> {
  @override
  void initState() {
    super.initState();
    _controllerName.text = widget.userData!['username']?? '';
    _controllerEmail.text = widget.userData!['username']?? '';
    id = widget.userData!['id'].toString() ?? '';
  }
  
  String id = '';
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

    Future<void> updateDataApi() async { //* ndak tau perlu idnya jadi String
      if (!_formKey.currentState!.validate()) {
        //* Jika validasi gagal, fungsi tidak dilanjutkan.
        return;
      }
      User user = User(int.parse(id),_controllerName.text, _controllerEmail.text, _controllerPassword.text); //* Objek User dibuat dengan nilai dari tiga kolom input.
      try {
        var response = await http.post(Uri.parse(Api.updateDataApi),
          headers: {'Content-type': 'application/x-www-form-urlencoded'}, //* Header Content-type: application/x-www-form-urlencoded memberi tahu server bahwa data dikirim dalam format application/x-www-form-urlencoded, format yang umum untuk mengirim data form dalam HTTP.
          body: user.toJson(),
        );
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body); // jsonDecode(response.body): Jika permintaan berhasil, response.body berisi respons dalam format JSON. Fungsi jsonDecode mengubah JSON string menjadi objek Map<String, dynamic> yang dapat digunakan dalam kode.
          if (responseBody['status'] == 200) {
            // Memeriksa apakah respons dari server juga menunjukkan keberhasilan (misalnya, server mengembalikan status: 200 dalam JSON).
            print("$responseBody['result']");
            Navigator.pushReplacement(
              context, MaterialPageRoute(
                builder: (context) => Userview()
              )
            );
          } else {
            print("$responseBody['result']");
          }
        } else {
          print(response);
        }
      } catch (e) {
        print(e);
      }
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Insert Data'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Userview()));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField( //* TEXTFORMFIELD NAME
                  controller: _controllerName,
                  validator: (value) {
                    (value == null || value.isEmpty) ? 'harus di isi' : null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'input username',
                    contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField( //* TEXTFORMFIELD EMAIL
                  controller: _controllerEmail,
                  validator: (value) {
                    (value == null || value.isEmpty) ? 'harus di isi' : null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), //* ICON UNTUK EMAIL
                    hintText: 'input Email',
                    contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField( //* TEXTFORMFIELD PASSWORD
                  controller: _controllerPassword,
                  validator: (value) {
                    (value == null || value.isEmpty) ? 'harus di isi' : null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key), //* ICON UNTUK PASSWORD
                    hintText: 'input password',
                    contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                // ElevatedButton.icon(
                //   onPressed: () => updateDataApi(),
                //   label: Text('Register'),
                //   icon: Icon(Icons.app_registration),
                // ),
                ElevatedButton.icon( //* menambahkan ini
                  onPressed: () {
                    updateDataApi();
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(
                        builder: (context) => Userview()
                      ),
                    );
                  },
                  label: Text('Register'),
                  icon: Icon(Icons.app_registration_rounded),
                ),
              ],
            ),
          ),
        ));
  }
}
