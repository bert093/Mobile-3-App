<?php

$hostname='localhost';
$username='root'; // isi awal root
$pass='';
$dbname='api-mobile-d1';
// $port='3306; jika koneksi bermasalah gunakan port isi sesuai dengan mysql xampp port

//koneksi ke database
$conn=mysqli_connect($hostname,$username,$pass,$dbname); // masukkan $port di sini jika perlu
// Apakah berhasil
if (!$conn){
    print_r(json_encode("gagal"));
}


// $koneksi=mysqli_connect($hostname,$username,$password,$database);
// if($koneksi){
// }
// $port = '90';