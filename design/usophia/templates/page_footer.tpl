

{literal}

	<script type="text/javascript">
		jQuery(document).ready(function(){
			// HHH 
			jQuery("#hovervideo").click(function(){
			jQuery("#hovervideo").hide(); 
			jQuery("#playeshow").show(); 
				
				
				
				
				
			
			});
			
			
 
		 jQuery(".submenu-list").css("padding-left", (jQuery("#page").offset().left-20) + "px "); 
 
		});
			
	</script> 
{/literal}


  <!-- Footer area: START -->
  <div id="footer">
  <div id='wwe'> </div> 
    {let footer_articles=fetch( 'content', 'list', hash( 'parent_node_id', 209,
                                                                'sort_by', $root_node.sort_array
                                                                ))}
      {foreach $footer_articles as $child}
        {if eq( $child.class_identifier, 'link')}
          <a href={$child.data_map.location.content|ezurl}>{$child.name|wash}</a>
        {else}
          <a href={$child.url_alias|ezurl}>{$child.name|wash}</a>
        {/if}
        {delimiter} | {/delimiter}
      {/foreach}                                                                
    {/let} 
    &copy; U-Sophia 2010                                                              
    {*{if $pagedesign.data_map.footer_text.has_content}
        {$pagedesign.data_map.footer_text.content} 
    {/if}*}
  </div>
  <!-- Footer area: END -->
 {*<script src="http://cdn.wibiya.com/Toolbars/dir_1086/Toolbar_1086394/Loader_1086394.js" type="text/javascript"></script><noscript><a href="http://www.wibiya.com/">Web Toolbar by Wibiya</a></noscript> *}