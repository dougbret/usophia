
<?php
class NewzAppConnect
{
  
  const NEWZAPP_SUBSCRIBE_URL =  "http://system.newzapp.co.uk/ThankyouSubscribeToGroup.asp";
  const CID = 16206;
  const GROUP = 'site subscribers';

   
	public function __construct()
	{}


	static function sendInfo( $email, $firstName = '', $lastName = '', $companyName = '' )
	{
	/*$firstName ='text';
	$lastName='text';
	$companyName = 'text';*/
	 $vars = array('FirstName' => $firstName,
                 'LastName' => $lastName,
                 'CompanyName' => '',
                 'Address' => $email,
                 'CID' => self::CID,
                 'Group' => self::GROUP,
                 'RedirectURL' => "http://success"
                  );
   $ch = curl_init();
   curl_setopt($ch, CURLOPT_URL, self::NEWZAPP_SUBSCRIBE_URL);
   curl_setopt($ch, CURLOPT_HEADER, 1);
   curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);

 
   curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
   curl_setopt($ch, CURLOPT_POST, 1);
   curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query( $vars ) );

   $data = curl_exec($ch);
   if ($data) {
      if(strpos($data,'success') ) {
        return true;
      } else {
        return false;
      }
   } else {
       return false;
   }	      
	}


	 
}
?>