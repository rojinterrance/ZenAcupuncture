<?php 

require 'class.phpmailer.php';

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
			"\t".'<userId>'.$api_response['userId'].'</userId>'."\n".
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

function getLatitude($deliveryAddress){
	$city = $deliveryAddress;
	$geocode=file_get_contents('http://maps.google.com/maps/api/geocode/json?address='.$city.'&sensor=false');
	$geo = json_decode($geocode, true);
	if ($geo['status'] = 'OK') {
		$latitude = $geo['results'][0]['geometry']['location']['lat'];
		$longitude = $geo['results'][0]['geometry']['location']['lng'];
		$status = '{"latitude":"'.$latitude.'","longitude":"'.$longitude.'"}';		
	} else {
		$status = '{" False "}';
	}
	return $status;
}

function distance($lat1, $lon1, $lat2, $lon2) {
	$theta = $lon1 - $lon2;
	$dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
	$dist = acos($dist);
	$dist = rad2deg($dist);
	$miles = $dist * 60 * 1.1515;
	return $miles;
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
$response['userId'] = '';

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
		$value = mysql_fetch_object($result)->id;
		$response['userId'] = $value;
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
		$response['userId'] = mysql_insert_id();
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
	$phone = $_GET['phone'];
	$isHotel = $_GET['isHotel'];	
	$dateAdded = date("Y-m-d");
	$cardHolderName = $_GET['cardHolderName'];
	$stripeToken = $_GET['stripeToken'];
	$acupunctureType = $_GET['type'];
	
	$latlong = getLatitude($deliveryAddress);
	$latlong = json_decode($latlong);
	$latitude = $latlong->latitude;
	$longitude = $latlong->longitude;
	
	if($latitude == "" || $longitude == ""){
		$response['code'] = 5;
		$response['status'] = 404;
		$response['data'] = 'Please enter the valid delivery address';
		$response['userId'] = $_GET['userId'];
		deliver_response($_GET['format'], $response);
	}
	
	$link = mysql_connect('127.0.0.1','root','indian@1') or die('Cannot connect to the DB');
	mysql_select_db('bodymassage',$link) or die('Cannot select the DB');
	
	$query = "insert into registerations (appointmentDate, appointTime, therapistGender, sessionLength, note, userId, acupunctureType, stripeToken) values ('$appointmentDate', '$appointTime', '$therapistGender', '$sessionLength', '$note', '$userId', '$acupunctureType', '$stripeToken')";
	$result1 = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	$query = "insert into useraddress (isActive, addressLabel, firstName, lastName, deliveryAddress, phone, isHotel, dateAdded, cardHolderName, userId, latitude, longitude) values (1, '$addressLabel', '$firstName', '$lastName', '$deliveryAddress', '$phone', '$isHotel', '$dateAdded', '$cardHolderName', '$userId', '$latitude', '$longitude')";
	$result2 = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	$day = strtotime($appointmentDate);
	$day = date('D', $day);
	
	$time = strtotime($appointTime);
	$time = date('H', $time);
	
	$query = "select p.name, p.email, al.latitude as myLatitude, al.longitude as myLongitude from practitioners p 
			INNER JOIN available_time at on at.practitioner_id = p.id
			INNER JOIN available_locations al on al.practitioner_id = p.id
			where 
				at.time_From <= '$time' and 
				at.time_to >='$time' and 
				at.day = '$day' and
				p.specialities like '%$acupunctureType%'
			GROUP BY p.email";
	$result = mysql_query($query,$link) or die('Errant query:  '.$query);
	if(mysql_num_rows($result)) {	
		$nearestEmail = "";
		$shortestDistance = "";
		$name = "";
		while($rows = mysql_fetch_array($result)){
			$myLatitude = $rows['myLatitude'];
			$myLongitude = $rows['myLongitude'];
			$distance = distance($myLatitude, $myLongitude, $latitude, $longitude);
			if ($shortestDistance == "" || $shortestDistance > $distance) {
				$shortestDistance = $distance;
				$nearestEmail = $rows['email'];
				$name = $rows['name'];
			}					
		}
		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->Mailer = 'smtp';
		$mail->SMTPAuth = true;
		$mail->Host = 'smtp.gmail.com'; // "ssl://smtp.gmail.com" didn't worked
		$mail->Port = 587;
		$mail->SMTPSecure = 'tls';
		// or try these settings (worked on XAMPP and WAMP):
		// $mail->Port = 587;
		// $mail->SMTPSecure = 'tls';
		$mail->Username = "test@gmail.com";
		$mail->Password = "test";
		$mail->IsHTML(true); // if you are going to send HTML formatted emails
		$mail->SingleTo = true; // if you want to send a same email to multiple users. multiple emails will be sent one-by-one.
		$mail->From = "noreply@zenacu.com";
		$mail->FromName = "Zen Acu";
		$mail->addAddress($nearestEmail,$name);
		$mail->Subject = "User booked in Zen Acu";
		$mail->Body = "Hi ".$name.",<br /><br />".$firstName." ".$lastName." booked for ".$appointmentDate." at ".$appointTime."";
		
		//$mail->send();	
	} else {
		$response['code'] = 5;
		$response['status'] = 404;
		$response['data'] = 'There is no partitioner available for your requested place and date.';
		$response['userId'] = $_GET['userId'];
		deliver_response($_GET['format'], $response);
	}
	if( $result1 == true && $result2 == true) {
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		$response['userId'] = $_GET['userId'];
		deliver_response($_GET['format'], $response);
	} else {
		$response['code'] = 5;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = $api_response_code[ $response['code'] ]['Message'];
		$response['userId'] = $_GET['userId'];
		deliver_response($_GET['format'], $response);
	}
}

if( $_GET['function'] == "getOrder" ) { 
	$userid = $_GET['userid'];
	
	$link = mysql_connect('127.0.0.1','root','indian@1') or die('Cannot connect to the DB');
	mysql_select_db('bodymassage',$link) or die('Cannot select the DB');
	
	$query = "select * from registerations where userid = '$userid'";
	$result = mysql_query($query,$link) or die('Errant query:  '.$query);
	
	if(mysql_num_rows($result)) {
	
		$rows = array();
		while($r = mysql_fetch_assoc($result)) {
			 $rows[] = $r;
		}		
		$value = json_encode($rows);	
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];		
		$response['data'] = $value;
		$response['userId'] = $userid;
		deliver_response($_GET['format'], $response);
	} else {
		$response['code'] = 1;
		$response['status'] = $api_response_code[ $response['code'] ]['HTTP Response'];
		$response['data'] = 'No Record found';
		$response['userId'] = $userid;
		deliver_response($_GET['format'], $response);
	}
}

deliver_response($_GET['format'], $response);
 
?>
            