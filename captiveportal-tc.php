<?php
header("Content-type: text/html; charset=utf-8");


DEFINE("DEBUG", false);
DEFINE("DBHOST", "localhost");
DEFINE("DBUSER", "radius");
DEFINE("DBPASS", "radpass");
DEFINE("DBNAME", "radius");

global $emailAddress, $phoneNumber, $familyName, $surName;



function dbError($db, $errMessage) {
	trigger_error($errMessage . utf8_encode($db->error));

	if (DEBUG == true)
		WelcomePage($errMessage . utf8_encode($db->error));
	else
		WelcomePage($errMessage);
	$db->close();
	die();
}


// Get IP and mac address
$ipAddress=$_SERVER['REMOTE_ADDR'];
#run the external command, break output into lines
$arp=`arp $ipAddress`;
$lines = explode(" ", $arp);
$badCheck = false;

if (!empty($lines[3]))
	$macAddress = $lines[3]; // Works on FreeBSD
else
	$macAddress = "fa:ke:ma:c:ad:dr"; // Fake MAC on dev station which is probably not FreeBSD

$regDate = date("Y-m-d H:i:s");
if(isset($_POST["tc"])){
    
	$db = new mysqli(DBHOST, DBUSER, DBPASS, DBNAME);
	
	if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
	}
	
	
	$ad = strtoupper(karakter_duzeltme(trim($_POST["ad"])));
	$soyad = strtoupper(karakter_duzeltme(trim($_POST["soyad"])));
	$dogum_yili = trim($_POST["dogum"]);
	$tc_no = trim($_POST["tc"]);
	settype($tc_no, "double");
	
	$parameters = array();
	$parameters['familyName'] = $ad;
	$parameters['surName'] = $soyad;
	$parameters['phoneNumber'] = $phoneNumber;
	$parameters['emailAddress'] = $emailAddress;
	$parameters['macAddress'] = $macAddress;
	$parameters['ipAddress'] = $ipAddress;
	$parameters['regDate'] = $regDate;
	$parameters['identificator'] = $identificator;
	$parameters['newsletter'] = $newsletter;

	

		
		
        if($statement = $db->prepare("Select * From radcheck Where username = ? LIMIT 1")){
			$statement->bind_param('d', $tc_no);
			$statement->execute();
			$statement->store_result();
		
			if ($statement->num_rows != 0){
					
					if($statement1 = $db->prepare("INSERT INTO reg_users (familyName, surName, phoneNumber, emailAddress, macAddress, ipAddress, regDate, newsletter) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)")){
					$statement1->bind_param("ssssssss", $ad, $soyad, $parameters['phoneNumber'], $parameters['emailAddress'], $macAddress, $parameters['ipAddress'], $parameters['regDate'], $parameters['newsletter']);
					$statement1->execute();
					$statement->close();
					$statement1->close();
					}
				echo $tc_no.','.$tc_no;
			}
			
				
		else {
	
	
		try {
		$veriler = array(
            "TCKimlikNo" => $tc_no,
            "Ad" => $ad,
            "Soyad" => $soyad,
            "DogumYili" => $dogum_yili
        );
		
        $baglan = new SoapClient("https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx?WSDL");
		
        $sonuc = $baglan->TCKimlikNoDogrula($veriler);
		
        if ($sonuc->TCKimlikNoDogrulaResult){
            
			if ($statement = $db->prepare("INSERT INTO reg_users (familyName, surName, phoneNumber, emailAddress, macAddress, ipAddress, regDate, newsletter) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)")){
				$statement->bind_param("ssssssss", $ad, $soyad, $parameters['phoneNumber'], $parameters['emailAddress'], $macAddress, $parameters['ipAddress'], $parameters['regDate'], $parameters['newsletter']);
				$statement->execute();
				$statement->close();
				
			}

			
			
			if ($statement = $db->prepare("INSERT INTO radcheck (username, attribute, op, value) VALUES (?, 'Cleartext-Password', ':=', ?)")){
				$statement->bind_param('dd', $tc_no, $tc_no);
				$statement->execute();
				$statement->close();
				echo $tc_no.','.$tc_no;
			}
	
        }else {
           echo 0;
        }

    }catch (Exception $hata){
        echo $hata;
    }
	
		}
		
}
}


function karakter_duzeltme($gelen){
    $karakterler = array("ç","ğ","ı","i","ö","ş","ü");
    $degistir = array("Ç","Ğ","I","İ","Ö","Ş","Ü");
    return str_replace($karakterler, $degistir, $gelen);
}

function karakter_duzeltme2($gelen){
    $karakterler = array("ç","Ç","ğ","Ğ","ı","İ","ö","Ö","ş","Ş","ü","Ü");
    $degistir = array("c","c","g","g","i","i","o","o","s","s","u","u");
    return str_replace($karakterler, $degistir, strtolower($gelen));
}

?>
