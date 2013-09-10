<?php

class SubscribeToNewsletterType extends eZWorkflowEventType
{
    const EventName = "subscribetonewsletter";   
    
    function SubscribeToNewsletterType()
    {
        $this->eZWorkflowEventType( self::EventName, "Subscribe To Newsletter" );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch( $objectID );
        $version = $object->version( $parameters['version'] );
        $objectAttributes = $version->attribute( 'contentobject_attributes' );
        $dataMap = $version->attribute('data_map');  
        if( $dataMap['newsletter'] ) {
          if( $dataMap['newsletter']->attribute('content') ) {        
              NewzAppConnect::sendInfo(	$dataMap['user_account']->attribute('content')->attribute('email'),
                                     $dataMap['first_name']->attribute('content'),
                                     $dataMap['last_name']->attribute('content') );



            // CJW Newsletter
            $subscriptionDataArr['email'] = $dataMap['user_account']->attribute('content')->attribute('email');
                $subscriptionDataArr['first_name'] = $dataMap['first_name']->attribute('content');
                $subscriptionDataArr['last_name'] = $dataMap['last_name']->attribute('content');
                $subscriptionDataArr['id_array'] = array( 1258 );
                $subscriptionDataArr['list_array'] = array( 1258 );
                $subscriptionDataArr['list_output_format_array'][ 1258 ] = 0;


            $context = 'subscribe';
                    // subscribe to all selected lists
                    $subscriptionResultArray = CjwNewsletterSubscription::createSubscriptionByArray( $subscriptionDataArr,
                                                                                                     CjwNewsletterUser::STATUS_CONFIRMED,
                                                                                                     true,
                                                                                                     $context );



          }
        }
        return EZ_WORKFLOW_TYPE_STATUS_ACCEPTED;
    }
}

eZWorkflowEventType::registerEventType( SubscribeToNewsletterType::EventName,
                                        "subscribetonewslettertype"
                                      );

?>