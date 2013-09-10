{* Line Art Center View *}
{default $watch_it=0
  $status=0 
  $type=0 
  $button_class='show-more'
  $url = $node.url_alias|ezurl
  $table=1
  $event = false()
  $user=fetch( 'user', 'current_user' )
  $object = false()
  $event_type = ''
  $meeting_url = ''
  $product_item = false()
  $series_url = ''
  $summary_required=0
  $hostname = ezini( 'SiteSettings', 'SiteURL', 'site.ini' )
}

<div class="content-view-line  line-{$node.class_identifier} border_bottom {if $watch_it}watch-it-line{/if}">


{if $node.data_map.show_art_center.data_int}  
  <div class="line-art-center"><a href={$node.parent.url_alias|ezurl} >{$node.parent.name}</a></div>
{/if}  
  <div class="line-image-floating">{attribute_view_gui image_class=art_center_thumb href=$node.url_alias|ezurl attribute=$node.data_map.image}</div>
  {if $node.data_map.short_title.has_content}
  <div class="line-title-floating"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.short_title.content|wash()}</a></div>
  {else}
  <div class="line-title-floating"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>
  {/if}
  {if $watch_it}  
    {if and($status, ne($node.class_identifier,'item_series'))}
      <div class="item-status">
        <span>Status: </span>{attribute_view_gui attribute=$node.data_map.item_status}
      </div>
    {/if}
    {if $type}
      <div class="item-status">
        <span>Type: </span>{attribute_view_gui attribute=$node.data_map.type}
      </div>
    {/if}
  {/if}
  
    {if eq($node.class_identifier,'item')}
      {* if streaming*}
      {if ne($node.data_map.type.content.0 ,1)}
        {if or(eq($node.data_map.item_status.content.0 ,0), eq($node.data_map.item_status.content.0 ,3))}
          {set $button_class = 'show-more'} 
        {else}
          {set $button_class = 'watch-it-button'} 
          {*if $node.data_map.item_status.content*}
        {/if}
      {else} {* If interactive*}
          {if eq($node.data_map.item_status.content.0 ,1)}  
            {set $button_class = 'join-button'}
            {if $user.is_logged_in}    
              {set $event = fetch( content, reverse_related_objects,
                       hash( 'object_id', $node.contentobject_id,
                             as_object, true(),
                             attribute_identifier, '758',

                       ) )}
       
              {set $object = fetch( content, object, hash( object_id, $event.0.id ))} 
              {if $object.main_node.data_map.meeting_id.has_content}
                 {if eq($object.main_node.data_map.meeting_type.content.0,0)}
                    {set $event_type = 'JM'}
                  {else}
                    {set $event_type = 'JE'}
                  {/if}
                  {set $meeting_url = $object.main_node.data_map.link.content|trim|explode('/')}
                  {set $url = concat($meeting_url[0],'//',$meeting_url[2],'/',$meeting_url[3],'/m.php?AT=',$event_type,'&MK=',$object.main_node.data_map.meeting_id.content|trim,'&AN=',$user.login,'&AE=',$user.email,'&FN=',$user.contentobject.data_map.first_name.content,'&LN=',$user.contentobject.data_map.last_name.content,'&BU=http://', $hostname, '/', $node.url_alias|ezurl)}
              {/if}
              {if $object.main_node.data_map.related_product.has_content}
                  {set $product_item = fetch( content, object, hash( object_id, $object.main_node.data_map.related_product.content.relation_list.0.contentobject_id ))}  
              {/if} 
            {else} {* user is not logged in *}
               {set $product_item = fetch( content, object, hash( object_id, $object.main_node.data_map.related_product.content.relation_list.0.contentobject_id ))}  
               {if eq($product_item.data_map.type.content.0,0)}
                  {set $url = $product_item.main_node.url_alias|ezurl}
               {/if} 
            {/if} 
          {else} {* not current *}
            {set $button_class = 'show-more'}
          {/if} 
      {/if} 
    {elseif eq($node.class_identifier,'item_series')}
      {set $button_class = 'see-all-button'}
    {elseif eq($node.class_identifier,'product_usophia')}
      {set $button_class = 'show-more'}
{*    {elseif eq($node.class_identifier,'repertoire')}
       {set $button_class = 'show-more'}
*}
    {/if}
  {if $watch_it}  
   <a href={$url}> 

    <button class="{$button_class}" ></button> 
    </a>
    {/if}
    {if $node.data_map.summary.content.is_empty|not}
       {if and(ne($node.class_identifier,'item_series'),ne($node.class_identifier,'item'))}
          <div class="line-content-summary"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.summary.content|strip_tags|shorten(100)}<span class="more-link-text">More&nbsp;&gt;&gt;</span></a></div>
       {/if}
       {if and(eq($node.class_identifier,'item'), eq($status,0), eq($type, 0))}
            <div class="line-content-summary"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.summary.content|strip_tags|shorten(100)}<span class="more-link-text">More&nbsp;&gt;&gt;</span></a></div>
       {/if}
    {/if}  


</div>
