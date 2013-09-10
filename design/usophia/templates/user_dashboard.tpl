{* Dashboard - Full view *}


{def $streaming_array = ezini( concat('Channel_user_role_', '2'), 'Channel', 'usophia.ini' )
     $counter = $streaming_array|count
     $usophia_events=fetch( 'content', 'tree', hash( 'parent_node_id', 2, 
	                                                                  'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                    'main_node_only', true(),
	                                                                  'attribute_filter', array( array( 'event/from_time',
	                                                                                                '>',
	                                                                                                sub( currentdate(),10800) ) )
	                                                                          ))
    $streaming_array1 = array()
    $counter1 = 0 
    $stream_nodes = array()  
    $product_item = false() 
    $limitation_array = array() 
    $url_array = array()
    $current_user = fetch( 'user', 'current_user' )
    $art_centers = fetch( 'content', 'tree', hash( 'parent_node_id', 2, 
                                class_filter_type, include,
                                class_filter_array,array('art_center')
                                        ))
    $channel_item = false()                                    
    $channel_array = array()                             
    $limited_assignment_value_list = $current_user.limited_assignment_value_list
    
    $recording_array_nodes = array()
    $temp_id = array()
    $node_index = 0
    $filename = true()
    $today_events=fetch( 'content', 'tree', hash( 'parent_node_id', 2, 
	                                                                  'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                    'main_node_only', true(),
	                                                                  'attribute_filter', array('and', array( 'event/from_time', '>', sub( currentdate(),10800) ),
                                                                                                     array( 'event/from_time', '<', sub( currentdate(),10800) )      
                                                                    )
	                                                                          ))
}

{foreach $channel_status as $index => $status}
  {set $channel_array = $channel_array|append($index)}
{/foreach}
{*$current_user|attribute(show)*}
{foreach $limited_assignment_value_list as $limitation}
  {set $temp_id = $limitation|explode('/')}
  {if $temp_id|count}
    {set $node_index = $temp_id|count|dec|dec}
    {if ge($node_index,0)}
    {set $limitation_array = $limitation_array|append($temp_id[$node_index])}
    {/if}
  {/if}  
{/foreach}


{foreach $usophia_events as $event}
  {if $event.data_map.related_product.has_content}
    {set $product_item = fetch( content, object, hash( object_id, $event.data_map.related_product.content.relation_list.0.contentobject_id ))}
    {if eq($product_item.data_map.type.content.0 ,0)}
       {set $streaming_array1 = $streaming_array1|append(concat( "id: 'stream-", $product_item.main_node.contentobject_id, "',stream: '", $product_item.main_node.data_map.url.content|trim, "'"))}
       {set $stream_nodes = $stream_nodes|append($product_item.main_node)}
       {set $counter1 = $counter1|inc}
    {/if}
      
  {/if}
{/foreach}

