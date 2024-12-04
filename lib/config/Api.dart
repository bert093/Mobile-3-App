class Api{
  static const _host='http://127.0.0.1/api-mobile-d1'; //* Ini adalah konstanta statis yang menyimpan URL dasar (base URL) dari API yang akan diakses. URL ini menunjuk ke server lokal (127.0.0.1) dan ke direktori api-mobile-d1.
  static const _hostUser = '$_host'; // folder user (Konstanta ini menyimpan URL dasar yang sama dengan _host tetapi menambahkan garis miring di akhir. Ini mungkin digunakan untuk mengakses berbagai endpoint dalam folder user.)
  static const register = '$_hostUser/insertDataUser.php'; //* variabel statis yang mengacu pada url endpoint
  static const getDataUser = '$_hostUser/getDataUser.php';
  static const updateDataApi = '$_hostUser/updateData.php';
  static const deleteDataUser = '$_hostUser/delData.php';
}