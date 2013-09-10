<?php
$module = $Params['Module'];


/*HTTP VARIABLE TO READ THE POST, GET, SESSION HTTP VARIABLES*/
$http = eZHTTPTool::instance();
$event_oid = $http -> postVariable( 'event_oid' ); 
$status_id = $http -> postVariable( 'status' ); 
$redirect_nid = $http -> postVariable( 'redirect_nid' );
$channel = false;


if ($event_oid) {
  if ($status_id) {

    $object = eZContentObject::fetch( $event_oid );
    $version = $object->currentVersion();
    
    $dataMap = $version->attribute('data_map');  
    $attribute = $dataMap['item_status'];
    $attribute->fromString( $status_id );
    $attribute->store();
    
    $result = 2;
  }else {
    $result = 'Select a state to change the item too.';
  } 

}else {
  $result = 'No event was selected. Please select one.';
} 
$redirect_node =  eZContentObjectTreeNode::fetch($redirect_nid);
$redirect_path = $redirect_node->urlAlias ();


header("Location: /$redirect_path/(admin)?result=" . $result); 


$Result = array();
$Result['pagelayout'] = false;
eZDB::checkTransactionCounter();
eZExecution::cleanExit(); 


?>
