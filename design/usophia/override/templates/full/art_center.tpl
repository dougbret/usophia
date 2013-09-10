{* Art Center - Full view *}


{if is_set($view_parameters['product_filter'])}
  
<div class="content-view-full">
    <div class="class-folder">
       
            {def $page_limit = 10
                 $classes = array()
                 $children = array()
                 $children_count = ''
                 $class = false()
                 $list_titles = ezini( 'ArtCenterTitles', 'ListTitles', 'usophia.ini' )  
                 $attribute_filter = false()  
            }
            
            
            {if is_set($view_parameters['product_filter'])}
              {set $classes = $classes|merge( $view_parameters['product_filter']|explode(','))}
              {set $class = fetch( 'content', 'class', hash( 'class_id', $view_parameters['product_filter'] ) )}
             
            {/if}
            {if is_set($view_parameters['product_filter'])}
              
              {if eq($view_parameters['product_filter'],'pod')}  
                {if or(eq($node.data_map.type.content.0 ,'0'), eq($node.data_map.type.content.0 ,'3'))}
                  <h1>Mediatheque</h1>
                {elseif or(eq($node.data_map.type.content.0 ,'1'), eq($node.data_map.type.content.0 ,'2'))} 
                  <h1>Participants</h1>
                  
                {else}
                  {if is_set($list_titles[$view_parameters['product_filter']])}
                    <h1>{$list_titles[$view_parameters['product_filter']]}</h1>
                  {else}
                    <h1>{$class.name}</h1>
                  {/if}
                {/if}
              {elseif eq($view_parameters['product_filter'],'item')} 
		         {if eq($view_parameters['item_type'], 1)}<h1>Interactive</h1>
                       {elseif eq($view_parameters['item_type'], 2)}<h1>Mediatheque</h1>
                       {elseif eq($view_parameters['item_type'], 0)}<h1>Streaming</h1>
                       {/if}                       
              {elseif is_set($list_titles[$view_parameters['product_filter']])}
                    <h1>{$list_titles[$view_parameters['product_filter']]}</h1>
              {else}
                    <h1>{$class.name}</h1>
               {/if}
            {else}
              <h1>{$class.name}</h1>
            {/if}

            {if is_set($view_parameters['item_type'])}
               {set $attribute_filter = array( array( 'item/type','=',$view_parameters['item_type'] ) )}
            {/if}
            
            <div class="art-center-back"><a href={$node.url_alias|ezurl}>Back to {$node.name}</a></div> 
            {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                      'class_filter_type', 'include',
                                                                      'attribute_filter', $attribute_filter,
                                                                      'class_filter_array', $classes ) )
                                                                      }

            <div class="content-view-children">
                {if $children_count}
                    {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array('published', false()),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'attribute_filter', $attribute_filter,
                                                            'limit', $page_limit ) ) as $child }
                        {node_view_gui view='line' content_node=$child}
                    {/foreach}
                {else}
                  No items available.     
                {/if}
            </div>
    <div class="art-center-back"><a href={$node.url_alias|ezurl}>Back to {$node.name}</a></div> 
            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

    </div>
</div>

