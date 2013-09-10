{* Art Center - Full view *}

{if is_set($view_parameters['product_filter'])}
  
<div class="content-view-full">
    <div class="class-folder">
       

    
           {def $page_limit = 10
                 $classes = array()
                 $children = array()
                 $children_count = ''
                 $class = false()
                 $list_titles = ezini( 'ArtCenterTitles', 'ListTitles', 'usophia.ini' ) 
                 $art_center_classes = array('streaming_product', 'vod', 'article', 'pod','product_usophia','comprehensive_event','work_in_progress','about_art_center','looking_for','media_art_center','on_the_net', 'recomendation')                  
            }
            
            
            {if is_set($view_parameters['product_filter'])}
              {set $classes = $classes|merge( $view_parameters['product_filter']|explode(','))}
              {set $class = fetch( 'content', 'class', hash( 'class_id', $view_parameters['product_filter'] ) )}
            
            {/if}
            {if is_set($view_parameters['product_filter'])}
              {if is_set($list_titles[$view_parameters['product_filter']])}
                <h1>{$list_titles[$view_parameters['product_filter']]}</h1>
              {else}
                <h1>{$class.name}</h1>
              {/if}
            {else}  
               <h1>{$class.name}</h1>
            {/if}
            <div class="art-center-back"><a href={$node.url_alias|ezurl}>Back to {$node.name}</a></div> 
            
            {if is_set($view_parameters['product_filter'])}
               {if eq($view_parameters['product_filter'], 'most_viewed')}
                  {set $children  = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                    'offset', $view_parameters.offset,
                                                    class_filter_type, include,
                                                    'limit', $page_limit,
                                                    class_filter_array, $art_center_classes,
                                                    sort_by, array('published', false())      
                                                    ))}
               {elseif eq($view_parameters['product_filter'], 'most_recent')}
                 {set $children  = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                    'offset', $view_parameters.offset,
                                                    class_filter_type, include,
                                                    'limit', $page_limit,
                                                    class_filter_array, $art_center_classes,
                                                    sort_by, array('published', false())      
                                                    ))}
               {else}
                 
                  {set $children  = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', $node.sort_array,
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) )}                                    
               {/if}
            {else}
              {set $children  = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', $node.sort_array,
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) )}

            {/if}
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
       $vod_products = array()
       $usophia_products = array()                                                     
       $comprehensive_events = array() 
       $block_titles = ezini( 'ArtCenterTitles', 'BlockTitles', 'usophia.ini' ) 
       $new_noteworthy = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('article'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))
            
        
       $recommendation = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('recommendation'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      )) 
       $workinprogress = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('work_in_progress'),
                                                      limit, 2,
                                                      sort_by, array('priority', true())      
                                                      ))
      $art_centers = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                      class_filter_type, include,
                                                      class_filter_array, array('art_center'),
                                                      limit, 6,
                                                      sort_by, array('priority', true())      
                                                      ))                                                     
                                                      
       $object = false()                                               
  }

  {foreach $node.data_map.products.content.relation_list as $product}
    {set $object = fetch( content, object, hash( object_id, $product.contentobject_id ))}  
    {switch match=$object.class_identifier}

      {case match='streaming_product'} 
        {set $streaming_products = $streaming_products|append($object.main_node)} 
      {/case}
      {case match='streaming_series'} 
        {set $streaming_products = $streaming_products|append($object.main_node)} 
      {/case}
      {case match='vod'} 
        {set $vod_products = $vod_products|append($object.main_node)} 
      {/case}
      {case match='on_demand_series'} 
        {set $vod_products = $vod_products|append($object.main_node)} 
      {/case}
      {case match='product_usophia'} 
        {set $usophia_products = $usophia_products|append($object.main_node)} 
      {/case}
      {case match='comprehensive_event'} 
        {set $comprehensive_events = $comprehensive_events|append($object.main_node)} 
      {/case}
      
      {case match='iteractive_event'} 
        {set $comprehensive_events = $comprehensive_events|append($object.main_node)} 
      {/case}
      {case match='iteractive_series'} 
        {set $comprehensive_events = $comprehensive_events|append($object.main_node)} 
      {/case}

      {/switch}
    
  {/foreach}
      <div class="content-view-full">
          <div class="art-center-right-column ">
            <div class="block1 art-center-list">
              <div class="header">
                <h2>Art-Centers</h2>
              </div>
              <div class="content">
                {foreach $art_centers as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
               <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/art_center">See all &gt;&gt;</a></div>
            </div>
            
            <div class="block1 fifty-width left-block ">
              <div class="header">
                <h2>Most Recent</h2>
              </div>
              <div class="content">
                {foreach $recommendation as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/most_recent">See all &gt;&gt;</a></div>
            </div>  
            <div class="block1 fifty-width">
              <div class="header">
                <h2>Most Viewed</h2>
              </div>
              <div class="content">
                {foreach $workinprogress as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
              </div>
              <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/most_viewed">See all &gt;&gt;</a></div>
            </div>
            
          </div>
          <div class="art-center-left-column">
            <div class="block1 products-tabs art-centers-product-tabs">
              <div class="header">
                <div class="tabs">
                  <ul class="event-tabs">
                    <li ><a class="selected" href="#streaming-tab">{$block_titles['streaming_product']}</a></li>
                    <li><a href="#vod-tab">{$block_titles['vod']}</a></li>
                    <li><a href="#usophia-product-tab">{$block_titles['product_usophia']}</a></li>
                    <li class="last"><a href="#event-tab">{$block_titles['comprehensive_event']}</a></li>
                  </ul>
                </div>
              </div>
              <div class="content">
                <div id="streaming-tab">
                {foreach $streaming_products as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
                  <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/streaming_product,streaming_series">See all {$block_titles['streaming_product']} &gt;&gt;</a></div>
                </div>
                <div id="vod-tab">
                {foreach $vod_products as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/vod,on_demand_series">See all {$block_titles['vod']} &gt;&gt;</a></div>
                </div>
                <div id="usophia-product-tab">
                {foreach $usophia_products as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/product_usophia">See all {$block_titles['product_usophia']} &gt;&gt;</a></div>
                </div>
                <div id="event-tab">
                {foreach $comprehensive_events as $item}
                  {node_view_gui content_node=$item view=line_art_center}
                {/foreach}
                <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/interactive_event,interactive_series">See all {$block_titles['comprehensive_event']} &gt;&gt;</a></div>
                </div>
                
              </div>
            </div>
            <div class="block1 left-block open-artcenter">
              <div class="header">
                <h2>Open your Art Center</h2>
              </div>
              <div class="content">
                {attribute_view_gui attribute=$node.data_map.art_center_creation_text}
              </div>
              <div class="ac-see-all"><a class="button-usophia" href="#">Click to apply</a></div>
            </div>
           
          
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