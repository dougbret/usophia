<?php

class ObjectStateNotificationType extends eZWorkflowEventType
{
    const EventName = "objectstatenotification";   
    
    function ObjectStateNotificationType()
    {
        $this->eZWorkflowEventType( self::EventName, "Notification on object state change" );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch( $objectID );
        $state_array = $object->stateIDArray();
        $state_role_array_map = array(
          "4" => "Draft Editor",
          "5" => "Approval Editor",
          "6" => "Editing Editor",
          "9" => "Recorded Editor"
        );
        if (isset($state_role_array_map[$state_array['3']])) {
          $role =  $state_role_array_map[$state_array['3']];
          if ($object->className() == 'Item') {
             $userArray = $this->fetchUsersForNotification( $role );
             $tpl = eZTemplate::factory();

            $date = date("F j, Y, g:i a");
            $node = $object->mainNode ();
            foreach ( $userArray as $user )
            {
                $user = eZUser::fetch($user->ID);

                $address['address'] = $user->Email;
                $tpl->setVariable( 'date', $date );
                $tpl->setVariable( 'address', $address['address'] );
                $tpl->setVariable( 'node', $address['address'] );
                $result = $tpl->fetch( 'design:notification/objectstatechange/plain.tpl' );
                $subject = "U-sophia editorial workflow state change";

                $parameters = array();


                $transport = eZNotificationTransport::instance( 'ezmail' );
                $transport->send( $address, $subject, $result, null, $parameters );
                eZDebugSetting::writeDebug( 'kernel-notification', $result, "digest result" );
            }
      
          }  
        }
        return EZ_WORKFLOW_TYPE_STATUS_ACCEPTED;
    }
    
    function fetchUsersForNotification ($role) {
      $adminRole = eZRole::fetchByName( $role );
      $roleUsers = $adminRole->fetchUserByRole(); //this will return eZContentObjects within separate arrays
      foreach( $roleUsers as $key => $userHolder )
      {
        $object_type = $userHolder['user_object']->attribute( 'class_name' );
        if ( $object_type == 'user' ) {
          $users = $userHolder['user_object']; 
        }    
      }

      
      return $users;
    }

    
    
}

eZWorkflowEventType::registerEventType( ObjectStateNotificationType::EventName,
                                        "ObjectStateNotificationType"
                                      );

?>