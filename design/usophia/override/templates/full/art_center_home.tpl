{* Art Center - Full view *}


{if is_set($view_parameters['product_filter'])}
  
<div class="content-view-full">
    <div class="class-folder">
       
            {def $page_limit = 10
                 $classes = array()
                 $children = array()
                 $children_count = ''
                 $class = false()
                 $list_titles = ezini( 'ArtCenterHomeTitles', 'ListTitles', 'usophia.ini' )
                 $attribute_filter = false()     
            }
            
            
            {if is_set($view_parameters['product_filter'])}
              {set $classes = $classes|merge( $view_parameters['product_filter']|explode(','))}
              {set $class = fetch( 'content', 'class', hash( 'class_id', $view_parameters['product_filter'] ) )}
            {/if}

            {if is_set($view_parameters['product_filter'])}
              {if is_set($list_titles[$view_parameters['product_filter']])}
                 {if eq($view_parameters['product_filter'],'item')} 
		         {if eq($view_parameters['item_type'], 1)}<h1>Interactive</h1>
                       {elseif eq($view_parameters['item_type'], 2)}<h1>Mediatheque</h1>
                       {elseif eq($view_parameters['item_type'], 0)}<h1>Streaming</h1>
                       {/if}                       
                 {else} 
                      <h1>{$list_titles[$view_parameters['product_filter']]}</h1>
                 {/if}
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
              {def $children = fetch( 'content',tree, hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array(priority, true()),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'attribute_filter', $attribute_filter,
                                                            'limit', $page_limit ) 
               )}

            <div class="content-view-children">
                {if $children|count}
                    {foreach $children as $child }
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

