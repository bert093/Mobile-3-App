<?php

include 'koneksi.php'; // memanggil file koneksi.php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');
$query='SELECT * FROM user';

$sql=mysqli_query($conn,$query);

if (mysqli_num_rows($sql) > 0) {
    while ($row=mysqli_fetch_object($sql)) {
        $data['status'] = 200;
        $data['result'][] = $row; //* ditambahkan []
    }
    
} else {
    $data['status'] = 404;
    $data['result'] = 'data tidak ada'; 
}

print_r(json_encode($data));