{* Item - Full view *}

{def $streaming_products = array()                                  
  $block_titles = ezini( 'ArtCenterTitles', 'BlockTitles', 'usophia.ini' )  
  $article_art_center = array()
  $stream_type = $node.data_map.player_type.content.0   
  $type = $node.data_map.type.content.0   
  $object =false()  
  $series =false()  
  $product = array()
  $event = fetch( content, reverse_related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '758',

                     ) )
  $series_reverse = fetch( content, reverse_related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '913',

                     ) )                   

  $user = fetch( 'user', 'current_user' )
  $streaming_object = ''
  $recorded_object = '' 
  $interactive_object = ''

  $streaming_ticketed_product = fetch( content, related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1006',

                     ) )                         


  $recorded_ticketed_product = fetch( content, related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1008',

                     ) )                         

 
  $interactive_ticketed_product = fetch( content, related_objects,
                     hash( 'object_id', $node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1007',

                     ) )                         
  $streaming_ticketed_item = false()
  $recorded_ticketed_item = false()
  $interactive_ticketed_item = false()

  $has_streaming_ticket_access = false() 
  $has_interactive_ticket_access = false()
  $has_recorded_ticket_access = false()

  $interactive_entitled = false()

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
  $help_text_login_and_click_to_donate = 'and Click to donate'
  $help_text_view_full = 'to view the full length recording'
  $help_text_current = 'to join the live event'
  $help_text_not_recorded = 'Recording is not yet available'   
  $help_text_editing = 'Recording will soon be available'   
  $help_text_login = ''

  $interactive_on = false()
  $meeting_url = ''
  $interactive_url = ''

  $event_type = ''

  $os_load = false()

  $flag_view_node_gui_product = false()
  
}


{if $series_reverse}
  {set $series = fetch( content, object, hash( object_id, $series_reverse.0.id ))}
{/if}

{foreach $node.data_map.products_to_consider.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $product = $product|append($object.main_node)}  
{/foreach}

{foreach $node.data_map.news_and_noteworthy.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $article_art_center = $article_art_center|append($object.main_node)}  
{/foreach}

  {set $login_text = concat('<a target="_blank" href="https://', $hostname, '/user/login?redirect=/', $node.url_alias,'">login</a> ')}  
  {set $streaming_url = 'octoshape://streams.octoshape.net/u-sophia/live/flv'} 

{debug-log var=$streaming_ticketed_product msg='$streaming_ticketed_product'}
{debug-log var=$interactive_ticketed_product msg='$interactive_ticketed_product'}
{debug-log var=$recorded_ticketed_product msg='$recorded_ticketed_product'}

  {if $streaming_ticketed_product.0}
       {set $streaming_object = fetch( content, object, hash( object_id, $streaming_ticketed_product.0.id ))}  
       {set  $streaming_ticketed_item = fetch( content, related_objects,
                     hash( 'object_id', $streaming_object.main_node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '997',

                     ) )}    
     {set $has_streaming_ticket_access = fetch( 'content', 'access',
                  hash( 'access', 'read',
                        'contentobject', $streaming_ticketed_item.0 ) )}

  {/if}

  {if $recorded_ticketed_product.0}
       {set $recorded_object = fetch( content, object, hash( object_id, $recorded_ticketed_product.0.id ))}  
       {set  $recorded_ticketed_item = fetch( content, related_objects,
                     hash( 'object_id', $recorded_object.main_node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1005',

                     ) )}    
     {set $has_recorded_ticket_access = fetch( 'content', 'access',
                  hash( 'access', 'read',
                        'contentobject', $recorded_ticketed_item.0 ) )}

  {/if}

  {if $interactive_ticketed_product.0}
       {set $interactive_object = fetch( content, object, hash( object_id, $interactive_ticketed_product.0.id ))}  
       {set  $interactive_ticketed_item = fetch( content, related_objects,
                     hash( 'object_id', $interactive_object.main_node.contentobject_id,
                           as_object, true(),
                           attribute_identifier, '1001',

                     ) )}    
     {set $has_interactive_ticket_access = fetch( 'content', 'access',
                  hash( 'access', 'read',
                        'contentobject', $interactive_ticketed_item.0 ) )}

  {/if}


  {debug-log var=$has_streaming_ticket_access  msg='$has_streaming_ticket_access'}
  {debug-log var=$has_recorded_ticket_access  msg='$has_recorded_ticket_access'}
  {debug-log var=$has_interactive_ticket_access  msg='$has_interactive_ticket_access'}

               


{if $user.is_logged_in}
     {if eq($type,1)}
        {set $interactive_entitled=true()}
     {/if}  
{/if} 



