<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
<head>
{def
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
}
{def $extra_cache_key = getTimeZone()}
 <!--{$extra_cache_key}-->
{def $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id
     $current_node     = fetch('content','node',hash('node_id', $current_node_id))
     $sidemenu=true()
     $extrainfo=true()}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>
<!-- Complete page area: START -->
{/cache-block}
<div id="page" class="art-center art-centers node-{$current_node.node_id} node-type-{$current_node.class_identifier}">
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
    {include uri='design:page_topmenu.tpl'}                          

  <!--  Banners Counter-->
 
  
    <!-- BAnner Server -->
  	  {include uri='design:banner_art_center.tpl'}
<!--  Banner Logic Ends -->
 

  
  <div id="expanded_content" class="float-break"></div>
  <!-- Top menu area: END -->
  <!-- Path area: START -->
    {include uri='design:page_toppath_art_center.tpl'}
    <div class="break"></div>
  <!-- Path area: END -->
  <!-- Toolbar area: START -->
  {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
    {include uri='design:page_toolbar.tpl'}
  {/if}
  <!-- Toolbar area: END -->
<div id="artcentercatsearch">
  <form action={"/content/search"|ezurl}>
          
          <span class="search-label">Search in</span><input id="searchtext" name="SearchText" type="text" value="" size="12" />
          <input id="searchbutton" class="button-disabled" type="submit" value="" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" />
    </form>
</div>     
  
  <!-- Columns area: START -->
 
  <div id="columns-position">
    <div id="columns" class="float-break">
{/cache-block}
<!-- Side menu area: START -->   
{include uri='design:page_leftmenu.tpl'}
<!-- Side menu area: END -->
<!-- Main area: START -->	  
{include uri='design:page_mainarea_art_center.tpl'}	
<!-- Main area: END -->


{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}
    
    {include uri='design:social_links.tpl'}
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

  
  {literal}
<script type="text/javascript">
  var _gaq = _gaq || [];

  _gaq.push(['_setAccount', 'UA-8042375-2']);

  _gaq.push(['_trackPageview']);
  (function() {

    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;

    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';

    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);

  })();
 
</script>
{/literal}
{* This comment will be replaced with actual debug report (if debug is on). *}
  <!--DEBUG_REPORT-->
</body>
</html>