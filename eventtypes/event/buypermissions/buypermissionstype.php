<?php

class BuyPermissionsType extends eZWorkflowEventType
{  
    const WORKFLOW_TYPE_STRING = "buypermissions";
    
    
    public function __construct()
    {
      parent::__construct( self::WORKFLOW_TYPE_STRING,
      ezi18n( 'kernel/workflow/event', 'Assign permissions to users after an item was bought' ) );
      $this->setTriggerTypes( array( 'shop' => array( 'checkout' =>
      array( 'before' ) ) ) );
    }
    

    function execute( $process, $event )
    {
        
        //$ini = eZINI::instance( 'buypermissions.ini' );

        //$contentClasses = $ini->variable( 'BuyPermissionsSettings','ContentClasses' );
        $contentClasses = array('item', 'item_series');
        eZLog::write('execute buy permissions');
        $limitIdentifier = 'Subtree';
        // Get the current user
        $userID = $process->attribute( 'user_id' );
        // Get the order ID so that we can find out what objects there were
        $parameters = $process->attribute( 'parameter_list' );
        $orderID = $parameters['order_id'];
        // Get the order
        $thisOrder = eZOrder::fetch($orderID);
        // Create the role object
        
        // Loop through each product to see whether it's relevant for roleassignment
        foreach ($thisOrder->productItems() as $thisProduct)
        {
          $classIdentifier = $thisProduct["item_object"]->ContentObject->attribute( 'class_identifier' );
          // Is this in the list of downloadable products?
          if( in_array( $classIdentifier, $contentClasses ) )
          {
            if($classIdentifier == 'item') {
              // We have a match, so the last thing we need to do is to fetch the node of the file
              // First we want to grab the object so that we can get at its attributes
              $thisObject = $thisProduct["item_object"]->ContentObject;
              $dataMap = $thisObject->fetchAttributesByIdentifier( array( 'item_status' ) );
              // There should only be one $dataMap item, so get the path of that
              $roleID = -1;
              
              foreach( $dataMap as $dataMapAttribute)
              {
                $status = $dataMapAttribute->attribute( 'data_text' );
                // We're only after the main node
              }
              
              $dataMap2 = $thisObject->fetchAttributesByIdentifier( array( 'type' ) );
              // There should only be one $dataMap item, so get the path of that
              $roleID = -1;
              
              foreach( $dataMap2 as $dataMapAttribute)
              {
                $type = $dataMapAttribute->attribute( 'data_text' );
                // We're only after the main node
              }
              if($type == 0) {
                if($status == 0 || $status == 1) {
                  $roleID = 33;    
                  
                }
                
                 if($status == 2 || $status == 5) {
                  $roleID = 36;    
                  
                }
              }elseif($type == 1){
                if($status == 0 || $status == 1) {
                  $roleID = 42;     
                }
              
              }  
              if($roleID != -1) {
                $role = eZRole::fetch( $roleID );
                
                $node = $thisObject->mainNode();
                $limitValue = $node->attribute( 'path_string' );

                // Assign the role
                $role->assignToUser( $userID, $limitIdentifier, $limitValue);
              }
            } 
            if($classIdentifier == 'item_series') {
              $thisObject = $thisProduct["item_object"]->ContentObject; 
              
              
              $version = $thisObject->currentVersion ();
              $objectAttributes = $version->attribute( 'contentobject_attributes' );
              $dataMap = $version->attribute('data_map');
              $contentObjectAttribute = $dataMap['series_items'];
              eZLog::write('Llega1');
              $object_ids = explode('-',$contentObjectAttribute->toString());
              eZLog::write('Llega2' . $contentObjectAttribute->toString());
              foreach($object_ids as $oid) {
                $roleID = -1;
                $node = eZContentObjectTreeNode::fetchByContentObjectID( $oid );
                eZLog::write('Llega3');
                 // We're only after the main node
                $node = $node[0];
                $dataMap1 = $node->dataMap();
                $status = $dataMap1['item_status'];
                $status = $status->toString();
                if($status == 0 || $status == 1) {
                  $roleID = 33;    
                }
                if($status == 2 || $status == 5) {
                  $roleID = 36;    
                  
                }
                eZLog::write('Llega4');
                if($roleID != -1) {
                   eZLog::write('Llega5');
                  $role = eZRole::fetch( $roleID );
                  $limitValue = $node->attribute( 'path_string' );
                  $role->assignToUser( $userID, $limitIdentifier, $limitValue);
                }
                
                // We're only after the main node
                
              }
            }  
          }
        }
        // Clear the role cache
        eZRole::expireCache();
        return eZWorkflowType::STATUS_ACCEPTED;;
  }


    

    

}

eZWorkflowEventType::registerEventType( BuyPermissionsType::WORKFLOW_TYPE_STRING,
'BuyPermissionsType' );

?>