{switch match=$node.data_map.item_status.content.0} 
 
 {case match = 4}

{debug-log  msg='case 4'}
     {set $preview = 'Editing'} 
     {set $help_text = $help_text_editing}
     {/case}
 
  {case match = 3}
{debug-log  msg='case 3'}
     {set $preview = 'Not archived'}
     {set $help_text = $help_text_not_recorded}   
     {/case}

  {case match = 0}
{debug-log  msg='case 0'}
     {if and($streaming_ticketed_product.0, eq($type,0))}
       {set $flag_view_node_gui_product = true()}
{debug-log var=$streaming_object.main_node msg='streaming object before view_gui'}
       {node_view_gui content_node=$streaming_object.main_node view=line} 
{*     {node_view_gui content_node=$object.main_node view=line_art_center watch_it=1 status=1 type=1 table=1}    *}
{debug-log msg='after streaming view_gui'}
        {break}
     {/if} 

     {if and($interactive_ticketed_product.0, eq($type,1))}
       {set   $flag_view_node_gui_product = true()}
{debug-log var=$ineractive_object.main_node msg='interactive object before view_gui'}
       {node_view_gui content_node=$interactive_object.main_node view=line} 
{debug-log msg='after interactive view_gui'}
        {break}
     {/if} 

     {set $preview = 'Trailer'}
     {if $node.data_map.streaming_preview_url.has_content|not}
        {if ne($type,1)} {* not interactive *}
           {set $help_text = concat($help_text_no_trailer, $help_text_Live_still_to_come)}
        {else}
           {set $help_text = concat($help_text_no_trailer, $help_text_Interactive_still_to_come)}
        {/if} 
     {else}          
        {set $streaming_url = $node.data_map.streaming_preview_url.content|trim}
        {if ne($type,1)}
           {set $help_text = $help_text_Live_still_to_come}
        {else}
           {set $help_text = $help_text_Interactive_still_to_come}
        {/if}
        {set $os_load=true()}
     {/if}
     {/case}

  {case match = 1}
{debug-log  msg='case 1'}
     {if and($streaming_ticketed_product.0, eq($type,0))}
{debug-log var=$streaming_object.main_node msg='streaming object before view_gui'}
       {set   $flag_view_node_gui_product = true()}
       {node_view_gui content_node=$streaming_object.main_node view=line} 
{debug-log msg='after view_gui'}
        {break}
     {/if} 
     {if and($interactive_ticketed_product.0, eq($type,1))}
{debug-log var=$ineractive_object.main_node msg='interactive object before view_gui'}
       {set   $flag_view_node_gui_product = true()}
       {node_view_gui content_node=$interactive_object.main_node view=line} 
{debug-log msg='after interactive view_gui'}
        {break}
     {/if}

     {if ne($type,1)} {* streaming *}
        {set $preview = 'Click to Watch'}
        {set $help_text = $help_text_Live_current}
        {set $streaming_url = $node.data_map.url.content|trim}
        {set $os_load=true()}
     {else}   {* interactive *}
        {if $has_interactive_ticket_access}
           {set $preview = 'join meeeting'}
           {set $interactive_on = true()}
           {set $help_text = $help_text_join meeting}
        {elseif interactive_entitled}
           {set $preview = 'join meeeting'}
           {set $interactive_on = true()}
           {set $help_text = $help_text_join meeting}
        {elseif $node.data_map.streaming_preview_url.has_content}
           {set $preview = 'Trailer'}
           {set $streaming_url = $node.data_map.streaming_preview_url.content|trim}
           {set $help_text = $help_text_Interactive}
           {set $help_text_login = $help_text_join_meeting}
           {set $login_flag = true()}
           {set $os_load=true()}
        {else} 
           {set $preview = 'Trailer'}
           {set $help_text = concat($help_text_no_trailer, $help_text_Interactive)}
           {set $help_text_login = $help_text_view_full}
           {set $login_flag = true()}
        {/if}  
     {/if}  
{debug-log  msg='end case 1'}
     {/case}

  {case match = 2}
{debug-log  msg='case 2'}
     {if $recorded_ticketed_product.0}
{debug-log var=$recorded_object.main_node msg='recorded object before view_gui'}
       {set   $flag_view_node_gui_product = true()}
       {node_view_gui content_node=$recorded_object.main_node view=line} 
{debug-log msg='after view_gui'}
        {break}
     {/if}
{debug-log  msg='item.tpl - recording'}
     {set $preview = 'Click to Watch'}
     {set $streaming_url = $node.data_map.recorded_url.content|trim}
{debug-log  var=$streaming_url msg='streaming url'}
     {set $help_text = $help_text_recorded}
     {set $os_load=true()}
{debug-log  msg='end case 2'}
     {/case}



  {case match = 5}
{debug-log  msg='case 5'}
     {if $recorded_ticketed_product.0}
{debug-log var=$recorded_object.main_node msg='recorded object before view_gui'}
       {set   $flag_view_node_gui_product = true()}
       {node_view_gui content_node=$recorded_object.main_node view=line} 
{debug-log msg='after view_gui'}
        {break}
     {/if}

     {set $preview = 'Click to Watch'}
     {set $streaming_url = $node.data_map.recorded_url.content|trim}
     {set $help_text = $help_text_recorded}
     {set $os_load=true()}
     {/case}



     {case}
{debug-log  msg='default switch'}
     {/case}

  {/switch}

