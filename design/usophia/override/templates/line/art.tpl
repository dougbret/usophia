{* Art - Line view *}

<div class="content-view-line">
    <div class="class-article float-break">

    <div class="attribute-image">
      {section show=$node.data_map.image.has_content}
          {attribute_view_gui image_class=articlethumbnail href=$node.url_alias|ezurl attribute=$node.data_map.image}
      {/section}            
    </div>

    <div class="right">
      <h2><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h2>
      
        <div class="attribute-byline">
        
        <p class="author">
             {if $node.data_map.author.has_content}{attribute_view_gui attribute=$node.data_map.author}{else}{$node.object.owner.name}{/if} in {$node.parent.name}
        </p>
        
        <p class="date">
             {$node.object.published|l10n(shortdatetime)}
        </p>
        </div>

      
      {if $node.data_map.description.content.is_empty|not}
        <div class="attribute-short">
            {$node.data_map.description.content.output.output_text|strip_tags|shorten(150)}
        </div>                                     
      {/if}
            
      <a href={$node.url_alias|ezurl} class="more-link">more &raquo;</a>
    </div>
    

    </div>
</div>