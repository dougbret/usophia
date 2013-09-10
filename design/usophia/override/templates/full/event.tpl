{* Event - Full view *}

 <script src="http://code.jquery.com/jquery-1.7.min.js" type='text/javascript'> </script>
<div class="content-view-full">
    <div class="class-event">
    
    {if $node.data_map.title.has_content}
        <h1>{$node.data_map.title.content|wash()}</h1>
    {else}
        <h1>{$node.name|wash()}</h1>
    {/if}

    
    <div class="attribute-byline">
    <p>
    {*if $node.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {"Category"|i18n("design/ezwebin/full/event")}:
    {attribute_view_gui attribute=$node.object.data_map.category}
    </span>
    {/if*}

    {if $node.object.data_map.venue.has_content}
    <span class="ezagenda_keyword">
    {"Venue"|i18n("design/ezwebin/full/event")}:
    <a href={$node.data_map.venue.content.main_node.url_alias|ezurl}>{$node.data_map.venue.content.name|wash()}</a>
    </span>
    {/if}
    
    
    
  <!-- Formated DAte   -->
	
    <span class="ezagenda_date server" >
	
	{$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M ")} <span id='dddf{$node.object.data_map.from_time.content.timestamp}'> </span> 
	
	
 {literal}
<script type='text/javascript'>
	var date = new Date({/literal}{$node.object.data_map.from_time.content.timestamp}{literal} * 1000 );
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
	jQuery("#dddf{/literal}{$node.object.data_map.from_time.content.timestamp}{literal}").html( hours + ":" + minutes);
	 </script> 
{/literal}
	
	
	
	
	
    {if $node.object.data_map.to_time.has_content}
		
          - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M")}
		  	  <span id='to_Date{$node.object.data_map.to_time.content.timestamp}'>  </span> 
		   {literal}
<script type='text/javascript'>
	var date = new Date({/literal}{$node.object.data_map.to_time.content.timestamp}{literal} * 1000 );
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
	jQuery("#to_Date{/literal}{$node.object.data_map.to_time.content.timestamp}{literal}").html( hours + ":" + minutes);
	 </script> 
{/literal}
		  
		  
    {/if}
	
	
	
    </span>
	
	
	
    </p>
    </div>

    {if $node.object.data_map.image.content}
         <div class="attribute-image">
             {attribute_view_gui attribute=$node.object.data_map.image image_class=medium}
        </div>
    {/if}

    {if $node.object.data_map.text.has_content}
        <div class="attribute-short">{attribute_view_gui attribute=$node.object.data_map.text}</div>
    {/if}
    {if $node.data_map.related_product.has_content}
      {def $object = false()
         $button_class = 'show-more'
         $url = ''
      }
      {set $object = fetch( content, object, hash( object_id, $node.data_map.related_product.content.relation_list.0.contentobject_id ))} 
      {set $url = $object.main_node.url|ezurl}
      
      {if eq($object.main_node.class_identifier,'item')}
            {* if streaming*}
      {if eq($object.main_node.data_map.type.content.0 ,0)}
        {if or(eq($object.main_node.data_map.item_status.content.0 ,0), eq($object.main_node.data_map.item_status.content.0 ,3))}
          {set $button_class = 'show-more'} 
        {else}
          {set $button_class = 'watch-it-button'} 
        {/if}
      {else} {* If interactive*}
        {if or(eq($object.main_node.data_map.item_status.content.0 ,0), eq($object.main_node.data_map.item_status.content.0 ,3))}
          {set $button_class = 'show-more'} 
        {else}
          {if eq($object.main_node.data_map.item_status.content.0 ,1)}  
            {set $button_class = 'join-button'}
            {if or($object.main_node.data_map.interactive_event_url.content|contains('http'),$object.main_node.data_map.interactive_event_url.content|contains('https'))}
              {set $url = concat('"',$object.main_node.data_map.interactive_event_url.content, '"')} 
            {else}
              {set $url = concat('"http://',$object.main_node.data_map.interactive_event_url.content, '"')} 
            {/if} 
          {else}
            {set $button_class = 'watch-it-button'} 
          {/if} 
          
        {/if} 
      {/if} 
    {elseif eq($object.main_node.class_identifier,'item_series')}
      {set $button_class = 'see-all-button'}
    {elseif eq($object.main_node.class_identifier,'product_usophia')}
      {set $button_class = 'show-more'}
{*    {elseif eq($object.main_node.class_identifier,'repertoire')}
       {set $button_class = 'show-more'}
*}
    {/if}

    <a href={$url}> 

    <button class="{$button_class}" ></button> 

    </a>

    {/if}  

  </div>
</div>
