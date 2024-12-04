<?php
include('koneksi.php');
// gunakan metode request post untuk delete data

$id = isset($_POST['id']) ? $_POST['id'] : null;

if (!empty($id)) {
    $sql = "DELETE FROM user WHERE id='$id'";
    $query = mysqli_query($conn, $sql);
    $data['status'] = 200;

} else {
    $data['status'] = 400;
    $data['result'] = 'Data not found';
}
print_r(json_encode($data));
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');