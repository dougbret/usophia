<?php

class GtmDateSaveType extends eZWorkflowEventType
{
    const EventName = "gtmdatesave";   
    
    function GtmDateSaveType()
    {
        $this->eZWorkflowEventType( self::EventName, "GTM convert on publish" );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch( $objectID );
        if ($object->className() == 'Event'){	
        
        $version = $object->version( $parameters['version'] );
        $objectAttributes = $version->attribute( 'contentobject_attributes' );
        $dataMap = $version->attribute('data_map');
        $contentObjectAttribute = $dataMap['from_time'];
        $contentObjectAttributetoTime = $dataMap['to_time'];
        $date = $contentObjectAttribute->toString ();
        $todate = $contentObjectAttributetoTime->toString ();
        /* Getting user location*/
        include_once 'geoip.inc';
        include_once 'timezone.php';
        $gi = geoip_open("GeoIP.dat",GEOIP_STANDARD);
        $currentCountry = geoip_country_code_by_addr($gi,$_SERVER['REMOTE_ADDR']);
        $currentRegion=geoip_region_by_addr($gi,$_SERVER['REMOTE_ADDR']);
        $timeZone = get_time_zone($currentCountry,$currentRegion); 
        
        $offset = $this->get_timezone_offset('Europe/London',$timeZone);
        $value =  $date - ($offset);
        $tovalue =  $todate - ($offset);
        $this->save_eZ_attribute( $contentObjectAttribute, $value );    
        $this->save_eZ_attribute( $contentObjectAttributetoTime, $tovalue );    
        }  
      
        return EZ_WORKFLOW_TYPE_STATUS_ACCEPTED;
    }
    
    /**    Returns the offset from the origin timezone to the remote timezone, in seconds.
    *    @param $remote_tz;
    *    @param $origin_tz; If null the servers current timezone is used as the origin.
    *    @return int;
    */
    function get_timezone_offset($remote_tz, $origin_tz = null) {
        if($origin_tz === null) {
            if(!is_string($origin_tz = date_default_timezone_get())) {
                return false; // A UTC timestamp was returned -- bail out!
            }
        }
        $origin_dtz = new DateTimeZone($origin_tz);
        $remote_dtz = new DateTimeZone($remote_tz);
        $origin_dt = new DateTime("now", $origin_dtz);
        $remote_dt = new DateTime("now", $remote_dtz);
        $offset = $origin_dtz->getOffset($origin_dt) - $remote_dtz->getOffset($remote_dt);
        return $offset;
    }
    
    
    function save_eZ_attribute( $contentObjectAttribute, $value )
    {
    
       switch( $contentObjectAttribute->attribute( 'data_type_string' ) )
      {
        case 'ezobjectrelation':
        {
            // Remove any exisiting value first from ezobjectrelation
            $contentObjectAttribute->setAttribute( 'data_int', 0 );
            $contentObjectAttribute->store();
 
        }
        break;
 
        case 'ezobjectrelationlist':
        {
            // Remove any exisiting value first from ezobjectrelationlist
 
            $content = $contentObjectAttribute->content();
            $relationList =& $content['relation_list'];
            $newRelationList = array();
            for ( $i = 0; $i < count( $relationList ); ++$i )
            {
                $relationItem = $relationList[$i];
                eZObjectRelationListType::removeRelationObject( $contentObjectAttribute, $relationItem );
            }
            $content['relation_list'] =& $newRelationList;
            $contentObjectAttribute->setContent( $content );
            $contentObjectAttribute->store();
 
        }
        break;
      }
 
    // fromString returns false - even when it is successfull
    // create a bug report for that
      $contentObjectAttribute->fromString( $value );
      $contentObjectAttribute->store();

    } 
}

eZWorkflowEventType::registerEventType( GtmDateSaveType::EventName,
                                        "gtmdatesavetype"
                                      );

?>