{elseif is_set($view_parameters['admin'])}
   {set-block scope=root variable=cache_ttl}0{/set-block} 
   
   
   {def $streaming_array = $node.data_map.allowed_stream_list.content
     $options = $node.object.content_class.data_map.allowed_stream_list.content.options
     $counter = $streaming_array|count
     
     $usophia_events=fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id, 
	                                                                  'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                    'main_node_only', true(),
	                                                                  'attribute_filter', array( array( 'event/from_time',
	                                                                                                '>',
	                                                                                                sub( currentdate(),2592000) ) )
	                                                                          ))
    $streaming_array1 = array()
    $counter1 = 0 
    $stream_nodes = array()  
    $product_item = false() 
    $limitation_array = array() 
    $url_array = array()
    $current_user = fetch( 'user', 'current_user' )
    $art_centers = fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id, 
                                class_filter_type, include,
                                class_filter_array,array('art_center')
                                        ))
    $channel_item = false()                                    
    $channel_string = ''                                    
    $channel_array = array()                             
    $limited_assignment_value_list = $current_user.limited_assignment_value_list
    
    $recording_array_nodes = array()
    $temp_id = array()
    $node_index = 0
    $filename = true()
    $channel_status = octoshape_status($node.contentobject_id)
    $today_events=fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id, 
	                                                                  'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                    'main_node_only', true(),
	                                                                  'attribute_filter', array('and', array( 'event/from_time', '>', sub( currentdate(),10800) ),
                                                                                                     array( 'event/from_time', '<', sub( currentdate(),10800) )      
                                                                    )
	                                                                          ))
}
{if $current_user.role_id_list|contains(2)}



  {foreach $channel_status as $index => $status}
    {set $channel_string = $status[$index]}
    {set $channel_array = $channel_array|append($index)}
  {/foreach}
  
  

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

      {set $stream_nodes = $stream_nodes|append($product_item.main_node)}
      {set $counter1 = $counter1|inc}

        
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
    <div class="header"><h2>{$node.name} - Art Center Control Panel</h2></div>
         <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
        <div id="content-player" style="width: 425px;">
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
            {*if gt($counter,0)}
              ,
              {foreach $streaming_array as $index => $stream}
                
                {literal}{id: 'stream-{/literal}{$index}{literal}',stream:'{/literal}{$stream}{literal}'}{/literal}{if lt($index|inc, $streaming_array|count)},{/if}
              {/foreach}
            {/if} 
            {if gt($counter1,0)}
              ,
              {foreach $streaming_array1 as $index => $stream}
                
                {literal}{{/literal}{$stream}{literal}}{/literal}{if lt($index|inc, $streaming_array|count)},{/if}
              {/foreach}
            {/if*}   
            
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
       <legend>Channel Viewer</legend>
        <select id="channel-picker" name="channel">
          <option value="">Select</option>
          {foreach $channel_status as $index => $stream}
          <option value="{$stream['channel']}">{$index}</option>
          {/foreach}
        </select>
     </fieldset>  
   </div>
   
   <div class="controller" >
     <fieldset>  
       <legend>Event Status Control</legend>
       <form action="/usophia/item_update" method="post">
          
          <div>
            <h4>Choose a date</h4>
            <div class="date-filter">
              <label>From date</label>
              <input  type="text" name="start_date" class="datepicker"/>
            </div>
            <div class="date-filter">
              <label>To date</label>
              <input  type="text" name="end_date" class="datepicker"/>
            </div>
          </div>
          <div style="clear:both">
             <div class="date-filter">
            <h4>Change Event Status</h4>
            <select id="channel-picker-stream" name="event_oid">
              <option value="">Select</option>
              {foreach $stream_nodes as $index => $stream}
                <option value="{$stream.contentobject_id}">({attribute_view_gui attribute=$stream.data_map.item_status}|{attribute_view_gui attribute=$stream.data_map.type}) {$stream.name}</option>
              {/foreach}
            </select>
            </div>
             <div class="date-filter">
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
            </div> 
          </div>
          <div style="clear:both; padding-top:20px;padding-bottom:20px; float:left">
          <div class="form-item"><input type="submit" value="Submit"></div> 
          </div>
          <input type="hidden" name="redirect_nid" value="{$node.node_id}"/>
       </form>
     </fieldset>  
   </div>
   
   <div class="controller" >

     <fieldset>  
       <legend>Recording Control ( This table shows only items which are in 'Current Status')</legend>
         
          
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
                            {*if is_set($channel_status[$channel1]['filename'])*}  
                              {*if eq($stream.data_map.recording_file_name.content, $channel_status[$channel1]['filename'])*}
                                <input type="hidden" name="channel" value="{$stream.contentobject_id}" />
                                {node_view_gui content_node=$stream view="text_linked"}
                                {set $channel_item = $stream}
                                {break} 
                                
                              {*/if*}
                            {*/if*}
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
                  {if is_set($channel_status[$channel1]['recording'])}
                    {$channel_status[$channel1]['status']}({$channel_status[$channel1]['recording']}/{$channel_status[$channel1]['total']})
                  {else}
                    {$channel_status[$channel1]['status']}
                  {/if}  
                  </td>
                  <td class="recording-td">
                  
                    <div class="form-item">
                      {if eq($channel_status[$channel1]['status'],'Recording')}
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
             <input type="hidden" name="redirect_nid" value="{$node.node_id}"/>
          </form>
          </td>      
        </tr>
        {/foreach}
       </tbody>
      </table>     
     
     </fieldset>  
   </div>
   
  
   
   
   
   
  
    <div class="break"></div>
    <a href="#" class="more-link">Back to top&gt;&gt;</a><a href={$node.parent.url_alias|ezurl} class="more-link" >&lt;&lt;Back</a><a href={$node.parent.url_alias|ezurl} class="more-link-top" >&lt;&lt;Back</a>  
    </div>
    {literal}
    <script>
    $(document).ready(function() {
      $('#channel-picker').change(function(){
        player.os_load($(this).val());
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

  {/if}

{else}

  {def $streaming_products = array()                                  
       $interactive_products = array()
       $also_available = array()                                                     
       $mediatheque_items = array() 
       $block_titles = ezini( 'ArtCenterTitles', 'BlockTitles', 'usophia.ini' )  
       
       $new_noteworthy = array()
       $about = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      limit, 1,
                                                      class_filter_array, array('about_art_center'),
                                                      sort_by, array('priority', true())      
                                                      ))
                                                      
       $pod = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      limit, 5,
                                                      class_filter_array, array('pod'),
                                                      sort_by, array('priority', true())      
                                                      ))      
        
       $recommendation = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('recommendation'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      )) 
       $workinprogress = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('work_in_progress'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))
       $onthenet = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('on_the_net'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))
       $lookingfor = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('looking_for'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))
       $media = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('media_art_center'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))                                                    
                                                      
       $object = false() 
       $object1 = false() 
       $contains_streaming = 0
       $contains_interactive = 0       
  }
  {foreach $node.data_map.news_and_noteworthy.content.relation_list as $item}
    {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
    {set $new_noteworthy = $new_noteworthy|append($object.main_node)}  
  {/foreach}

  {foreach $node.data_map.products.content.relation_list as $product}
    {set $object = fetch( content, object, hash( object_id, $product.contentobject_id ))}  
    {switch match=$object.class_identifier}

      {case match='item'} 
        {if eq($object.main_node.data_map.type.content.0 ,0)} 
          {set $streaming_products = $streaming_products|append($object.main_node)} 
        {elseif eq($object.main_node.data_map.type.content.0 ,1)}
          {set $interactive_products = $interactive_products|append($object.main_node)}
        {else}    
          {set $mediatheque_items = $mediatheque_items|append($object.main_node)}
        {/if}
      {/case}
      {case match='item_series'} 
        {set $contains_streaming = 0}
        {set $contains_interactive = 0}
        {foreach $object.main_node.data_map.series_items.content.relation_list as $index2 => $item2}
            {set $object1 = fetch( content, object, hash( object_id, $item2.contentobject_id ))} 
            {if eq($object1.main_node.data_map.type.content.0 ,0)}
              {set $contains_streaming = $contains_streaming|inc} 
            {else}
              {set $contains_interactive = $contains_interactive|inc}  
            {/if}
        {/foreach}
        
        {if gt($contains_streaming,0)} 
          {set $streaming_products = $streaming_products|append($object.main_node)} 
        {/if}
        {if gt($contains_interactive,0)}  
          {set $interactive_products = $interactive_products|append($object.main_node)}
        {/if}  
          
      {/case}
      {case match='product_usophia'} 
        {set $also_available = $also_available|append($object.main_node)} 
      {/case}

    {/switch}
    
  {/foreach}
      <div class="content-view-full">
          <div class="art-center-left-column ">
            <div class="block1 products-tabs">
              <div class="header">
                <div class="tabs">
                  <ul class="event-tabs">
                    <li class="active"><a href="#streaming-tab">Streaming</a></li>
                    <li><a href="#vod-tab">{$block_titles['vod']}</a></li>
                    <li><a href="#usophia-product-tab" id="tab-also-available">{$block_titles['product_usophia']}</a></li>
                    <li class="last"><a href="#event-tab">{$block_titles['comprehensive_event']}</a></li>
                  </ul>
                </div>
              </div>
              <div class="content">
                <div id="streaming-tab">
                {foreach $streaming_products as $item}
                  {node_view_gui content_node=$item view=line_art_center watch_it=1 status=1}
                {/foreach}
                  <div class="ac-see-all-left"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/item_series">See all Series &gt;&gt;</a></div>
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/item/(item_type)/0">See all {$block_titles['streaming_product']} &gt;&gt;</a></div>
                </div>
                <div id="vod-tab">
                {foreach $interactive_products as $item}
                  {node_view_gui content_node=$item view=line_art_center watch_it=1 status=1}
                {/foreach}
                <div class="ac-see-all-left"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/item_series">See all Series &gt;&gt;</a></div>
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/item/(item_type)/1">See all {$block_titles['vod']} &gt;&gt;</a></div>
                </div>
                <div id="usophia-product-tab">
                {foreach $also_available as $item}
                  {node_view_gui content_node=$item view=line_art_center watch_it=1}
                {/foreach}
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/product_usophia">See all {$block_titles['product_usophia']} &gt;&gt;</a></div>
                </div>
                <div id="event-tab">
                {foreach $mediatheque_items as $item}
                  {node_view_gui content_node=$item view=line_art_center watch_it=1}
                {/foreach}
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/item/(item_type)/2">See all {$block_titles['comprehensive_event']} &gt;&gt;</a></div>
                </div>
                
              </div>
            </div>
            <div class="block1 news-noteworthy-block">
              <div class="header">
                <h2>{$block_titles['article']}</h2>
              </div>
              <div class="content" >
                {foreach $new_noteworthy as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/article,article_art_center">See all &gt;&gt;</a></div>
            </div>
          </div>
          <div class="art-center-right-column">
            <div class="block1 fifty-width left-block ">
              <div class="header">
                <h2>{$block_titles['recommendation']}</h2>
              </div>
              <div class="content">
                {foreach $recommendation as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/recommendation">See all &gt;&gt;</a></div>
            </div>  
            <div class="block1 fifty-width">
              <div class="header">
                <h2>{$block_titles['about']}</h2>
              </div>
              <div class="content">
                {foreach $about as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              
            </div>
            <div class="block1 fifty-width left-block products-tabs">
              <div class="header">
                <div class="tabs">
                  <ul class="event-tabs-wl">
                    <li class="ui-tabs-selected ui-state-active"><a  href="#work-tab">{$block_titles['work_in_progress']}</a></li>
                    <li><a href="#look-tab">{$block_titles['looking_for']}</a></li>
                  </ul>
                </div>
              </div>
              <div class="content">
                 <div id="work-tab">
                  {foreach $workinprogress as $item}
                    {node_view_gui content_node=$item view=line_art_center}
                  {/foreach}
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/work_in_progress">See all &gt;&gt;</a></div>
                </div>
                <div id="look-tab">
                  {foreach $lookingfor as $item}
                    {node_view_gui content_node=$item view=line_art_center}
                  {/foreach}
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/looking_for">See all Looking for &gt;&gt;</a></div>
                </div>
               
              </div>
            </div>
            <div class="block1 fifty-width products-tabs">
              <div class="header">
                <div class="tabs">
                  <ul class="event-tabs-media">
                    <li class="ui-tabs-selected ui-state-active"><a  href="#media-tab">{$block_titles['media']}</a></li>
                    <li><a href="#onthenet-tab">{$block_titles['on_the_net']}</a></li>
                  </ul>
                </div>
              </div>
              <div class="content">
                <div id="media-tab">
                  {foreach $media as $item}
                    {node_view_gui content_node=$item view=line_art_center}
                  {/foreach}
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/media_art_center">See all Media &gt;&gt;</a></div>
                </div>
                <div id="onthenet-tab">
                  {foreach $onthenet as $item}
                    {node_view_gui content_node=$item view=line_art_center}
                  {/foreach}
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/on_the_net">See all On the Net &gt;&gt;</a></div>
                </div>
                
              </div>
            </div>
            
            
            <div class="block1 news-noteworthy-block members-block">
              <div class="header">
              
              {if or(eq($node.data_map.type.content.0 ,'0'), eq($node.data_map.type.content.0 ,'3'))}
                <h2>Repertoire</h2>
              {elseif or(eq($node.data_map.type.content.0 ,'1'), eq($node.data_map.type.content.0 ,'2'))} 
                <h2>Participants</h2>
              {else}  
                <h2>{$block_titles['pod']}</h2>
              {/if}
              </div>
              <div class="content">
                {foreach $pod as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/pod">See all &gt;&gt;</a></div>
            </div>
            
          
          </div>
          <div class="break"></div>
          <a href="#" class="more-link">Back to top&gt;&gt;</a><a href="/" class="more-link" onclick="history.go(-1); return false;">&lt;&lt;Back</a><a href="/" class="more-link-top" onclick="history.go(-1); return false;">&lt;&lt;Back</a> 
      </div>
  {literal}
  <script>
      $(function() {
          $( ".products-tabs" ).tabs();
    });
   </script>
  {/literal}
{/if}  