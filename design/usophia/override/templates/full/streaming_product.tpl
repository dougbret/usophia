{* Streaming - Full view *}

{def $streaming_products = array()                                  
   $vod_products = array()
   $block_titles = ezini( 'ArtCenterTitles', 'BlockTitles', 'usophia.ini' )  
   $article_art_center = array()
  $stream_type = $node.data_map.player_type.content.0   
  $object =false()  
  $product = array()
}


{foreach $node.data_map.products_to_consider.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $product = $product|append($object.main_node)}  
{/foreach}

{foreach $node.data_map.news_and_noteworthy.content.relation_list as $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
  {set $article_art_center = $article_art_center|append($object.main_node)}  
{/foreach}
<div class="content-view-full" id="player-product">
    <div class="art-center-left-column" >
      <div class="block1 ">
        <div class="header">
          <h2>Auditorium - {if or(eq($stream_type,'2'), eq($stream_type,'3'))}Audio{else}Video{/if}</h2>
        </div>
        
        <div class="content-player">
          <div id="player"></div> 
          
          
          {literal}
          <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
          <script type="text/javascript">
            var player_id = 'player';
            var player_width = 400;
            var player_height = 225;
            var player_stream = 'my_stream';
            var player_streams = [{id: 'my_stream',{/literal}{if or(eq($stream_type,'2'), eq($stream_type,'3'))}radio: true,{/if}{literal}stream: '{/literal}{$node.data_map.url.content|trim}{literal}'}];
            var player_imageOnNostream = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
            {/literal}
            {if or(eq($stream_type,'2'), eq($stream_type,'3'))}{literal}var player_backgroundImage = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';{/literal}{/if}{literal}
            var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
            var attributes = {id: player_id, name: player_id};
            swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
          </script>
         {/literal}  
          <div class="streaming">
            <button onclick="player.os_load('{$node.data_map.url.content}');">{$node.data_map.button_text.content}</button>
          </div>
        </div>
      </div>
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
      {if $node.data_map.formatted_body.content}
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
      
      
      {/if}
      
    </div>
    <div class="art-center-right-column">
      <div class="block1 left-block" id="item-description">
        <div class="header">
          <h2>{$node.name|wash()}</h2>
        </div>
        <div class="content" {if $node.data_map.formatted_body.content} style="height:auto !important;"{/if}>
        {if and($node.data_map.buy_now.has_content ,  $node.data_map.add_to_cart.content,  $node.data_map.add_to_cart.has_content, $node.data_map.add_to_wish.has_content, $node.data_map.register.has_content)}
          <div class="summary">
        {else}
          <div>
        {/if}    
             <strong>{$node.name|wash()}</strong>
             <div class="body">
             {if $node.data_map.formatted_body.content}
               {attribute_view_gui attribute=$node.data_map.body}
             {else}
                {$node.data_map.body.content.output.output_text|strip_tags|shorten(400)}
             {/if}
             
             </div>
             <div class="pricing">
               {if $node.data_map.price.content.price|ne(0)} 
               <div class="price">{attribute_view_gui attribute=$node.data_map.price}</div> 
               {/if}
             </div>
          </div>
          {if and($node.data_map.buy_now.has_content ,  $node.data_map.add_to_cart.content,  $node.data_map.add_to_cart.has_content, $node.data_map.add_to_wish.has_content, $node.data_map.register.has_content)}
          <div class="action-buttons">
            {if $node.data_map.buy_now.content}
              <div class="usophia-button"><a href="#">Buy now</a></div>
            {/if}
            {if $node.data_map.add_to_cart.content}
              <div class="usophia-button"><a href="#">Add to Cart</a></div>
            {/if}
            {if $node.data_map.add_to_wish.content}
              <div class="usophia-button"><a href="#">Add to wish list</a></div>
            {/if}
            {if $node.data_map.register.content}
              <div class="usophia-button"><a href="#">Register</a></div>
            {/if}
          </div> 
          {/if}
        </div>
       
      </div> 
      {if $node.data_map.formatted_body.content|not}
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
      {/if}      
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