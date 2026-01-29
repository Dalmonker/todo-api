<?php

session_start();

require_once 'config.php';

$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

if (isset($_GET['act'])) {
    switch ($_GET['act']) { // +
        case 'login':
            require_once 'action/login.php';
            break;
    }
    die;
}

