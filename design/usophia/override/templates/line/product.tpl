{* Product - Line view *}

<div class="content-view-line">
    <div class="class-product float-break">

        <h2><a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></h2>

        <div class="attribute-image">
	    {if $node.data_map.image.has_content}
	           {attribute_view_gui href=$node.url_alias|ezurl image_class=small attribute=$node.data_map.image}
		{elseif $node.parent.data_map.image.has_content}
	           {attribute_view_gui href=$node.url_alias|ezurl image_class=small attribute=$node.parent.data_map.image}
		{else}
	           {attribute_view_gui href=$node.url_alias|ezurl image_class=small attribute=$node.parent.parent.data_map.image}
		{/if}
        </div>
        <div class="attribute-short">
           {attribute_view_gui attribute=$node.object.data_map.short_description}
        </div>


        <div class="attribute-price">
          <p>
           {attribute_view_gui attribute=$node.object.data_map.price}
          </p>
          <p class="ex-vat">(price ex. vat {$node.object.data_map.price.content.ex_vat_price})</p>
        </div>

   </div>
</div>
