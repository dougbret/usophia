{* recorded ticketed Product  *}



{def 
     $recorded_ticketed_product = ''
     $recorded_object = ''
     $recorded_ticketed_item = ''

  $stream_type = ''   
  $type = ''  
  $object =false() 
  $event = false() 
  $user = fetch( 'user', 'current_user' )


  $item_object = ''
  $item_node = ''
  $item_reverse = ''


  $has_recorded_ticket_access = false()

  $interactive_entitled = false()

  $permissions_need = true()
  $permissions = false()
  $permissions_flag = false()
  $purchased_text = ''
  $purchased = false()

  $streaming_url = 'octoshape://streams.octoshape.net/u-sophia/live/flv'
  $help_text = ''
  $preview = 'Click to Watch'

  $hostname = ezini( 'SiteSettings', 'SiteURL', 'site.ini' )  

  $login_text = ''
  $login_flag = false()

  $help_text_Live_still_to_come = 'This Event is still to come.'
  $help_text_Interactive_still_to_come = 'This Event is still to come.'
  $help_text_live_current = 'This event is now live.'
  $help_text_recorded = 'Here is the recording.'
  $help_text_preview_available = 'Here is a preview.'
  $help_text_trailer_available = 'Here is a trailer.'  
  $help_text_no_trailer = 'Trailer not available.'  
  $help_text_no_preview = 'Preview not available.'  
  $help_text_join_meeting = 'Click to join the interactive meeting.' 
  $help_text_Interactive = 'Here is the interactive event' 
  $help_text_click_to_buy = 'Click to buy to view the full event'
  $help_text_login_and_click_to_buy = 'to buy'
  $help_text_login_and_click_to_donate = 'and Click to donate'
  $help_text_view_full = 'to view the full length recording'
  $help_text_current = 'to join the live event'
  $help_text_not_recorded = 'Recording is not yet available'   
  $help_text_editing = 'Recording will soon be available'   
  $help_text_login = ''

  $os_load = false()

  $interactive_on = false()
  $meeting_url = ''
  $interactive_url = ''
  $event_type = ''
  
}

   {set $recorded_ticketed_product = fetch( 'content', 'node', hash( 'node_id', $node.node_id))}
   {set $recorded_object = fetch( content, object, hash( object_id, $recorded_ticketed_product.contentobject_id ))}  
   {set  $recorded_ticketed_item = fetch( content, related_objects,
                     hash( 'object_id', $recorded_object.main_node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1005',

                     ) )}    
   {set $has_recorded_ticket_access = fetch( 'content', 'access',
                  hash( 'access', 'read',
                        'contentobject', $recorded_ticketed_item.0 ) )}


    {set $item_reverse = fetch( content, reverse_related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1008',
                     ) )}

{debug-log var=$recorded_ticketed_product msg='$recorded_ticketed_product'}
{debug-log var=$recorded_object msg='$recorded_object'}
{debug-log var=$recorded_ticketed_item msg='$recorded_ticketed_item'}

  {if $item_reverse}
     {set $item_object = fetch( content, object, hash( object_id, $item_reverse.0.id ))}  
     {set $item_node = fetch( 'content', 'node', hash( 'node_id', $item_object.main_node) )}

     {set $item_node = $item_object.main_node}
     {set $stream_type = $item_node.data_map.player_type.content.0}   
     {set $type = $item_node.data_map.type.content.0} 
     {set $status = $item_node.data_map.item_status.content.0}
     {set $event = fetch( content, reverse_related_objects,
                     hash( 'object_id', $item_node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '758',

                     ) )}
  {/if}




  {set $login_text = concat('<a target="_blank" href="https://', $hostname, '/user/login?redirect=/', $item_node.url_alias,'">login</a> ')}  
  {set $streaming_url = 'octoshape://streams.octoshape.net/u-sophia/live/flv'} 

  {debug-log var=$has_recorded_ticket_access  msg='$has_recorded_ticket_access'}
     {set $help_text = $help_text_recorded}
     {set $preview = 'Click to Watch'}
     {if $has_recorded_ticket_access}
	 {set $purchased = true()}
        {set $purchased_text = 'Purchased recording'}
        {set $streaming_url = $item_node.data_map.recorded_url.content|trim}
        {set $preview = 'Click to Watch'}
        {set $help_text = $help_text_recorded}
        {set $os_load=true()}
     {elseif $item_node.data_map.recorded_preview_url.has_content}
        {set $preview = 'Preview'}
        {set $streaming_url = $item_node.data_map.recorded_preview_url.content|trim}
        {set $help_text = $help_text_click_to_buy}
        {set $os_load=true()}
     {else}  
        {set $preview = 'Preview'}
        {set $help_text = $help_text_click_to_buy}
     {/if}





