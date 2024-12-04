<?php
include('koneksi.php');
// gunakan metode request post untuk update data
print_r(json_encode($data));
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

$username = isset($_POST['username']) ? $_POST['username'] : null;
$email = isset($_POST['email']) ? $_POST['email'] : null;
$password = isset($_POST['password']) ? $_POST['password'] : null;
$id = isset($_POST['id']) ? $_POST['id'] : null;

if (!empty($username) && !empty($email) && !empty($password)) {
 $sql = "UPDATE user SET username='$username', email='$email', password='$password' WHERE id='$id'";

    $query = mysqli_query($conn, $sql);
    if (mysqli_affected_rows($conn) > 0) {
        # code...
        $data['status'] = 200;
        $data['result'][] = 'Data Berhasil diubah';
    } else {
        # code...
        $data['status'] = 400;
        $data['result'][] = 'Data Gagal diubah';
    }
} else {
    # code...
    $data['status'] = 400;
    $data['result'][] = 'Data Tidak Boleh Kosong';
}