{else}

  {def $streaming_products = array()                                  
       $interactive_products = array()
       $also_available = array()                                                     
       $mediatheque_items = array() 
       $day_art_center = array() 
       $block_titles = ezini( 'ArtCenterHomeTitles', 'BlockTitles', 'usophia.ini' )  
       $best_seller=array()
       $about = fetch(content, list, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      limit, 1,
                                                      class_filter_array, array('about_art_center'),
                                                      sort_by, array('priority', true())      
                                                      ))
       $editor_corner = fetch(content, list, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      limit, 1,
                                                      class_filter_array, array('article_block'),    
                                                      ))                                               
                                                       
        
       $recommendations = array() 
                             
                                                      
       $object = false()  
      $art_centers = array()
      $object1 = false() 
       $contains_streaming = 0
       $contains_interactive = 0
       
  }
  
  {foreach $node.data_map.art_centers.content.relation_list as $item}
    {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))}  
    {set $art_centers = $art_centers|append($object.main_node)}  
  {/foreach}
  
  
  {foreach $node.data_map.art_center_of_the_day.content.relation_list as $day_art_centers}
    {set $object = fetch( content, object, hash( object_id, $day_art_centers.contentobject_id ))}  
    {set $day_art_center = $day_art_center|append($object.main_node)}  
  {/foreach}
  {foreach $node.data_map.best_sellers.content.relation_list as $best_sellers}
    {set $object = fetch( content, object, hash( object_id, $best_sellers.contentobject_id ))}  
    {set $best_seller = $best_seller|append($object.main_node)}  
  {/foreach}
  {foreach $node.data_map.recommendation.content.relation_list as $recommendation}
    {set $object = fetch( content, object, hash( object_id, $recommendation.contentobject_id ))}  
    {set $recommendations = $recommendations|append($object.main_node)}  
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

        {literal}
          <script type="text/javascript"> 
          jQuery(document).ready(function() {
            if(getParam( "ST" ) == "FAIL") {
              $.fancybox(
                '<h2>Interactive meeting session error: ' +  getParam( "RS" ) + '</h2><p>An error has occured while you were trying to join the interactive session. Please contact our provider\'s customer care at one of the following toll free numbers:<p>(Available 24 hours a day, 7 days a week for current customers only.) <br>Contact: <a href="https://support.webex.com/support/manage-ticket.html">https://support.webex.com/support/manage-ticket.html</a></p><ul><li>Phone:        Austria - 0800 102 51999</li><li>Belgium - 0800 50 595</li><li>France - 0800 945 177</li><li>Germany - 0800 101 2071</li><li>Ireland - 1800 94 4647</li><li>Italy - 0800 124 721</li><li>Netherlands - 0800 265 9116</li> <li>Portugal - 800 781 059</li><li>Spain - 900 801 384</li><li>Sweden - 0200 125 320</li><li>Switzerland - 0800 000 889</li><li>United Kingdom - 0800 389 9772</li></ul><p>International Toll +1-408-435-7088</p><p>For additional support numbers, please refer to: http://www.webex.com/support/phonenumbers.htmadministrator</p><img src="/extension/usophia/design/usophia/images/usophia-logo-message.png" alt="" >',
                {
                        'autoDimensions'	: false,
                  'width'         		: 650,
                  'height'        		: 700,
                  'transitionIn'		: 'none',
                  'transitionOut'		: 'none'
                }
              );
            }  
          });
          
          function getParam( name )
{
           name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
           var regexS = "[\\?&]"+name+"=([^&#]*)";
           var regex = new RegExp( regexS );
           var results = regex.exec( window.location.href );
           if( results == null )
            return "";
          else
           return results[1];
          }
          </script>
        {/literal}  
 
    <div class="content-view-full">
          <div class="art-center-left-column ">
            <div class="block1 products-tabs">
              <div class="header">
                <div class="tabs">
                  <ul class="event-tabs">
                    <li ><a class="selected" href="#streaming-tab">Streaming</a></li>
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
            <div class="block1 art-center-list">
              <div class="header">
                <h2>Hosted Art-Centers</h2>
              </div>
              <div class="content">
                {foreach $art_centers as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
               <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/art_center">See all &gt;&gt;</a></div>
            </div>
          
          </div>
          <div class="art-center-right-column">
            <div class="block1 ">
              <div class="header">
                <h2>{$block_titles['about_project']}</h2>
              </div>
              <div class="content">
                {foreach $about as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              
            </div>
            <div class="block1 about-art-center-line">
              <div class="header">
                <h2>{$editor_corner.0.name}</h2>
              </div>
              <div class="content">
                {set $object = fetch( content, object, hash( object_id, $editor_corner.0.data_map.article_relation.content.relation_list.0.contentobject_id))}       
                    <div class="line-image">
                      {section show=$object.main_node.data_map.image.has_content}
                          {attribute_view_gui image_class=articlethumbnail href=$object.main_node.url_alias|ezurl attribute=$object.main_node.data_map.image}
                      {/section}            
                    </div>

                    <div class="line-content">
                     
                      
                      {if $object.main_node.data_map.intro.content.is_empty|not}
                        <div class="attribute-short">
                            {$object.main_node.data_map.intro.content.output.output_text|strip_tags|shorten(200)}
                        </div>                                     
                      {else}
                        <div class="attribute-short">
                            {$object.main_node.data_map.body.content.output.output_text|strip_tags|shorten(200)}
                        </div>                                     
                      {/if}
                            
                     
                    </div>
                    

                    
              </div>
              
              <div class="ac-see-all"><a href={$object.main_node.url_alias|ezurl}>More &gt;&gt;</a></div>
            </div>  
            
            
            
            <div class="block1 fifty-width left-block best-seller-home">
              <div class="header">
                <h2>{$block_titles['best_sellers']}</h2>
              </div>
              <div class="content">
                {foreach $best_seller as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/looking_for">See all &gt;&gt;</a></div>
            </div>
            <div class="block1 fifty-width recommendation-home">
              <div class="header">
                <h2>{$block_titles['recommendation']}</h2>
              </div>
              <div class="content">
                {foreach $recommendations as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/recommendation">See all &gt;&gt;</a></div>
            </div>
            
             <div class="block1 left-block open-your-art-center">
              <div class="header">
                <h2>{$block_titles['open_art_center']}</h2>
              </div>
              <div class="content">
                  {$node.data_map.art_center_creation_text.data_text|strip_tags|shorten(160)}
              </div>
               {*<div class="ac-see-all"><a class="button-usophia" href="#">Click to apply</a></div>
            </div>
           
            
            
            
            {*<div class="block1 fifty-width">
              <div class="header">
                <h2>{$block_titles['apply']}</h2>
              </div>
              <div class="content">
                  {$node.data_map.apply_text.data_text|strip_tags|shorten(160)}
              </div>
              <div class="ac-see-all"><a class="button-usophia" href="#">Click to apply</a></div>
            </div>*}
            
          
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