{debug-log  msg='end of switch'}


{if $flag_view_node_gui_product|not}
{debug-log  var = $flag_view_node_gui_product msg='start of $flag_view_node_gui_product'}
   <div class="content-view-full" id="player-product">
    <div class="art-center-left-column" >
   {if $interactive_on|not}     
         <div class="block1 ">
           <div class="header">
             <h2>Auditorium - {if eq($type,1)}Interactive Event{elseif eq($stream_type,1)}Audio{else}Video{/if} - {$node.name}</h2>
           </div>

           <div class="content-player">     
             <div id="player"></div>   
          
{debug-log  var=$streaming_url msg=' before player streaming url'}          
          
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

            var player_imageOnNostream = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
            {/literal}
            {if eq($stream_type,1)}{literal}var player_backgroundImage = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';{/literal}{/if}{literal}
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
               <div class="event-date-player"><b>Status:</b>{attribute_view_gui attribute=$node.data_map.item_status}<br/>{if lt($node.data_map.item_status.content.0 ,2)}<b>The event starts at: </b>{elseif eq($node.data_map.item_status.content.0 ,2)}<b>Event was recorded at: </b>{/if}<span id='from-time-{$object.main_node.object.data_map.from_time.content.timestamp}'></span> on <span id='from-date-{$object.main_node.object.data_map.from_time.content.timestamp}'></span></div>
                  
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
         </div>

          <div id="play-info"><div class="content">{$help_text}</div></div>

   {/if}   {* end of    $interactive_on|not *}


   {if $interactive_on}
          <div class="block1">
            <div class="header">
              <h2>Interactive Event</h2>
            </div>
            <div class="interactive-preview">
              <img src="{$node.data_map.preview_image.content['player_preview'].url|ezroot(no)}"/>
           {if $event}
                {set $object = fetch( content, object, hash( object_id, $event.0.id ))} 
                    <div class="event-date-player-interactive">The event starts at: <br/><span id='from-time-{$object.main_node.object.data_map.from_time.content.timestamp}'></span> on <span id='from-date-{$object.main_node.object.data_map.from_time.content.timestamp}'></span> </div>
               		
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



             <div class="action-buttons">
              {if $event}
                {if $event.0.data_map.link.has_content}
                      {if eq($object.main_node.data_map.meeting_type.content.0,0)}
                         {set $event_type = 'JM'}
                      {else}  
                         {set $event_type = 'JE'}
                      {/if}
                      {set $meeting_url = $object.main_node.data_map.link.content|trim|explode('/')}
                      {set $interactive_url = concat('"',$meeting_url[0],'//',$meeting_url[2],'/',$meeting_url[3],'/m.php?AT=',$event_type,'&MK=',$object.main_node.data_map.meeting_id.content|trim,'&AN=',$user.login,'&AE=',$user.email,'&FN=',$user.contentobject.data_map.first_name.content,'&LN=',$user.contentobject.data_map.last_name.content,'&BU=http://', $hostname, '/', $node.url_alias|ezurl,'"')}
                      <div class="button-container"><a target="_blank" href={$interactive_url}>Join the event</a></div>
                {else}
                      <div class="button-container"><a href="#">No event link</a></div>
                {/if}
              {else}
                    <div class="button-container"><a href="#">No event</a></div>
              {/if}
             </div>
            </div>


   {/if}  {* end of    $interactive_on} *}
{debug-log  var = $flag_view_node_gui_product msg='end of $flag_view_node_gui_product'}

