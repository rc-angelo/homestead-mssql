<p align="center"><img src="https://laravel.com/assets/img/components/logo-homestead.svg"></p>

<p align="center">
<a href="https://travis-ci.org/f3rland/homestead-mssql"><img src="https://travis-ci.org/f3rland/homestead-mssql.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/f3rland/homestead-mssql"><img src="https://poser.pugx.org/f3rland/homestead-mssql/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/f3rland/homestead-mssql"><img src="https://poser.pugx.org/f3rland/homestead-mssql/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/f3rland/homestead-mssql"><img src="https://poser.pugx.org/f3rland/homestead-mssql/license.svg" alt="License"></a>
</p>

## Introduction

Laravel Homestead **MSSQL** is an **unofficial**, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 7.1, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](http://laravel.com/docs/homestead).


## Start your MS SQL compatible laravel/homestead box

On Windows

````bash
composer require f3rland/homestead-mssql:dev-master --dev
vendor\\bin\\homestead make
vagrant up
````


You can validate your box with this code in ``/public/index.php``

````php
<?php
#If you have a SQL Server Instance, use that scheme
#$serverName = "Server,Port";

$serverName = "ServerName";
$connectionOptions = array(
	"Database" => "database name",
	"Uid" => "username",
	"PWD" => "long and secure password"
);

//Establishes the connection
$conn = sqlsrv_connect($serverName, $connectionOptions);
if ($conn == FALSE)
	die(FormatErrors(sqlsrv_errors()));

//Select Query
$tsql= "SELECT @@Version as SQL_VERSION";
//Executes the query
$getResults= sqlsrv_query($conn, $tsql);
//Error handling
if ($getResults == FALSE)
	die(FormatErrors(sqlsrv_errors()));
?>

<h1> Results : </h1>
<?php
while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
	echo ($row['SQL_VERSION']);
	echo ("<br/>");
}
sqlsrv_free_stmt($getResults);
function FormatErrors( $errors )
{
	/* Display errors. */
	echo "Error information: <br/>";
	foreach ( $errors as $error )
	{
		echo "SQLSTATE: ".$error['SQLSTATE']."<br/>";
		echo "Code: ".$error['code']."<br/>";
		echo "Message: ".$error['message']."<br/>";
	}
}
?>
````

based on [Microsoft guide to install Microsoft PHP Drivers for SQL Server on linux](https://www.microsoft.com/en-us/download/details.aspx?id=20098)
