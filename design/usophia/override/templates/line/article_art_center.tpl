{* Article - Line Art Center View *}
<div class="content-view-line">
  <div class="line-image-floating">{attribute_view_gui image_class=art_center_thumb href=$node.url_alias|ezurl attribute=$node.data_map.image}</div>
  <div class="line-content">
  {if $node.data_map.short_title.has_content}
    <div class="line-content-title"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>
  {else}
    <div class="line-content-title"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>
  {/if}  
    {if $node.data_map.intro.has_content}
    <div class="line-content-summary"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.intro.content.output.output_text|strip_tags|shorten(120)}<span class="more-link-text">More&nbsp;&gt;&gt;</span></a></div>
    {/if}
  </div>
</div>