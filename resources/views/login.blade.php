<?php
/**
 * Created by PhpStorm.
 * User: Loc Nguyen
 * Date: 9/25/2018 6:49 PM
 */
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>login</title>
</head>
<body>
        <form action="{{route('login.post')}}" method="post">
            {{csrf_field()}}
            <input type="email" name="email">
            <input type="text" name="password">
            <button type="submit">Login</button>
        </form>
</body>
</html>