{/if}  {*  end of $flag_view_node_gui_product|not    *}

   <div class="art-center-left-column" >

                {if $node.data_map.donate.content}
{*                  <div class="button-container" style="margin-left:0">  *}
                <div class="button-container" style="float:right"> 
{*                 {let donate_node=fetch('content','node',hash('node_id',3257))}  *}
                    <input class="clear-button blue-bg" type="submit"  name="NewButton" value="Donate" onclick="window.location={"/The-U-Sophia-Democracy/U-Sophia-is-an-Art-democracy"|ezurl('single')};" />                      
                 </div>
 {*                {/let}  *}
                {/if}



      {if $series}
        <div class="block1" id="item-description">
          <div class="content" style="height:auto !important;">
            <div>
               <strong>{$node.name|wash()}</strong>
               <div class="body">

                 {attribute_view_gui attribute=$node.data_map.body}
               
               </div>
               
            </div>
          </div>
         
        </div>
      {/if}  
      <div class="block1 want-consider want-to-consider">
        <div class="header">
          <h2>You might also want to consider...</h2>
        </div>
        <div class="content" >
          {foreach $product as $item}
            {node_view_gui content_node=$item view=line_art_center}
          {/foreach}
        </div>
        <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/article">See all &gt;&gt;</a></div>
      </div>
      {if $node.data_map.formatted_body.content}
         <div class="block1 products-tabs new-noteworthy-sp">
        <div class="header">
          <div class="tabs">
            <ul class="event-tabs-media">
              <li class="ui-tabs-selected ui-state-active"><a  href="#media-tab">{$block_titles['article']}</a></li>
              <li><a href="#onthenet-tab">Comments/Reviews</a></li>
            </ul>
          </div>
        </div>
        <div class="content">
          <div id="media-tab">
            {foreach $article_art_center as $item}
              {node_view_gui content_node=$item view=line_art_center}
            {/foreach}
            <div class="ac-see-all"><a href="#">See all &gt;&gt;</a></div>
          </div>
          <div id="onthenet-tab">
            {foreach $onthenet as $item}
              {node_view_gui content_node=$item view=line_art_center}
            {/foreach}
            
             <div class="add-comments"><a href="#">Add a comment &gt;&gt;</a></div>
          </div>
          
        </div>
      </div>  
      </div>       
     {/if}

 
    </div>
    <div class="art-center-right-column">

    {if $series}
       <div class="block1" id="streaming-list">
        <div class="header"> 
          <h2>{$series.main_node.name|wash()}</h2>
        </div>
        <div class="content" >
          {foreach $series.main_node.data_map.series_items.content.relation_list as $index => $item}
            {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
            {*if ne($object.main_node.node_id, $node.node_id)*}
              {node_view_gui content_node=$object.main_node view=line_art_center watch_it=1 status=1 type=1 table=1}
            {*/if*}
          {/foreach}
        

        
          
          <strong>{$series.main_node.name|wash()}</strong>
          <div class="body">
               {attribute_view_gui attribute=$series.main_node.data_map.body}
             
          </div>

        </div>
         
      </div>
    {else}
        <div class="block1 left-block" id="item-description">
          <div class="header">
            <h2>{$node.name|wash()}</h2>
          </div>
          <div class="content" style="height:auto !important;">
            <div>
     
               <strong>{$node.name|wash()}</strong>
               <div class="body">
                 {attribute_view_gui attribute=$node.data_map.body}
               
               
               </div>
               
            </div>
          </div>
         
        </div> 
        {if $node.data_map.formatted_body.content|not}
        <div class="block1 products-tabs new-noteworthy-sp">
          <div class="header">
            <div class="tabs">
              <ul class="event-tabs-media">
                <li class="ui-tabs-selected ui-state-active"><a  href="#media-tab">{$block_titles['article']}</a></li>
                <li><a href="#onthenet-tab">Comments/Reviews</a></li>
              </ul>
            </div>
          </div>
          <div class="content">
            <div id="media-tab">
              {foreach $article_art_center as $item}
                {node_view_gui content_node=$item view=line_art_center}
              {/foreach}
              <div class="ac-see-all"><a href="#">See all &gt;&gt;</a></div>
            </div>
            <div id="onthenet-tab">
              {foreach $onthenet as $item}
                {node_view_gui content_node=$item view=line_art_center}
              {/foreach}
              
               <div class="add-comments"><a href="#">Add a comment &gt;&gt;</a></div>
            </div>
            
            
          </div>
        </div> 
        {/if}      
    {/if}  
    
    </div>
    <div class="break"></div>
    <a href="#" class="more-link">Back to top&gt;&gt;</a><a href={$node.parent.url_alias|ezurl} class="more-link" >&lt;&lt;Back</a><a href={$node.parent.url_alias|ezurl} class="more-link-top" >&lt;&lt;Back</a>  
</div>
  {literal}
  <script>
      $(function() {
          $( ".products-tabs" ).tabs();
    });
   </script>
  {/literal}