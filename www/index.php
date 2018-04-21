<?php


try{
    $dsn = 'mysql:host=172.17.0.3;dbname=mysql';
    $pdo = new \PDO($dsn,'jay','jay');
    echo 'database is running';
    foreach ($pdo->query('SELECT * from user') as $row) {
        print_r($row);
    }
    $pdo = null;
}catch (PDOException $exception){
    die("error:  " . $exception->getMessage());
}
