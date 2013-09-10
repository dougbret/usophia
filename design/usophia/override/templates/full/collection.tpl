{* Product - Full view *}


<form method="post" action={"content/action"|ezurl}>
<div class="content-view-full">
    <div class="class-product">

        <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
        </div>
        
        {if $node.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=medium attribute=$node.data_map.image}
            {if $node.data_map.caption.has_content}
            <div class="caption">
                {attribute_view_gui attribute=$node.data_map.caption}
            </div>
            {/if}
        </div>
        {/if}

        <div class="attribute-product-number">
           {attribute_view_gui attribute=$node.object.data_map.product_number}
        </div>

        <div class="attribute-short">
           {attribute_view_gui attribute=$node.object.data_map.short_description}
        </div>

        <div class="attribute-long">
           {attribute_view_gui attribute=$node.object.data_map.description}
        </div>

        <div class="attribute-price">
          <p>
           {attribute_view_gui attribute=$node.object.data_map.price}
          </p>
        </div>

        <div class="attribute-multi-options">
           {attribute_view_gui attribute=$node.object.data_map.additional_options}
        </div>

        {* Category. *}
        {def $product_category_attribute=ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
        {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
        <div class="attribute-long">
          <p>Category:&nbsp;{attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
        </div>
        {/if}
        {undef $product_category_attribute}

        <div class="content-action">
            <input type="submit" class="defaultbutton" name="ActionAddToBasket" value="{"Add to basket"|i18n("design/ezwebin/full/product")}" />
            {*<input class="button" type="submit" name="ActionAddToWishList" value="{"Add to wish list"|i18n("design/ezwebin/full/product")}" />*}
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
        </div>

<table class="clips">
<tr><th class="links"></th><th class="name"></th>{*<th>Artists</th><th>Product</th>*}<th class="links"></th><tr>
{foreach $node.children as $file}	
<tr>
	<td>	<a href={$file.data_map.teaser.content.filepath|ezroot} onclick="$('#audio-playlist').show();$f('audio-playlist').play({ldelim}url:this.href,title:'{$file.name}'{rdelim});return false;"><img src={"images/play-button.jpg"|ezdesign} width="20" /></a></td>
	<td>
	<a href={$file.data_map.teaser.content.filepath|ezroot} onclick="$('#audio-playlist').show();$f('audio-playlist').play({ldelim}url:this.href,title:'{$file.name}'{rdelim});return false;">
		{$file.name} <span></span>
		<em></em>
	</a>
	</td>
{*	<td><a href={$guest_node.url_alias|ezurl}>{$guest_node.name}</a></td>
	<td><a href={$file.url_alias|ezurl}>{$file.name}</a></td>*}
	<td>	

<div class="salon-buttons">
  <a href={concat("content/tipafriend/",$file.node_id)|ezurl} class="tipafriend-button">Email link to a friend</a>
  <a href={$file.url_alias|ezurl} class="download-button">Read more</a>
  <a href="#" onclick="$('#shop-{$file.node_id}').submit();return false;" class="view-button">Buy On-Line</a>
</div>

	<form method="post" action={"content/action"|ezurl} id="shop-{$file.node_id}">
            <input type="hidden" class="defaultbutton" name="ActionAddToBasket" value="{"Add to basket"|i18n("design/ezwebin/full/product")}" />
            <input type="hidden" name="ContentNodeID" value="{$file.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$file.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
	</form>
	</td>
{/foreach}
	
</table>


<div id="audio-playlist" style="display:block;width:100%;height:30px;display:none;"
	href={$node.children[0].data_map.teaser.content.filepath|ezroot}></div>


<!-- let rest of the page float normally -->
<br clear="all"/>
<script type="text/javascript">
{literal}
$(function() {
	
	// setup player normally
	$f("audio-playlist", "http://releases.flowplayer.org/swf/flowplayer-3.2.7.swf", {
		clip: {
			autoPlay: false,
		onBeforeBegin: function() {
			$f("audio-playlist").close();
		}

		},
		
{/literal}
{*		// our playlist
		playlist: [
{foreach $music_files as $child}
            {let attribute=$node.data_map.teaser}
			{ldelim}
				url: {$file.data_map.teaser.content.filepath|ezroot('single')},
				title: '{$child.name}'
			{rdelim}
{delimiter},{/delimiter}
	{/let}
{/foreach}	
		],
*}
{literal}		

		// show playlist buttons in controlbar
		plugins: {
			controls: {
				playlist: false,
				fullscreen: false,
				height: 30,
				autoHide: false
			}
		}
	});
	
});
{/literal}
</script>


        
        <br /><br />{*<h3>Preview:</h3>*}
        {if $node.data_map.teaser.content.filepath|downcase|contains('.mp3')}
            {let attribute=$node.data_map.teaser
                 download_url=concat( '/content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode)}                 

<div id="audio" style="display:block;width:500px;height:30px;"
	href={$attribute.content.filepath|ezurl}></div>


            {/let}  
        {elseif $node.data_map.teaser.content.filepath|downcase|contains('.pdf')}
          <a href={$node.data_map.teaser.content.filepath|ezroot}>View</a>
            {*{if $node.object.data_map.teaser.content.mime_type|eq('application/pdf')}
              <img src={$node.object.data_map.teaser.content.filepath|pdfpreview( 400, 600, 1, "My PDF.pdf" )|ezroot} alt="Preview">
            {/if}*}   
          {/if}

       {* Related products. *}
       {def $related_purchase=fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
       {if $related_purchase}
        <div class="relatedorders">
            <h2>{'People who bought this also bought'|i18n( 'design/ezwebin/full/product' )}</h2>

            <ul>
            {foreach $related_purchase as $product}
                <li>{content_view_gui view=text_linked content_object=$product}</li>
            {/foreach}
            </ul>
        </div>
       {/if}
       {undef $related_purchase}
   </div>
</div>
</form>
