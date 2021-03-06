{* Article - Line view *}

<div class="content-view-line">
    <div class="class-article float-break">

    <div class="attribute-image">
      {section show=$node.data_map.image.has_content}
          {attribute_view_gui image_class=articlethumbnail href=$node.url_alias|ezurl attribute=$node.data_map.image}
      {/section}            
    </div>

    <div class="right">
      <h2><a href={$node.url_alias|ezurl}>{$node.data_map.title.content|wash}</a></h2>
      
      {if $node.data_map.intro.content.is_empty|not}
        <div class="attribute-short">
            {$node.data_map.intro.content.output.output_text|strip_tags|shorten(150)}
        </div>                                     
      {else}
        <div class="attribute-short">
            {$node.data_map.body.content.output.output_text|strip_tags|shorten(150)}
        </div>                                     
      {/if}
            
      <a href={$node.url_alias|ezurl}><img src={"images/moreLine.png"|ezdesign} alt="" /></a>
    </div>
    

    </div>
</div>