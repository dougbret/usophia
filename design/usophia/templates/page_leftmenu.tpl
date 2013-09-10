{def $product_item = false()
     $hostname = ezini( 'SiteSettings', 'SiteURL', 'site.ini' )  
   
} 

{let frontpage_node=fetch('content','node',hash('node_id',$module_result.path[1].node_id))}
    <div id="sidemenu-position">
      <div id="sidemenu">
        {switch match=$module_result.path[1].node_id}  

        {case match=600}
            <div class="attribute-header">
              <h1>Calendar of events</h1>
            </div>
             {let venue=fetch('content','node',hash('node_id',$module_result.node_id))
                  events=fetch( 'content', 'tree', hash( 'parent_node_id', 82, 'extended_attribute_filter',hash(
           'id', 'ObjectRelationFilter',
           'params', array(489, $venue.object.id
           )
        ),
'sort_by', array('attribute',true(),'event/from_time' ) ))} 
               <div class="eventlist salon"> 
                  <h2>{$venue.name|wash}</h2>
                  <ul> 				         
                      {def $already_showed = array()}
                      {foreach $events as $child}
                      	{if not($already_showed|contains($child.node_id))}
                          <li> 
                            <h2><a href={$child.url_alias|ezurl}>{$child.data_map.from_time.content.timestamp|datetime( 'custom', '%M %d' )}<span style="float:right">{$child.data_map.from_time.content.timestamp|datetime( 'custom', '%h:%i %A' )}</span></a></h2> 
                            <div style="overflow:hidden;max-height:50px" align="left">{$child.data_map.text.content.output.output_text|strip_tags|shorten(80)} </div> 
                            <div class="salonlinks">
                              <a href={$child.url_alias|ezurl}>Read More</a>
                            </div>              
                          </li>
                      	{set $already_showed = $already_showed|append($child.node_id)}
                        {/if}
                      {/foreach}     
                      {undef $already_showed}            
                 </ul>
                </div>
            {/let}
        {/case}




        {case match=74}
            {let about_node=fetch( 'content', 'node', hash( 'node_id', 74))}  
              <div class="attribute-header">
                <h1>{$about_node.name|wash}</h1>
              </div>                                                                                        
              <div class="eventlist server4"> 
                <ul> 				         
                  {foreach $about_node.children as $child}     
                    <li> 
                      <h2><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></h2> 
                      {*<div style="overflow:hidden;max-height:50px" align="left">{$child.data_map.description.content.output.output_text|strip_tags|shorten(100)} </div>*} 
                      <div style="text-align:right" class="eventlinks"><a href={$child.url_alias|ezurl}>View&gt;&gt;</a></div>              
                    </li>
                   {/foreach}             
               </ul>
              </div>
            {/let}

          {/case}


          {case}
          

            {*  If we are in some of the user related pages*}  

          {if or( eq($uri_string, 'user/edit'),  $uri_string|contains("shop/customerorderview"), eq($uri_string, 'content/pendinglist'),eq($uri_string, 'notification/settings'),eq($uri_string, 'shop/wishlist'),eq($uri_string, 'content/draft'))} 
            <div class="eventlist server4">
            
                <ul> 				         
                     
                    <li class="main-title-left"> 
                      <h2 class="left-title">My U-sophia</h2> 
                    </li> 
                    
                    
                     <li> 
                       <h2 class="left-subtitle"><a href="/user/edit">My Profile</a></h2>
          
                    </li> 
                      
                      <li>                                           
                          <h2 class="left-subtitle" >My U-sophia Shop</h2>
                        
                          <ul> 
                              {if fetch( 'user', 'has_access_to', hash( 'module', 'shop',
                                                                'function', 'administrate' ) )}
                              <li>
                                <a href={concat("/shop/customerorderview/", $userID, "/", $userAccount.email)|ezurl}>{"Orders"|i18n("design/ezwebin/user/edit")}</a>
                              </li>
                              {/if}
                              {if fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                          'function', 'pendinglist' ) )}
                              <li>                                           
                              <a href={"/content/pendinglist"|ezurl}>{"Pending items"|i18n("design/ezwebin/user/edit")}</a>
                              </li> 
                              {/if}
                              
                              {if fetch( 'user', 'has_access_to', hash( 'module', 'shop',
                                                                        'function', 'buy' ) )}
                              <li>                                           
                              <a href={"/shop/wishlist"|ezurl}>{"Wish list"|i18n("design/ezwebin/user/edit")}</a>
                              </li> 
                              {/if}
                              <li>                                           
                              <a href={"/shop/basket"|ezurl}>{"Cart"|i18n("design/ezwebin/user/edit")}</a>
                              </li>
                              
                          </ul>  

                      </li> 
                      
                      {if fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                'function', 'pendinglist' ) )}
                                                              
                      <li>  
                          <h2 class="left-subtitle">{"My Content"|i18n("design/ezwebin/user/edit")}</a></h2>
                          <ul>
                            <li>                                           
                              <a href={"/my-content"|ezurl}>{"Uploads"|i18n("design/ezwebin/user/edit")}</a>
                            </li> 
                            <li>                                           
                              <a href={"/my-comments"|ezurl}>{"Comments"|i18n("design/ezwebin/user/edit")}</a>
                            </li> 
                            
                            
                          </ul>   
                      </li> 
                      {/if}
                      
                      
                     
                      
                      <li>                                           
                         <h2 class="left-subtitle">{"Editorial Dashboard"|i18n("design/ezwebin/user/edit")}</h2>
                         
                         <ul>
                            <li><a href={"/my-content"|ezurl}>{"Content"|i18n("design/ezwebin/user/edit")}</a></li>
                            {if fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                  'function', 'edit' ) )}
                            <li>                             
                              <a href={"content/draft"|ezurl}>{"Drafts"|i18n("design/ezwebin/user/edit")}</a>
                            </li>   
                            {/if}
                            {if fetch( 'user', 'has_access_to', hash( 'module', 'notification',
                                                                      'function', 'use' ) )}
                            <li>                                           
                              <a href={"notification/settings"|ezurl}>{"Notification settings"|i18n("design/ezwebin/user/edit")}</a>
                            </li> 
                            {/if}
                               
                         </ul>
                         
                         
                         
                      </li> 
                      
                      
            </ul>           
          </div>
          {else}
          
              {* If we are in an art center put the tabs for showing the art center events and all events *}
              {def $in_art_center=or(eq($current_node.class_identifier, 'art_center'), eq($current_node.parent.class_identifier, 'art_center')) 
                  $art_centers = fetch(content,list,hash(parent_node_id,1869,class_filter_type,include,class_filter_array,array('art_center'),sort_by,array(priority,true())))
              }
              <select id="art-center-select">  
                <option value="">Select Art Center</option>  
              {foreach $art_centers as $art_center}
              <option value={$art_center.url_alias|ezurl}>{$art_center.name}</option>
              {/foreach}
              </select>    
              
              {if $in_art_center|not}
                <div class="attribute-header">
                  <h1>Events</h1>
                  <a href={"rss/feed/events"|ezurl}><img src={"images/rss.png"|ezdesign} alt="RSS feed for events" /></a>
                </div>
              {else}  
                {literal}
                  <script>
                      $(function() {
                          $( "#event-category-tabs-container" ).tabs();
                    });
                   </script>
                {/literal}
              {/if}  
                <div id="event-category-tabs-container">   
                  {if $in_art_center} 
                  <div class="tabs header">   
                    <ul class="event-tabs"> 
                      <li><a href="#event1" rel="event1" class="selected" id="art_center_tab">Art Center Events</a></li>
                      <li><a href="#event2" rel="event2" id="all-events-tab">All Events</a></li> 
                    </ul> 
                  </div> 
                  {def $art_center_events=fetch( 'content', 'tree', hash( 'parent_node_id', $module_result.path[2].node_id, 
                                                                        'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                        'main_node_only', true(),
                                                                        'attribute_filter', array( array( 'event/from_time',
                                                                                                      '>',
                                                                                                      sub( currentdate(),10800) ) )
                                                                                )) }
                  {/if}  
                  
                  {def $usophia_events=fetch( 'content', 'tree', hash( 'parent_node_id', 2, 
                                                                        'sort_by', array( 'attribute',true(),'event/from_time' ),
                                                                        'main_node_only', true(),
                                                                        'attribute_filter', array( array( 'event/from_time',
                                                                                                      '>',
                                                                                                      sub( currentdate(),10800) ) )
                                                                                )) 
                                                                                
                       $meeting_url = '' 
                        $event_type = ''  
                         $current_event = false()                                                       }    
                  
                   {if $in_art_center}           
                  <div id="event1"> 
                    {include uri="design:full/event_view_calendar.tpl" event_node_id=$module_result.path[2].node_id}
                    <div class="eventlist server5"> 
                      <ul> 				         
                        {foreach $art_center_events as $event} 
                          {set $current_event = false()}                    
                          <li> 
                            <h2><a href={$event.url_alias|ezurl}>
                  
                              {$event.data_map.from_time.content.timestamp|datetime( 'custom', '%M ' )}
                              <span id='custoss{$event.data_map.from_time.content.timestamp}-node-art-{$event.node_id}'> </span> 
                              <span style="float:right">
                              <span id='custostamp{$event.data_map.from_time.content.timestamp}-node-art-{$event.node_id}'> </span> 
                              <!-- Maybe set User javascrtipt function -->
                                <?php echo  date_default_timezone_get ( );?>
                                

                              {literal}
                       
                                <script type='text/javascript'>
                                  var date = new Date({/literal}{$event.data_map.from_time.content.timestamp}{literal} * 1000 );
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
                                    jQuery("#custostamp{/literal}{$event.data_map.from_time.content.timestamp}-node-art-{$event.node_id}{literal}").html(hours + ":" + minutes);
                                    jQuery("#custoss{/literal}{$event.data_map.from_time.content.timestamp}-node-art-{$event.node_id}{literal}").html(day);
                                  </script> 
                              {/literal}
                              </span></a></h2> 
                            <div style="overflow:hidden;max-height:50px" align="left"><a href={$event.url_alias|ezurl}>{$event.name|wash}</a> </div> 
               
                  
                  
                            <div style="text-align:right" class="eventlinks">

                            {if $event.data_map.related_product.has_content}
                              {set $product_item = fetch( content, object, hash( object_id, $event.data_map.related_product.content.relation_list.0.contentobject_id ))}
                              {if eq($product_item.data_map.item_status.content.0 ,1)}
                                 {set $current_event = true()}
                              {/if}
                            {/if}



            {*  Interactive meeting *}  

                              {if $event.data_map.meeting_id.has_content}
                                 {if $event.data_map.related_product.has_content}
					{if $current_event}
                                    <a href={$product_item.main_node.url_alias|ezurl}><span class="blinkarrow">Join Interactive Event &gt;&gt;</span></a> &nbsp;|&nbsp;    
                                    {else}
                                    <a href={$product_item.main_node.url_alias|ezurl}>Interactive Event &gt;&gt;</a> &nbsp;|&nbsp;    
                                    {/if}
                                 {/if}
            {*  Streaming *}  {elseif $event.data_map.related_product.has_content}
					{if $current_event}
                                      <a href={$product_item.main_node.url_alias|ezurl} target="_blank">{if eq($product_item.data_map.item_status.content.0 ,1)} <span class="blinkarrow">{/if}Join Live Streaming &gt;&gt;{if eq($product_item.data_map.item_status.content.0 ,1)} </span>{/if}</a> &nbsp; | &nbsp; 
                                   {else}
                                      <a href={$product_item.main_node.url_alias|ezurl} target="_blank">Live Streaming &gt;&gt;</a> &nbsp; | &nbsp; 
                                    {/if}
                              {/if}
            {*  More *}  
                              {if $event.data_map.related_product.has_content}
                                 <a href={$product_item.main_node.url_alias|ezurl}>More&gt;&gt;</a></div>
                              {else}
                                <a href={$event.url_alias|ezurl}>More&gt;&gt;</a></div>    
                              {/if}

                          </li>
                         {/foreach}             
                      </ul>
                      <a href="/Events/(art_center_node)/{$module_result.path[2].node_id}" class="all-events-link">All events</a>
                    </div>
                    
                    
                  </div> 
                   {/if} 
                    
                  <div id="event2"> 
                    {include uri="design:full/event_view_calendar.tpl"}
                    <div class="eventlist server5"> 
                      <ul> 				         
                        {foreach $usophia_events as $event}  
                          {set $current_event = false()}                     
                          <li> 
                            <h2><a href={$event.url_alias|ezurl}>
                  
                              {$event.data_map.from_time.content.timestamp|datetime( 'custom', '%M ' )}
                              <span id='custoss{$event.data_map.from_time.content.timestamp}-node-{$event.node_id}'> </span> 
                              <span style="float:right">
                              <span id='custostamp{$event.data_map.from_time.content.timestamp}-node-{$event.node_id}'> </span> 
                              <!-- Maybe set User javascrtipt function -->
                                <?php echo  date_default_timezone_get ( );?>
                                

                              {literal}
                       
                                <script type='text/javascript'>
                                  var date = new Date({/literal}{$event.data_map.from_time.content.timestamp}{literal} * 1000 );
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
                                    jQuery("#custostamp{/literal}{$event.data_map.from_time.content.timestamp}-node-{$event.node_id}{literal}").html(hours + ":" + minutes);
                                    jQuery("#custoss{/literal}{$event.data_map.from_time.content.timestamp}-node-{$event.node_id}{literal}").html(day);
                                  </script> 
                              {/literal}
                              </span></a></h2> 
                            <div style="overflow:hidden;max-height:50px" align="left"><a href={$event.url_alias|ezurl}>{$event.name|wash}</a> </div> 
               
                  
                  
                            <div style="text-align:right" class="eventlinks">
                            {if $event.data_map.related_product.has_content}
                              {set $product_item = fetch( content, object, hash( object_id, $event.data_map.related_product.content.relation_list.0.contentobject_id ))}
                              {if eq($product_item.data_map.item_status.content.0 ,1)}
                                 {set $current_event = true()}
                              {/if}
                            {/if}

            {*  Interactive meeting *}  

                              {if $event.data_map.meeting_id.has_content}
                                 {if $event.data_map.related_product.has_content}
					{if $current_event}
                                    <a href={$product_item.main_node.url_alias|ezurl}><span class="blinkarrow">Join Interactive Event &gt;&gt;</span></a> &nbsp;|&nbsp;    
                                    {else}
                                    <a href={$product_item.main_node.url_alias|ezurl}>Interactive Event &gt;&gt;</a> &nbsp;|&nbsp;    
                                    {/if}
                                 {/if}
            {*  Streaming *}  {elseif $event.data_map.related_product.has_content}
					{if $current_event}
                                      <a href={$product_item.main_node.url_alias|ezurl} target="_blank">{if eq($product_item.data_map.item_status.content.0 ,1)} <span class="blinkarrow">{/if}Join Live Streaming &gt;&gt;{if eq($product_item.data_map.item_status.content.0 ,1)} </span>{/if}</a> &nbsp; | &nbsp; 
                                   {else}
                                      <a href={$product_item.main_node.url_alias|ezurl} target="_blank">Live Streaming &gt;&gt;</a> &nbsp; | &nbsp; 
                                    {/if}
                              {/if}
            {*  More *}  
                              {if $event.data_map.related_product.has_content}
                                 <a href={$product_item.main_node.url_alias|ezurl}>More&gt;&gt;</a></div>
                              {else}
                                <a href={$event.url_alias|ezurl}>More&gt;&gt;</a></div>    
                              {/if}
                          </li>
                         {/foreach}             
                      </ul>
                      <a href={"Events"|ezurl} class="all-events-link">All events</a>
                    </div>
                    
                    
                    </div> 
                  </div>
              {/if}        
          {/case}
        {/switch}

       </div>
    </div>
{/let}