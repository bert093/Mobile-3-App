import 'dart:convert'; // convert ke json
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Package http
import 'package:mobile3_app/config/Api.dart'; // file Api.dart
import 'package:mobile3_app/model/user.dart';
import 'package:mobile3_app/page/userview.dart'; // file user.dart

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _controllerName = TextEditingController(); // TextEditingController digunakan untuk mengambil input dari kolom teks:
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // untuk validasi form. (formKey memungkinkan kita untuk memeriksa apakah form sudah diisi dengan benar atau belum.)

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) { //* Jika validasi gagal, fungsi tidak dilanjutkan.
      return;
    }
    User user = User(0, _controllerName.text, _controllerEmail.text, _controllerPassword.text); //* Objek User dibuat dengan nilai dari tiga kolom input.
    // await: Kode ini dijalankan secara asinkron sehingga aplikasi tidak akan mengalami lag saat menunggu respons server. await menghentikan eksekusi fungsi hingga respons diterima.
    // http.post: Fungsi ini mengirim permintaan HTTP POST ke server dengan URL yang diberikan.
    try{
      var response = await http.post(Uri.parse(Api.register), // Mengambil URL endpoint API dari Api.register, mengonversinya ke objek Uri.
      headers: {'Content-type': 'application/x-www-form-urlencoded'}, //* Header Content-type: application/x-www-form-urlencoded memberi tahu server bahwa data dikirim dalam format application/x-www-form-urlencoded, format yang umum untuk mengirim data form dalam HTTP.
      body: user.toJson(), // Data pengguna diubah menjadi JSON dengan user.toJson(), yang mengonversi objek User menjadi format Map<String, dynamic> yang kompatibel dengan permintaan HTTP.
      );
      if (response.statusCode == 200) { // Memeriksa apakah server mengembalikan status 200, yang menunjukkan permintaan berhasil diproses oleh server.
        var responseBody = jsonDecode(response.body); // jsonDecode(response.body): Jika permintaan berhasil, response.body berisi respons dalam format JSON. Fungsi jsonDecode mengubah JSON string menjadi objek Map<String, dynamic> yang dapat digunakan dalam kode.
        if (responseBody['status'] == 200) { // Memeriksa apakah respons dari server juga menunjukkan keberhasilan (misalnya, server mengembalikan status: 200 dalam JSON).
          print("$responseBody['result']");
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
                const SizedBox(height: 20), //* saya edit ini
                ElevatedButton.icon(
                  onPressed: () {
                    register();
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => Userview(),
                      ),
                    );
                  },
                  label: Text('Register'),
                  icon: Icon(Icons.app_registration),
                ),
              ],
            ),
          ),
        ));
  }
}
