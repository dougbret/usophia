{* File - Full view *}


<div class="content-view-full">
    <div class="class-file">

        <h1>{$node.name|wash()}</h1>

    {if $node.data_map.description.content.is_empty|not}
        <div class="attribute-long">
            {attribute_view_gui attribute=$node.data_map.description}
        </div>
    {/if}

    <div class="attribute-file">
        <p>{attribute_view_gui attribute=$node.data_map.file icon_title=$node.name}</p>
    </div>

    </div>
</div>
