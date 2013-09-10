<?php
$module = $Params['Module'];

/*SETING MODULE HTTPTITLE*/
$module->setTitle( 'Art Center Control Panel' );

$channel_array = array (
"octoshape://streams.octoshape.net/u-sophia/live/flv/ch1/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch2/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch3/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch4/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch5/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch6/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch7/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch8/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch9/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch10/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch11/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch12/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch13/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch14/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch15/2500k","octoshape://streams.octoshape.net/u-sophia/live/ch16/8000k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch17/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch18/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch19/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch20/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch21/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch22/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch23/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch24/2500k","octoshape://streams.octoshape.net/u-sophia/live/flv/ch25/2500k"
);

if(count($channel_array)) {

  //Initialize and set options
  $username = 'usophia';
  $password = 'Hask2870';
  $channel_status_array = array();
  foreach ($channel_array as $channel) {
    $url_array = explode('/', $channel);
    $channel_string = $url_array[6];
    $url = "http://octoshape.com/filewriter/gateway.php?path=usophia&cmd=status&streamName=u-sophia/live/flv/$channel_string/2500k/fw";
  
    $ch = curl_init(); 
    curl_setopt($ch, CURLOPT_URL, $url); 
    curl_setopt($ch, CURLOPT_USERPWD, $username.':'.$password);
    curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
    curl_setopt($ch, CURLOPT_TIMEOUT, 4); 
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Connection: close'));
     
    //Execute the request and also time the transaction ( optional )
    $start = array_sum(explode(' ', microtime()));
    $result = curl_exec($ch); 
    $stop = array_sum(explode(' ', microtime()));
    $totalTime = $stop - $start;
     
    //Check for errors ( again optional )
    if ( curl_errno($ch) ) {
        $result = 'Error-Request->' . curl_errno($ch) . ': ' . curl_error($ch);
    } else {
        $returnCode = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        switch($returnCode){
            case 200:
                break;
            default:
                $result = 'Error-http->' . $returnCode;
            break;
        }
    }
     
    //Close the handle
    curl_close($ch);
     
    //Output the results
    $status = '';
    if (strstr($result, '{')) {
      $result = json_decode($result, true);

      if(isset($result['recording'])) {
        if($result['recording']) {
          $channel_status_array[$channel_string] = "Recording";
        }else {
          $channel_status_array[$channel_string] = "Idle";
        }

      }  
    }
  }  
}


/*CODE FOR TEMPLATE FETCH USING MODULE*/

require_once( "kernel/common/template.php" );
$tpl = templateInit();
$tpl->setVariable( 'artcenter_user', $artcenter_user );
$tpl->setVariable( 'channel_status', $channel_status_array );
$tpl->setVariable( 'view_parameters', $viewParameters );

$Result = array();
$Result['content'] = $tpl->fetch ( "design:user_dashboard.tpl" );
$Result['path'] = array( array( 'text' =>  'Art Center Control Panel',
							'url' => false ) );


?>
