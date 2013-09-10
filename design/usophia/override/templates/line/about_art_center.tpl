{* About - Line Art Center View *}

<div class="content-view-line about-art-center-line">
  <div class="line-image">{attribute_view_gui image_class=art_center_about href=$node.url_alias|ezurl attribute=$node.data_map.image}</div>
  <div class="line-content">
    {*<div class="line-content-title"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>*}
    {if $node.data_map.summary.content.is_empty|not}
    <div class="line-content-summary" >
    {if eq($node.parent.node_id, 1869)}
    <a class="summary-about-section"  href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.summary.content|strip_tags|shorten(370)}<span class="more-link-text about-section">More&nbsp;&gt;&gt;</span></a>
    {else}
    <a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.data_map.summary.content|strip_tags|shorten(145)}<span class="more-link-text">More&nbsp;&gt;&gt;</span></a>
    {/if}
    </div>
    {/if}
  </div>
</div>