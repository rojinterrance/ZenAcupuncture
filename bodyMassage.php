<?php 
function deliver_response($format, $api_response){
 
    // Define HTTP responses
    $http_response_code = array(
        200 => 'OK',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        403 => 'Forbidden',
        404 => 'Not Found'
    );
 
    // Set HTTP Response
    header('HTTP/1.1 '.$api_response['status'].' '.$http_response_code[ $api_response['status'] ]);
 
    // Process different content types
    if( strcasecmp($format,'json') == 0 ){
 
        // Set HTTP Response Content Type
        header('Content-Type: application/json; charset=utf-8');
 
        // Format data into a JSON response
        $json_response = json_encode($api_response);
 
        // Deliver formatted data
        echo $json_response;
 
    }elseif( strcasecmp($format,'xml') == 0 ){
 
        // Set HTTP Response Content Type
        header('Content-Type: application/xml; charset=utf-8');
 
        // Format data into an XML response (This is only good at handling string data, not arrays)
        $xml_response = '<?xml version="1.0" encoding="UTF-8"?>'."\n".
            '<response>'."\n".
            "\t".'<code>'.$api_response['code'].'</code>'."\n".
            "\t".'<data>'.$api_response['data'].'</data>'."\n".
            '</response>';
 
        // Deliver formatted data
        echo $xml_response;
 
    }else{
 
        // Set HTTP Response Content Type (This is only good at handling string data, not arrays)
        header('Content-Type: text/html; charset=utf-8');
 
        // Deliver formatted data
        echo $api_response['data'];
 
    }
 
    // End script process
    exit;
 
}
 
// Define whether user authentication is required
$authentication_required = FALSE;
 
// Define API response codes and their related HTTP response
$api_response_code = array(
    0 => array('HTTP Response' => 400, 'Message' => 'Unknown Error'),
    1 => array('HTTP Response' => 200, 'Message' => 'Success'),
    2 => array('HTTP Response' => 403, 'Message' => 'HTTPS Required'),
    3 => array('HTTP Response' => 401, 'Message' => 'Authentication Required'),
    4 => array('HTTP Response' => 401, 'Message' => 'Authentication Failed'),
    5 => array('HTTP Response' => 404, 'Message' => 'Invalid Request'),
    6 => array('HTTP Response' => 400, 'Message' => 'Invalid Response Format'),
	7 => array('HTTP Response' => 400, 'Message' => 'Email Already Exists'),
	8 => array('HTTP Response' => 400, 'Message' => 'Email should not be empty')
);
 
// Set default HTTP response of 'ok'
$response['code'] = 0;
$response['status'] = 404;
$response['data'] = NULL;
 
// --- Step 2: Authorization
 
// Optionally require user authentication
if( $_GET['function'] == "authentication" ) {	
	$username = $_GET['username'];
	$password = $_GET['password'];	
	
	/* connect to the db */
	$link = mysql_connect('127.0.0.1','root','indian@1') or die('Cannot connect to the DB');
	mysql_select_db('bodymassage',$link) or die('Cannot select the DB');

	/* grab the posts from the db */
	$query = "SELECT * FROM users WHERE email = '$username' and password = '$password' ";
	$result = mysql_query($query,$link) or die('Errant query:  '.$query);
	mysql_close($link);
	if( empty($username) || empty($password) ){
        $response['code'] = 3;
        $response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
        $response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response); 
    } else if(mysql_num_rows($result)) {
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	} else if (mysql_num_rows($result) == 0) {
		$response['code'] = 4;
        $response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
        $response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	}
}

if($_GET['function'] == "signup" ) {
	$firstName = $_GET['firstName'];
	$lastName = $_GET['lastName'];
	$email = $_GET['email'];
	$phone = $_GET['phone'];
	$zip = $_GET['zip'];
	$password = $_GET['password'];
	$promocode = $_GET['promocode'];	
	
	$link = mysql_connect('127.0.0.1','root','indian@1') or die('Cannot connect to the DB');
	mysql_select_db('bodymassage',$link) or die('Cannot select the DB');	
	
	if (trim($email) == "") {
		$response['code'] = 8;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	}
	
	$query = "select * from users where email = '$email'";
	$result = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	if (mysql_num_rows($result)) {
		$response['code'] = 7;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	}
	$query = "insert into users (firstName, lastName, email, phone, zip, password, promocode) values ('$firstName', '$lastName', '$email', '$phone', '$zip', '$password', '$promocode')";
	$result = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	if( $result == true) {
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	} else {
		$response['code'] = 5;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	}
}

if( $_GET['function'] == "register" ) { 
	$appointmentDate = $_GET['appointmentDate'];
	$appointTime = $_GET['appointTime'];
	$therapistGender = $_GET['therapistGender'];
	$sessionLength = $_GET['sessionLength'];
	$note = $_GET['note'];
	$userId = $_GET['userId'];
	$isActive = $_GET['isActive'];
	$addressLabel = $_GET['addressLabel'];
	$firstName = $_GET['firstName'];
	$lastName = $_GET['lastName'];
	$deliveryAddress = $_GET['deliveryAddress'];
	$apt_suit_room = $_GET['apt_suit_room'];	
	$city = $_GET['city'];
	$state = $_GET['state'];
	$zip = $_GET['zip'];
	$phone = $_GET['phone'];
	$parkingInstruction = $_GET['parkingInstruction'];
	$isHotel = $_GET['isHotel'];	
	$dateAdded = $_GET['dateAdded'];
	$dateModified = $_GET['dateModified'];
	$cardHolderName = $_GET['cardHolderName'];
	$cardNumber = $_GET['cardNumber'];
	$billingAddress = $_GET['billingAddress'];
	$billingCity = $_GET['billingCity'];	
	$billingState = $_GET['billingState'];
	$billingZip = $_GET['billingZip'];
	
	$link = mysql_connect('127.0.0.1','root','indian@1') or die('Cannot connect to the DB');
	mysql_select_db('bodymassage',$link) or die('Cannot select the DB');
	
	$query = "insert into registerations (appointmentDate, appointTime, therapistGender, sessionLength, note, userId) values ('$appointmentDate', '$appointTime', '$therapistGender', '$sessionLength', '$note', '$userId')";
	$result1 = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	$query = "insert into useraddress (isActive, addressLabel, firstName, lastName, deliveryAddress, apt_suit_room, city, state, zip, phone, parkingInstruction, isHotel, dateAdded, dateModified, cardHolderName, cardNumber, billingAddress, billingCity, billingState, billingZip, userId) values (1, '$addressLabel', '$firstName', '$lastName', '$deliveryAddress', '$apt_suit_room', '$city', '$state', '$zip', '$phone', '$parkingInstruction', '$isHotel', '$dateAdded', '$dateModified', '$cardHolderName', '$cardNumber', '$billingAddress', '$billingCity', '$billingState', '$billingZip', '$userId')";
	$result2 = mysql_query($query,$link) or die('Errant query:  '.$query);
	if( $result1 == true && $result2 == true) {
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	} else {
		$response['code'] = 5;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		deliver_response($_GET['format'], $response);
	}
}



deliver_response($_GET['format'], $response);
 
?>
            