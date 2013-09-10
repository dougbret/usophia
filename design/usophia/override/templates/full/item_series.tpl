{* Streaming - Full view *}

{def $streaming_products = array()                                  
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

{def $streaming_array = array()
     $counter = 0
}
{foreach $node.data_map.series_items.content.relation_list as $index => $item}
  {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))}
  {* if streaming or mediatheque *}
  {if or(eq($object.main_node.data_map.type.content.0 ,0), eq($object.main_node.data_map.type.content.0 ,2))}
    {* If streaming is live or recorded *}
    {if or(eq($object.main_node.data_map.item_status.content.0 ,1), 
           eq($object.main_node.data_map.item_status.content.0 ,2),
           eq($object.main_node.data_map.item_status.content.0 ,6))}
      {* Setting fisrt item in the play list*}
      {if eq(0, $counter)}
        {set $counter = $counter|inc}
      {/if}
      {* Send the correct url if recorded or streaming *}
      {if  eq($object.main_node.data_map.item_status.content.0 ,2)}
        {if $object.main_node.data_map.recorded_url.has_content}
          {set $streaming_array = $streaming_array|append(concat( "id: 'my_stream-", $object.main_node.node_id, "',stream: '", $object.main_node.data_map.recorded_url.content|trim, "'"))}
        {/if}    
      {else}
        {if $object.main_node.data_map.url.has_content}
          {set $streaming_array = $streaming_array|append(concat( "id: 'my_stream-", $object.main_node.node_id, "',stream: '", $object.main_node.data_map.url.content|trim, "'"))}
        {/if}
      {/if}
      
    {/if}
  {else} {* If interactive and it is recorded*}
    {if  eq($object.main_node.data_map.item_status.content.0 ,2)}
      {* Setting fisrt item in the play list*}
      {if eq(0, $counter)}
        {set $counter = $counter|inc}
      {/if} 
      {set $streaming_array = $streaming_array|append(concat( "id: 'my_stream-", $object.main_node.node_id, "',stream: '", $object.main_node.data_map.recorded_url.content|trim, "'"))}
    {/if} 
  {/if} 
{/foreach}

<div class="content-view-full" id="player-product">
    <div class="art-center-left-column" >
      <div class="block1 ">
        <div class="header">
          <h2>Auditorium</h2>
        </div>
         <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
        <div id="content-player">
          <div id="player"></div> 
             
          
          {literal}
           
          <script type="text/javascript">
          
           
            var player_id = 'player';
            var player_width = 400;
            var player_height = 225;
            var player_imageOnNostream = '';
            var player_stream = 'my_stream';
                  var player_streams = [ {id: 'my_stream',stream: 'octoshape://streams.octoshape.net/u-sophia'}
            
            {/literal}
            {if gt($counter,0)}
              ,{*this is for the fake stream json to add other element*}
              {foreach $streaming_array as $index => $stream}
                
                {literal}{{/literal}{$stream}{literal}}{/literal}{if lt($index|inc, $streaming_array|count)},{/if}
              {/foreach}
            {/if}    
            {literal}];{/literal}
            {literal}
            
            player_imageOnNostream = '{/literal}{$node.data_map.preview_image.content["player_preview"].url|ezroot(no)}{literal}';
            var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
            var attributes = {id: player_id, name: player_id};
            swfobject.embedSWF('http://cdn.octoshape.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);
          </script>
         {/literal} 
         
         
         
         
        </div>
        
        
        
      </div>
      <div>
          {if or($node.data_map.buy_now.has_content ,  $node.data_map.add_to_cart.content,  $node.data_map.add_to_cart.has_content, $node.data_map.add_to_wish.has_content, $node.data_map.register.has_content)}
          <div class="action-buttons">
              <div>
              {if $node.data_map.price.has_content}
                <div class="pricing">
                   {if $node.data_map.price.content.price|ne(0)} 
                   <div class="price">{attribute_view_gui attribute=$node.data_map.price}</div> 
                   {/if}
                 </div> 
               {/if}    
              {if $node.data_map.add_to_cart.content}
                <div class="button-container" style="float:right"> 
                <form method="post" action={"content/action"|ezurl}>
                  <input type="submit" class="defaultbutton usophia-button" name="ActionAddToBasket" value="{'Add to Basket'|i18n("design/ezwebin/full/product")}" />
                  {*<input class="button" type="submit" name="ActionAddToWishList" value="{"Add to wish list"|i18n("design/ezwebin/full/product")}" />*}
                  <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                  <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                  <input type="hidden" name="ViewMode" value="full" /> 
                </form>
                </div>
              {/if}

              {if $node.data_map.add_to_wish.content}
                <div class="button-container" style="float:right"> 
                <form method="post" action={"content/action"|ezurl}>

                  <input class="button usophia-button" type="submit" name="ActionAddToWishList" value="{'Wish list'|i18n("design/ezwebin/full/product")}" />
                  <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                  <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                  <input type="hidden" name="ViewMode" value="full" />
                </form>
                </div>
              {/if}
              
            
              </div>
           
            <div style="clear:both; padding-top:10px">
              {if and($permissions|not,$node.data_map.price.content.price|ne(0),ne($node.data_map.item_status.content.0 ,4))}
                {if $node.data_map.buy_now.content}
                  <div class="button-container" style="margin-left:0">
                  <form method="post" action={"content/action"|ezurl}>
                    <input type="submit" class="defaultbutton usophia-button" name="ActionAddToBasket" value="{'Buy Now'|i18n("design/ezwebin/full/product")}" />
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                  </form>
                  </div>
                {/if}
              {/if}
            
              {if $node.data_map.register.content}
                <div class="button-container"><a href="#">Register</a></div>
              {/if}
            </div>
          </div> 
        {/if}
      
      </div>
      <div class="block1" id="streaming-body">
        <div class="header"> 
          <h2>{$node.name|wash()}</h2>
        </div>
        <div class="content" >
               {attribute_view_gui attribute=$node.data_map.body}
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
    <div class="art-center-right-column">
      <div class="block1" id="streaming-list">
        <div class="header"> 
          <h2>{$node.name|wash()}</h2>
        </div>
        <div class="content" >
          {foreach $node.data_map.series_items.content.relation_list as $index => $item}
            {set $object = fetch( content, object, hash( object_id, $item.contentobject_id ))} 
            {node_view_gui content_node=$object.main_node view=line_art_center watch_it=1 status=1 type=1 table=0 series_url=concat("/",$node.url_alias)}
          {/foreach}
        
        </div>
        
      </div>  

           
    </div>
    <div class="break"></div>
    <a href="#" class="more-link">Back to top&gt;&gt;</a><a href={$node.parent.url_alias|ezurl} class="more-link" >&lt;&lt;Back</a><a href={$node.parent.url_alias|ezurl} class="more-link-top" >&lt;&lt;Back</a>  
</div>
  {literal}
  <script>
      $(function() {
          $( ".products-tabs" ).tabs();
    });
   </script>
  {/literal}
