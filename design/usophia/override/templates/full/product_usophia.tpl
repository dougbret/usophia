{* Usophia Product - Full view *}

{def $streaming_products = array()                                  
   $article_art_center = array()
  $object =false()  
  $product = array()
    $block_titles = ezini( 'ArtCenterTitles', 'BlockTitles', 'usophia.ini' )                                                      
}

{foreach $node.data_map.products_to_consider.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $product = $product|append($object.main_node)}  
{/foreach}

{foreach $node.data_map.news_and_noteworthy.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $article_art_center = $article_art_center|append($object.main_node)}  
{/foreach}

<div class="content-view-full" id="usophia-product">
  <div id="usophia-product-content"> 
    <h1>{$node.name|wash()}</h1>
    <span class="usophia-product-image">{attribute_view_gui attribute=$node.data_map.image image_class=medium}</span>
    {attribute_view_gui attribute=$node.data_map.summary}
    {attribute_view_gui attribute=$node.data_map.body}
    <div id="amazon-embeded">
    {$node.data_map.amazon.data_text}
    </div>
  </div>
  <div class="product-usophia-columns">
      <div class="art-center-left-column" >
        <div class="block1 want-consider want-to-consider">
          <div class="header">
            <h2>You might also want to consider...</h2>
          </div>
          <div class="content" >
            {foreach $product as $item}
              {node_view_gui content_node=$item view=line_art_center}
            {/foreach}
          </div>
          <div class="ac-see-all"><a href="{$node.url_alias|ezurl(no)}/(product_filter)/article">See all &gt;&gt;</a></div>
        </div>
      </div> 
       <div class="art-center-right-column">
       <div class="block1 products-tabs new-noteworthy-sp">
        <div class="header">
          <div class="tabs">
            <ul class="event-tabs-media">
              <li class="ui-tabs-selected ui-state-active"><a  href="#media-tab">{$block_titles['article']}</a></li>
              <li><a href="#onthenet-tab">Comments/Reviews</a></li>
            </ul>
          </div>
        </div>
        <div class="content">
          <div id="media-tab">
            {foreach $article_art_center as $item}
              {node_view_gui content_node=$item view=line_art_center}
            {/foreach}
            <div class="ac-see-all"><a href="#">See all &gt;&gt;</a></div>
          </div>
          <div id="onthenet-tab">
            {foreach $onthenet as $item}
              {node_view_gui content_node=$item view=line_art_center}
            {/foreach}
            
             <div class="add-comments"><a href="#">Add a comment &gt;&gt;</a></div>
          </div>
          
          
        </div>
      </div>
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