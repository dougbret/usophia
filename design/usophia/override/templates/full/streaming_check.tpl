{* Streaming - Full view *}


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
}

{foreach $usophia_events as $event}
  {if $event.data_map.related_product.has_content}
    {set $product_item = fetch( content, object, hash( object_id, $event.data_map.related_product.content.relation_list.0.contentobject_id ))}
    {if eq($product_item.data_map.type.content.0 ,0)}
       {set $streaming_array1 = $streaming_array1|append(concat( "id: 'stream-", $product_item.main_node.node_id, "',stream: '", $product_item.main_node.data_map.url.content|trim, "'"))}
       {set $stream_nodes = $stream_nodes|append($product_item.main_node)}
       {set $counter1 = $counter1|inc}
    {/if}
      
  {/if}
{/foreach}

<div class="content-view-full" id="player-product">

      <div class="block1 ">
        <div class="header">
          <h2>Stream Checker</h2>
        </div>
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
            
            {literal}];{/literal}
  
            
            player_imageOnNostream = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
            var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
            var attributes = {id: player_id, name: player_id};
            swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
          </script>
         {/literal} 
         
         
         
         
        </div>
        <h4>Generic</h4>
        <select id="channel-picker" name="channel">
          <option value="">Select</option>
          {foreach $streaming_array as $index => $stream}
          <option value="{$index}">{$stream}</option>
          {/foreach}
        </select>
        <h4>Currrent Events</h4>
        <select id="channel-picker-stream" name="channel">
          <option value="">Select</option>
          {foreach $stream_nodes as $index => $stream}
          <option value="{$stream.node_id}">{$stream.name}</option>
          {/foreach}
        </select>
        
        
      </div>
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
});
</script>
{/literal}

