<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
      

{*{include uri='design:page_head_displaystyles.tpl'}*}
{def $extra_cache_key = getTimeZone()}
 <!--{$extra_cache_key}-->
{def $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $module_result.node_id
     $current_node     = fetch('content','node',hash('node_id', $current_node_id))
     $sidemenu=true()
     $extrainfo=true()
}

{if or( $module_result.uri|eq('/content/search'),  and( $module_result.uri|contains('/(show)/all'), not( $module_result.uri|contains('/Life-On-U-Sophia/(show)/all') ) ), $module_result.uri|contains('/(show)/sessions'),$module_result.uri|eq('/Library-at-U-Sophia/(show)/search'), $module_result.uri|contains('/(show)/read'),$module_result.uri|contains('/(show)/listen'),$module_result.uri|contains('/(show)/view'),$module_result.uri|eq('/Salon-Online/(show)/all'), $current_node.parent.node_id|eq(188), $current_node.node_id|eq(413)  )}
  {set $sidemenu=false()}
{/if}                           
{if or( not($current_node_id),  $module_result.uri|contains('About-Us'), $current_node.parent.class_identifier|eq('market'), $module_result.uri|contains('Life-On-U-Sophia/(contributor)'), and( $module_result.uri|contains('/(show)/all'), not( $module_result.uri|contains('/Life-On-U-Sophia/(show)/all') ) ), $module_result.uri|contains('/(show)/sessions'), $module_result.content_info.class_identifier|eq('venue'), $module_result.content_info.class_identifier|eq('guest'), $module_result.uri|eq('/Events'), $module_result.uri|eq('/Salon-Online/(show)/all'), $module_result.uri|eq('/News-Noteworthy'), $module_result.uri|eq('/U-sophia-suggests'), $module_result.uri|eq('/Library-at-U-Sophia/(show)/search'), $module_result.uri|contains('/(show)/read'),$module_result.uri|contains('/(show)/listen'),$module_result.uri|eq('/Library-at-U-Sophia/(show)/view'),$current_node.parent.node_id|eq(188), $current_node.node_id|eq(413)  )}
  {set $extrainfo=false()}      
{/if}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}


</head>
<body>
<!-- Complete page area: START -->
{/cache-block}
<div id="page" class="{if $sidemenu}sidemenu{else}nosidemenu{/if} {if $extrainfo}extrainfo{else}noextrainfo{/if}">
{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}

  {if and( is_set( $pagedata.persistent_variable.extra_template_list ), 
             $pagedata.persistent_variable.extra_template_list|count() )}
    {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
      {include uri=concat('design:extra/', $extra_template)}
    {/foreach}
  {/if}

 


 <!-- Header area: START -->
  {include uri='design:page_header.tpl'}
  <!-- Header area: END -->
  <!-- Top menu area: START -->
  {switch match=$module_result.path[1].node_id}  
    {case match=64}
      {include uri='design:page_topmenu_wikisophia.tpl'}
    {/case}
    {case}
      {include uri='design:page_topmenu.tpl'}    
    {/case}                         
  {/switch}

  <!--  Banners Counter-->
 
  
  <!-- BAnner Server -->
  {if eq($current_node.node_id, 2)}
  	{include uri='design:banner_home.tpl'}
  {else}
  	{include uri='design:banner_art_center.tpl'}
  {/if}  
  <!--  Banner Logic Ends -->
 {cache-block expire=1 subtree_expiry="sdsadas"}
 
 
	<!--  Banner Area Start -->

	<!-- End Banner Server-->
 
  
 
{/cache-block}
 
 
  
  
  
  
  <div id="expanded_content" class="float-break"></div>
  <!-- Top menu area: END -->

  <!-- Path area: START -->
    {include uri='design:page_toppath.tpl'}
    <div class="break"></div>
  <!-- Path area: END -->
  
  <!-- Toolbar area: START -->
  {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
    {include uri='design:page_toolbar.tpl'}
  {/if}
  <!-- Toolbar area: END -->
  
  
  
 
  
  
  
  
  <!-- Columns area: START -->
  <div id="columns-position">
  <div id="columns" class="float-break {if $module_result.path[1].node_id|eq(663)}nobackground{/if}">
{/cache-block}
    <!-- Side menu area: START -->   


    <!-- Side menu area: START -->   
    {if $sidemenu}
       {include uri='design:page_leftmenu.tpl'}
    {/if}
    <!-- Side menu area: END -->




    <!-- Side menu area: END -->



    <!-- Main area: START -->
		
		     {include uri='design:page_mainarea.tpl'}

	
	
    <!-- Main area: END -->
    

 
	


 
{if $extrainfo}
      {include uri='design:page_right_column.tpl'}
{/if}
    <!-- Extra area: END -->
	
    <!-- Extra area: END -->


{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

  </div>
  </div>
  <!-- Columns area: END -->


  <!-- Footer area: START -->
  {include uri='design:page_footer.tpl'}
  <!-- Footer area: END -->
  

  <form method="post" action={"/content/action"|ezurl} id="NewWikiPageForm">
      <input type="hidden" name="ClassIdentifier" value="wiki_page" />
      <input type="hidden" name="NodeID" value="{$node.node_id}" />
      <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
      <input type="hidden" name="NewButton" value="Add new WikiSophia page" />
  </form>
  

</div>
<!-- Complete page area: END -->
<script type='text/javascript'>



</script> 

<!-- Footer script area: START -->
{include uri='design:page_footer_script.tpl'}
<!-- Footer script area: END -->
{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>