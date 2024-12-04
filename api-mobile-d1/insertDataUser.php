<?php
// JANGAN LUPA GUNAIN METODE POST, PADA BODY, BAGIAN FORM DATA untuk insert datanya
include ('koneksi.php');
$username =isset ($_POST['username']) ? $_POST['username'] : null; // Menggunakan isset() untuk memeriksa apakah kunci username, email, dan password ada di dalam array $_POST sebelum mengaksesnya. Jika tidak ada, variabel tersebut akan diatur ke null.
$email = isset ($_POST['email']) ? $_POST['email'] : null;
$password = isset ($_POST['password']) ? $_POST['password'] : null;

if (!empty($username) && !empty($email) && !empty($password)) { // kondisi ini memeriksa apakah variabel username, email, dan password tidak kosong. Jika salah satu dari mereka kosong, blok else di bagian bawah akan dieksesuki.
    // Baris ini membuat query SQL untuk memeriksa apakah ada pengguna dengan username dan email yang sama di dalam tabel user. Query ini dieksekusi menggunakan mysqli_query, dan hasilnya diambil sebagai array menggunakan mysqli_fetch_array.
    $sqlCheck = "SELECT COUNT(*) FROM user WHERE username='$username' OR email='$email' OR password='$password'";
    $queryCheck = mysqli_query($conn, $sqlCheck);
    $hasilCheck = mysqli_fetch_array($queryCheck);

    if ($hasilCheck[0] == 0) { //  Kondisi ini memeriksa apakah hasil dari query sebelumnya adalah 0, yang berarti tidak ada pengguna dengan username dan email yang sama. Jika hasilnya bukan 0, blok else di bawah akan dieksekusi.
        $sql = "INSERT INTO user(username, email, password) VALUES ('username', 'email', '$password')"; // Baris ini membuat query SQL untuk memasukkan data pengguna baru ke dalam tabel user. Query ini dieksekusi menggunakan mysqli_query
        $query = mysqli_query($conn, $sql);

        // kondisi ini memeriksa apakah ada baris yang terpengaruh oleh query INSERT. Jika ada, berarti data berhasil disimpan, dan status serta pesan hasil diatur sesuai. Jika tidak ada baris yang terpengaruh, berarti data gagal disimpan, dan status serta pesan hasil diatur sesuai.
        if (mysqli_affected_rows($conn) > 0) {
            # data berhasil disimpan
            $data['status'] = 200;
            $data['result'] = 'data berhasil disimpan';
        } else {
            # data gagal disimpan
            $data['status'] = 400;
            $data['result'] = 'data gagal disimpan';
        }
    } else { // Blok else ini dieksekusi jika ada pengguna dengan username dan email yang sama di dalam tabel user. Status dan pesan hasil diatur untuk menunjukkan bahwa data sudah dipakai.
        # data sudah dipakai
        $data['status'] = 400;
        $data['result'] = 'data sudah dipakai';
    }
} else { // Blok else ini dieksekusi jika salah satu dari username, email, atau password kosong. Status dan pesan hasil diatur untuk menunjukkan bahwa data tidak boleh kosong.
    # data tidak boleh kosong
    $data['status'] = 400;
    $data['result'] = 'data tidak boleh kosong';
}
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');