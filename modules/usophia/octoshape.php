<?php
$module = $Params['Module'];


/*HTTP VARIABLE TO READ THE POST, GET, SESSION HTTP VARIABLES*/
$http = eZHTTPTool::instance();
$action = $http -> postVariable( 'octoshape_action' );
$event_oid = $http -> postVariable( 'channel' );
$redirect_nid = $http -> postVariable( 'redirect_nid' );
$channel = false;




if ($event_oid) {
  $object = eZContentObject::fetch( $event_oid );
  $version = $object->currentVersion();
  $objectAttributes = $version->attribute( 'contentobject_attributes' );
  $dataMap = $version->attribute('data_map');  


  if( $dataMap['url']->attribute('content') ) {
    $url = $dataMap['url']->attribute('content');
    $url_array = explode('/', $url);
    $channel = $url_array[6];
  }


  if($channel) {

    //Initialize and set options
    $username = 'usophia';
    $password = 'Hask2870';
    //$channel = 'ch1';
    $filename = "test";
    if( $dataMap['recording_file_name']->attribute('content') ) {
      $filename = $dataMap['recording_file_name']->attribute('content');
      if ($action == 'Record') {
        $filename = str_replace(' ','-',$filename);
        $filename_array = explode('.',$filename);
        $filename = $filename_array[0] . '-' .date("Y-m-d-H-i") . '.' . $filename_array[1];
        $dataMap['recording_file_name']->fromString($filename);
        $dataMap['recording_file_name']->store();
      }
    }
    
    if ($action == 'Record')
      $url = "https://octoshape.com/filewriter/gateway.php?path=usophia&cmd=record&streamName=u-sophia/live/flv/$channel/2500k/fw&fileName=$filename";
    elseif ($action == 'Stop')
      $url = "https://octoshape.com/filewriter/gateway.php?path=usophia&cmd=stop&streamName=u-sophia/live/flv/$channel/2500k/fw";
    elseif($action == 'Check_status') 
      $url = "https://octoshape.com/filewriter/gateway.php?path=usophia&cmd=status&streamName=u-sophia/live/flv/$channel/2500k/fw";
    
    
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
      if(isset($result['success'])) {
        $result = $result['success'];
      }  
      if(isset($result['recording'])) {
        $status = '&status=' . $result['recording'];
        $result = '3';  
      }  
    }
  }else {
    $result = 'No channel defined for this item';
  }
}else {
    $result = 'No event was selected. Please select one.';
}   
$redirect_node =  eZContentObjectTreeNode::fetch($redirect_nid);
$redirect_path = $redirect_node->urlAlias ();


header("Location: /$redirect_path/(admin)?result=" . $result . $status); 


$Result = array();
$Result['pagelayout'] = false;
eZDB::checkTransactionCounter();
eZExecution::cleanExit(); 

?>
