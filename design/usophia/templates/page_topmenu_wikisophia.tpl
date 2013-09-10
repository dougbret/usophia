  <div id="topmenu-position">
  <div id="topmenu" class="float-break">
            <ul class="menu-list">
              <li class="menu-node-2"><a href={"/"|ezurl} class="menu-item-link {if $current_node_id|eq(2)}current{/if}">Homepage</a>
              <li class="menu-node-413"><a href={"/Wikisophia"|ezurl} class="menu-item-link {if $current_node_id|eq(413)}current{/if}">Wikisophia</a>
                   {def $homepage_items = fetch( 'content', 'list', hash( 'parent_node_id', 2,
                                                                      'sort_by', $root_node.sort_array,
                                                                      'data_map_load', false(),
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', array('frontpage', 'art_center_home_page')
                                                                      ))}
                  <ul class="submenu-list">
                    {foreach $homepage_items as $key => $item}
                            <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$item.name|wash()}</a>
                    {/foreach}
                  </ul>
              </li>

              <li><a href={$item.url_alias|ezurl}>Term posted</a>
{*                  <ul class="submenu-list">
                          <li><a href={$subitem.url_alias|ezurl}>Usage</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>Famous quotes</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>Antonymous</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>Thesaurus</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>PDF</a></li>
                  </ul>
*}
              </li>
              <li><a href={$item.url_alias|ezurl}>Sources</a></li>
              <li><a href="#" id="NewWikiPage">New Section</a>
{*                  <ul class="submenu-list">
                          <li><a href={$subitem.url_alias|ezurl}>More definitions</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>Usage</a></li>
                          <li><a href={$subitem.url_alias|ezurl}>Famous quotes</a></li>
                  </ul>
*}
              </li>
              <li><a href={concat("/content/edit/", $module_result.content_info.object_id, "/")|ezurl}>Edit</a></li>
              <li><a href={concat("/content/history/", $module_result.content_info.object_id, "/")|ezurl}>History</a></li>
              <li><a href={$item.url_alias|ezurl}>Sources</a>
                  <ul class="submenu-list">
                          <li>This section is reviewed by editors before publishing</li>
                  </ul>              
              </li>
  

                </li>
            </ul>
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