<div class="content-view-full user-dashboard" id="player-product">
  <div class="message">
    {if ezhttp_hasvariable('result', 'get')}
      {if eq(ezhttp('result', 'get'),2)}
         <div class="status-ok">
        Your action has been completed. 
        </div>
      {elseif eq(ezhttp('result', 'get'),3)}
        <div class="status-ok">
           The current status is: {ezhttp('status', 'get')} 
        </div>
      {else}
        <div class="status-fail">
        An error has occurred. Details: {ezhttp('result', 'get')} or contact site administrator.
        </div>
      {/if}
    
    {/if}
  </div>
  <div class="block1 " style="width:600px;">
    <div class="header"><h2>Art Center Control Panel</h2></div>
         <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
        <div id="content-player">
          <div id="player"></div> 
             
          
          {literal}
           
          <script type="text/javascript">
          
           
            var player_id = 'player';
            var player_width = 400;
            var player_height = 225;
            var player_imageOnNostream = '';
            var player_stream = 'my_stream';
                  var player_streams = [ {id: 'my_stream',stream: 'octoshape://streams.octoshape.net/u-sophia'}
            
            {/literal}
            {if gt($counter,0)}
              ,{*this is for the fake stream json to add other element*}
              {foreach $streaming_array as $index => $stream}
                
                {literal}{id: 'stream-{/literal}{$index}{literal}',stream:'{/literal}{$stream}{literal}'}{/literal}{if lt($index|inc, $streaming_array|count)},{/if}
              {/foreach}
            {/if} 
            {if gt($counter1,0)}
              ,{*this is for the fake stream json to add other element*}
              {foreach $streaming_array1 as $index => $stream}
                
                {literal}{{/literal}{$stream}{literal}}{/literal}{if lt($index|inc, $streaming_array|count)},{/if}
              {/foreach}
            {/if}   
            
            {literal}];
  
            
            player_imageOnNostream = '/extension/usophia/design/usophia/images/logo.png';
            var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
            var attributes = {id: player_id, name: player_id};
            swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
          </script>
         {/literal} 
         
         
         
         
        
        
        
        
      </div>
   </div>
   <div class="controller">
      <fieldset> 
        <form action="/usophia/item_update" method="post">
          <select id="art-center-picker" name="artcenter">
            <option value="">Select an Art Center</option>
            {foreach $art_centers as $index => $art_center}
              {if and($limitation_array|contains($art_center.node_id),$current_user.role_id_list|contains(10))} 
                <option value="{$art_center.contentobject_id}">{$art_center.name}</option>
              {elseif $current_user.role_id_list|contains(2)} 
                <option value="{$art_center.contentobject_id}">{$art_center.name}</option>
                  
              {/if}
            {/foreach}
          </select>
          <div class="form-item"><input type="submit" value="Submit"></div> 
        </form>  
       </fieldset>   
   </div>
   <div class="controller">
     <fieldset>  
       <legend>Channel Viewer</legend>
        <select id="channel-picker" name="channel">
          <option value="">Select</option>
          {foreach $streaming_array as $index => $stream}
          <option value="{$index}">{$stream}</option>
          {/foreach}
        </select>
     </fieldset>  
   </div>
   
   <div class="controller" >
     <fieldset>  
       <legend>Recording Control</legend>
         
          <h4>Today's Events</h4>
          {*Show just todays events*}
          <table>
          <thead>
          <tr>
          <th class="event-td">Event</th>
          <th class="channel-td">Ch</th>
          <th class="file-td">File Name</th>
          <th class="status-td">Status</th>
          <th class="recording-td">Recording Control</th>
          </tr>
          </thead>
          <tbody>
          {foreach $channel_array as $channel1}
          {set $filename = true()}
          <tr>
          <td colspan="5">
            <form action="/usophia/octoshape" method="post">
              <table>
                <tbody>
                <tr>
                  <td class="event-td">
                       {set $channel_item = false()}
                      {foreach $stream_nodes as $index => $stream}
                        {set $url_array = $stream.data_map.url.content|explode('/')}
                        {if eq($url_array[6], $channel1)}

                          {if eq($stream.data_map.item_status.content.0, 1)}
                            <input type="hidden" name="channel" value="{$stream.contentobject_id}" />
                            
                              
                            {node_view_gui content_node=$stream view="text_linked"}
                            {set $channel_item = $stream}
                            {break}  
                            
                          {/if}
                        {/if}  
                      {/foreach}
                 
                  
                  </td>
                  <td class="channel-td">
                     
                    {$channel1}
                  </td>
                  <td class="file-td">
                  {if $channel_item}
                    {if $channel_item.data_map.recording_file_name.has_content}
                      {$channel_item.data_map.recording_file_name.content}
                    {else}  
                      No file name set.
                      {set $filename = false()}
                    {/if}    
                  {/if}      
                  </td>
                  
                  <td class="status-td">
                    {$channel_status[$channel1]}
                  </td>
                  <td class="recording-td">
                  
                    <div class="form-item">
                      {if eq($channel_status[$channel1],'Recording')}
                        <input type="submit" name="octoshape_action" value="Record" disabled="disabled"/>
                      {else}
                        <input type="submit" name="octoshape_action" {if $filename|not}disabled="disabled"{/if} value="Record"/>
                      {/if}
                    
                    
                      
                      
                      <input type="submit" name="octoshape_action" value="Stop"/>
                      
                    </div> 
                  </td>
                </tr>
             </tbody>
            </table>
          </form>
          </td>      
        </tr>
        {/foreach}
       </tbody>
      </table>     
     
     </fieldset>  
   </div>
   
   
   
   <div class="controller" >
     <fieldset>  
       <legend>Event Status Control</legend>
       <form action="/usophia/item_update" method="post">
          
          <h4>Choose a date</h4>
          <label>From date</label>
          <input  type="text" name="start_date" class="datepicker"/>
          <label>To date</label>
          <input  type="text" name="end_date" class="datepicker"/>
          <h4>Currrent Events</h4>
          <select id="channel-picker-stream" name="event_oid">
            <option value="">Select</option>
            {foreach $stream_nodes as $index => $stream}
              <option value="{$stream.contentobject_id}">({attribute_view_gui attribute=$stream.data_map.item_status}) {$stream.name}</option>
            {/foreach}
          </select>
          <div class="form-item">

            <h4>Change status to:</h4>
            <select id="channel-picker-stream" name="status">

              <option value="">Select</option>
              <option value="Still to Come">Still to Come</option>
              <option value="Current">Current</option>
              <option value="Recorded">Recorded</option>
              <option value="Not Recorded">Not Recorded</option>
              <option value="Editing">Editing</option>
              <option value="Recorded-Current">Recorded-Current</option>
            </select>
          </div> 
          <div class="form-item"><input type="submit" value="Submit"></div> 
       </form>
     </fieldset>  
   </div>
   
   
  
    <div class="break"></div>
    <a href="#" class="more-link">Back to top&gt;&gt;</a><a href={$node.parent.url_alias|ezurl} class="more-link" >&lt;&lt;Back</a><a href={$node.parent.url_alias|ezurl} class="more-link-top" >&lt;&lt;Back</a>  
</div>
{literal}
<script>
$(document).ready(function() {
  $('#channel-picker').change(function(){
    player.os_load('stream-'+ $(this).val());
  });
   $('#channel-picker-stream').change(function(){
    player.os_load('stream-'+ $(this).val());
  });
  $(function() {
    $( ".datepicker" ).datepicker();
  });
});
</script>
{/literal}