<div class="content-view-full" id="player-product">
    <div class="art-center-left-column" >
   
         <div class="block1 ">
           <div class="header">
             <h2>Auditorium - {if eq($stream_type,1)}Audio{else}Video{/if} - {$item_node.name}</h2>
           </div>

           <div class="content-player">     
             <div id="player"></div>   
          
          
          
          {literal}
          <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
          <script type="text/javascript">
            var player_id = 'player';
            var player_width = 400;
            var player_height = 225;
            {/literal}

            var player_stream = 'my_stream';

            {literal}
            
               var player_streams = [
                  {
                    id: 'my_stream',
                    stream: 'octoshape://streams.octoshape.net/u-sophia/live/flv'
                  },
                  {
                    id: 'my_stream_play',  
                    stream:'{/literal}{$streaming_url}{literal}'
                  } 
                ];

            var player_imageOnNostream = '{/literal}{$item_node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
            {/literal}
            {if eq($stream_type,1)}{literal}var player_backgroundImage = '{/literal}{$item_node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';{/literal}{/if}{literal}
            var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
            var attributes = {id: player_id, name: player_id};
            swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
          </script>
         {/literal}
          <div class="streaming">


         {if $os_load} 
                <button id="item-player-click" >{$preview}</button>
         {else}
                <button id="item-player-click">{$preview}</button>
         {/if}  
             
         {if $event}
              {set $object = fetch( content, object, hash( object_id, $event.0.id ))}  
               <div class="event-date-player"><b>Status:</b>{attribute_view_gui attribute=$item_node.data_map.item_status}<br/>{if lt($item_node.data_map.item_status.content.0 ,2)}<b>The event starts at: </b>{elseif eq($item_node.data_map.item_status.content.0 ,2)}<b>Event was recorded at: </b>{/if}<span id='from-time-{$object.main_node.object.data_map.from_time.content.timestamp}'></span> on <span id='from-date-{$object.main_node.object.data_map.from_time.content.timestamp}'></span></div>
                  
                     {literal}
                    <script type='text/javascript'>
                      var date = new Date({/literal}{$object.main_node.object.data_map.from_time.content.timestamp}{literal} * 1000 );
                      x = new Date()
                      currentTimeZoneOffsetInHours = x.getTimezoneOffset()/60; 
                      var year 	= date.getUTCFullYear();
                      var month 	= date.getMonth() + 1; // getMonth() is zero-indexed, so we'll increment to get the correct month number
                      var day		= date.getDate();
                      var hours 	= date.getHours();
                      var minutes = date.getMinutes();
                      var seconds = date.getSeconds();
                      month	= (month < 10) ? '0' + month : month;
                      day		= (day < 10) ? '0' + day : day;
                      hours	= (hours < 10) ? '0' + hours : hours;
                      minutes = (minutes < 10) ? '0' + minutes : minutes;
                      seconds	= (seconds < 10) ? '0' + seconds: seconds;
                      jQuery("#from-date-{/literal}{$object.main_node.object.data_map.from_time.content.timestamp}{literal}").html( day + '/' + month + '/' + year );
                      jQuery("#from-time-{/literal}{$object.main_node.object.data_map.from_time.content.timestamp}{literal}").html( hours + ":" + minutes);
                      </script> 
                    {/literal}

          {/if}

          </div>
         </div>

          <div id="play-info"><div class="content">{$help_text}</div></div>



<div class="art-center-left-column" >

    {if $purchased}
          <div class="action-buttons">
            <div class="button-container"><a href="#">Purchased</a></div>  
          </div>
    {/if}
          <div class="action-buttons">
              <div>
                <div class="pricing">
                   <div class="price">{attribute_view_gui attribute=$node.data_map.price}</div>
                 </div> 
  

    
 

    {if $purchased|not}

            <div style="clear:both; padding-top:10px">
                  <div class="button-container" style="margin-left:0">
                  <form method="post" action={"content/action"|ezurl}>
                    <input type="submit" class="defaultbutton usophia-button" name="ActionAddToBasket" value="{'Buy Now'|i18n("design/ezwebin/full/product")}" />
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                  </form>
                  </div>
    {/if}

{*
              {if $item_node.data_map.register.content}
                <div class="button-container"><a href="#">Register</a></div>
              {/if}
*}
            </div>
          </div> 
          </div> 
            </div>
    
  {literal}
  <script>
      $(function() {
          $( ".products-tabs" ).tabs();
    });
   </script>
