{* Recommendation - Line Art Center View *}
<div class="content-view-line">
{if $node.data_map.image.has_content}
  <div class="line-image-floating">{attribute_view_gui image_class=art_center_thumb href=$node.url_alias|ezurl attribute=$node.data_map.image}</div>
{/if}
  <div class="line-content">
    {*<div class="line-content-title"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>*}
    {if $node.data_map.summary.content.is_empty|not}
    <div class="line-content-summary">
      <a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.summary.data_text|strip_tags|shorten(30)} <span class="more-link-text">More&nbsp;&gt;&gt;</span></a>
    </div>
    {/if}
  </div>
</div>