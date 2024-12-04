class User {
  //* ada 4 attribut dari class User
  int id; // membuat nama id dengan tipe data integer
  String userName; // membuat nama userName dengan tipe data String
  String email; // membuat nama email dengan tipe data String
  String password; // membuat nama password dengan tipe data String
  User(this.id, this.userName, this.email, this.password); //* constructor yang digunakan untuk membuat objek User dengan langsung mengisi keempat properti (id, userName, email, dan password) saat objek dibuat.
  // fungsi untuk getData
  factory User.fromJson(Map<String,dynamic> json) => User(  //* Fungsi ini digunakan untuk mengubah data dalam format JSON menjadi objek User. Ini memudahkan dalam parsing data respons dari server.
    int.parse(json['id']),
    json['username'],
    json['email'],
    json['password'],
    );
  // fungsi untuk kirimData
  //* Map<String, dynamic>: Tipe data ini adalah map atau dictionary dalam Dart.
  //* String menunjukkan bahwa setiap kunci (key) dalam map adalah tipe String.
  //* dynamic menunjukkan bahwa nilai (value) dapat berupa tipe data apa pun.
  Map<String, dynamic> toJson() => {
    'id': this.id.toString(), //* mengonversi id ke string. Dikirim sebagai String dalam JSON
    'username': this.userName, //* Menetapkan nilai userName sebagai nilai untuk kunci
    'email': this.email, //* Menetapkan nilai email sebagai nilai untuk kunci email.
    'password': this.password, //* Menetapkan nilai password sebagai nilai untuk kunci
  };
}