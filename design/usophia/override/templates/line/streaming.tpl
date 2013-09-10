{* Streaming - Line view *}
{def $items_array = array()
     $object1 = false()
     $object = false()
     $edit = fetch( 'content', 'access',
                  hash( 'access', 'edit',
                        'contentobject', $node ) )
                        
    $user = fetch( 'user', 'current_user' )  
  
}
{if $node.data_map.streaming_item.has_content}

  {set $object1 = fetch( content, object, hash( object_id, $node.data_map.streaming_item.content.relation_list.0.contentobject_id ))}
  {if $object1.main_node.data_map.recorded_url.has_content}
    {set $items_array = $items_array|append(concat("id: 'my_stream_", $object1.main_node.node_id, "',stream: '",$object1.main_node.data_map.recorded_url.content|trim,"'"))}
  {else}
    {set $items_array = $items_array|append(concat("id: 'my_stream_", $object1.main_node.node_id, "',stream: '",$object1.main_node.data_map.url.content|trim,"'"))}
  {/if}  
{/if}
{if $node.data_map.recorded_item.has_content}
  {set $object = fetch( content, object, hash( object_id, $node.data_map.recorded_item.content.relation_list.0.contentobject_id ))}
  {if $object.main_node.data_map.recorded_url.has_content}
    {set $items_array = $items_array|append(concat("id: 'my_stream_", $object.main_node.node_id, "',stream: '",$object.main_node.data_map.recorded_url.content|trim,"'"))}
  {else}
    {set $items_array = $items_array|append(concat("id: 'my_stream_", $object.main_node.node_id, "',stream: '",$object.main_node.data_map.url.content|trim,"'"))}
  {/if}  
{/if}

<div class="content-player">
  <div id="player"></div> 
  {literal}
  <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
  <script type="text/javascript">
    var player_id = 'player';
    var player_width = 490;
    var player_height = 275;
    var player_stream = 'my_stream';
    var player_streams = [{id: 'my_stream', stream: 'octoshape://streams.octoshape.net/u-sophia/live/flv'}
    {/literal}   
    {if $items_array|count},{/if}
    {foreach $items_array as $item}
      {literal}{{/literal}{$item}{literal}}{/literal}{if lt($index,$items_array|count)},{/if}
    {/foreach}
    {literal}
    ];
    {/literal}{if $node.data_map.streaming_item.has_content}{literal}
    var player_imageOnNostream = '{/literal}{$object1.main_node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
    {/literal}{else}{literal}
    var player_imageOnNostream = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
    {/literal}{/if}{literal}
    var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
    var attributes = {id: player_id, name: player_id};
    swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
  </script>
 {/literal}  
  <div class="streaming">
    {if $node.data_map.streaming_item.has_content}
{*
      {if or($object1.main_node.data_map.streaming_required_login.content, $object1.main_node.data_map.recorded_required_login.content)}
          {set $required_login = true()}  
      {/if}
*}        
      {if $node.data_map.button_text.has_content}
        <button onclick="player.os_load('my_stream_{$object1.main_node.node_id}');">{$node.data_map.button_text.content}<br>{attribute_view_gui attribute= $object1.main_node.data_map.item_status}</button>
      {else}
        <button onclick="player.os_load('my_stream_{$object1.main_node.node_id}');">{$object1.main_node.data_map.button_text.content}<br>{attribute_view_gui attribute= $object1.main_node.data_map.item_status}</button>
      {/if}
{*
      {if and($user.is_logged_in|not, $required_login)}
        </a>
      {/if}
*}
    {/if}  
    {if $node.data_map.recorded_item.has_content}
{*
      {if or($object1.main_node.data_map.streaming_required_login.content, $object1.main_node.data_map.recorded_required_login.content)}
          {set $required_login = true()}  
      {/if}
*}        
      {if $node.data_map.button_text.has_content}
        <button {if $node.data_map.streaming_item.has_content}style="float:right; margin-right:10px" {/if} onclick="player.os_load('my_stream_{$object.main_node.node_id}');">{$node.data_map.button_text.content}<br>{attribute_view_gui attribute=$object.main_node.data_map.item_status}</button>

      {else}
        <button {if $node.data_map.streaming_item.has_content}style="float:right; margin-right:10px" {/if} onclick="player.os_load('my_stream_{$object.main_node.node_id}');">{$object.main_node.data_map.button_text.content}<br>{attribute_view_gui attribute=$object.main_node.data_map.item_status}</button>
      {/if}
{* 
        {if and($user.is_logged_in|not, $required_login)}
        </a>
      {/if}
*}
    {/if}
     {if $edit}
        <div class="edit-link"><a href="/content/edit/{$node.object.id}">Edit</a></div>
      {/if}
  </div>
</div>
