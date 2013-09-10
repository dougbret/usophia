 <div id="topmenu-position">
  <div id="topmenu" class="float-break">
  
    {def $menu_depth = 0}
   
        {def $root_node=fetch( 'content', 'node', hash( 'node_id', 2 ) )
             $menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                                'sort_by', $root_node.sort_array,
                                                                'data_map_load', false(),
                                                                'class_filter_type', 'include',
                                                                'class_filter_array', array('frontpage', 'art_center_home_page')
                                                                ))
             $menu_items_count = $menu_items|count()
             $li_class = array()
             $a_class = array()
             $current_node_in_path_2 = first_set( $pagedata.path_array[$menu_depth|inc].node_id,  0 )
             $current_node_in_path_3 = first_set( $pagedata.path_array[$menu_depth|sum(2)].node_id,  0 )}
    
        {if $menu_items_count}
            <ul class="menu-list">
              <li class="menu-node-2"><a href={"/"|ezurl} class="menu-item-link {if $current_node_id|eq(2)}current{/if}">Homepage</a></li>
            {foreach $menu_items as $key => $item}
{*                      {if eq( $item.node_id, 663)}
{else}*}

                {set $a_class = cond($current_node_in_path_2|eq($item.node_id), array("selected"), array())
                     $li_class = cond( $key|eq(0), array("firstli"), array() )}
    
                {if $menu_items_count|eq( $key|inc )}
                    {set $li_class = $li_class|append("lastli")}
                {/if}
                {if $item.node_id|eq( $current_node_id )}
                    {set $a_class = $a_class|append("current")}
                {/if}
                {set $li_class = $li_class|append(concat( "menu-node-",$item.node_id)  )}
                {if eq( $item.class_identifier, 'link')}
                    <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$item.data_map.location.data_text|wash}" class="menu-item-link" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a>
                {else}
                    <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$item.name|wash()}</a>
                {/if}
  
                  {def $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                        'sort_by', $item.sort_array,
                                                                        'data_map_load', false(),
                                                                        'class_filter_type', 'include',
                                                                        'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' ) ) )
                       $sub_menu_items_count = $sub_menu_items|count}
                  {if $sub_menu_items_count}
                  <ul class="submenu-list">
                      {foreach $sub_menu_items as $subkey => $subitem}
                         {set $a_class = cond($current_node_in_path_3|eq($subitem.node_id), array("selected"), array())
                           $li_class = cond( $subkey|eq(0), array("firstli"), array() )}
                      {if $sub_menu_items_count|eq( $subkey|inc )}
                          {set $li_class = $li_class|append("lastli")}
                      {/if}
                      {if $subitem.node_id|eq( $current_node_id )}
                          {set $a_class = $a_class|append("current")}
                      {/if}

                      {if eq( $subitem.class_identifier, 'link')}
                          <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></li>
                      {else}
                        
							   {if eq($subitem.node_id,1308)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">{$subitem.name|wash()}</a></li>
						  {/if}
						  
						  	   {if eq($subitem.node_id,1321)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">{$subitem.name|wash()}</a></li>
						  {/if}
						  
						  	   {if eq($subitem.node_id,1322)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">{$subitem.name|wash()}</a></li>
						  {/if}
						  
						  	   {if eq($subitem.node_id,496)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">All {$subitem.name|wash()}</a></li>
						  {/if}
						  
						  	   {if eq($subitem.node_id,585)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">{$subitem.name|wash()}</a></li>
						  {/if}
						  
						  	   {if eq($subitem.node_id,1324)}
					         <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}  ss{$subitem.node_id}"{/if}  class="ss{$subitem.node_id}">{$subitem.name|wash()}</a></li>
						  {/if}
						
						
						
						
						
						
                      {/if}

                      {/foreach}
                  </ul>
                  {/if}
                  
                  
                  
                {undef $sub_menu_items $sub_menu_items_count}

                </li>
{*{/if}*}
            {/foreach}
            </ul>
          {/if}
        {undef $root_node $menu_items $menu_items_count $a_class $li_class $current_node_in_path_2 $current_node_in_path_3}
    
    {undef $menu_depth}

  </div>
  </div>
    
  {literal}
	<script type='text/javascript'>
	jQuery(document).ready(function(){
		jQuery("li a.selected ").parent().find(" .submenu-list").show(); 
 		jQuery("#expanded_content").css("height","20px"); 
		jQuery("#path").css("margin-top","46px"); 
	
	
	}); 
	
	</script>   
  {/literal}
  
  
