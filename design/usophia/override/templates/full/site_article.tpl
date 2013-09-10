{* Article - Full view *}

    <div class="content-view-full">
        <div class="class-article">

          <h1>{$node.data_map.title.content|wash()}</h1>


        {if eq( ezini( 'article', 'ImageInFullView', 'content.ini' ), 'enabled' )}
            {if $node.data_map.image.has_content}
                <div class="attribute-image">
                    {attribute_view_gui attribute=$node.data_map.image image_class=medium}

                    {if $node.data_map.caption.has_content}
                    <div class="caption" style="width: {$node.data_map.image.content.medium.width}px">
                        {attribute_view_gui attribute=$node.data_map.caption}
                    </div>
                    {/if}
                </div>
            {/if}
        {/if}
                               
<div id="accordion">
	<h3><a href="#">Video</a></h3>
	<div>
	   <div style="height:580px;">
      {attribute_view_gui attribute=$node.data_map.intro}
    </div>
	</div>
	<h3><a href="#">Article</a></h3>
	<div>
    {attribute_view_gui attribute=$node.data_map.body}
	</div>
</div>


        </div>
    </div>