{* On the net - Line Art Center View *}
<div class="content-view-line">
  {if $node.data_map.image.has_content}
    <div class="line-image-floating">{attribute_view_gui image_class=art_center_thumb href=$node.data_map.link.content attribute=$node.data_map.image}</div>
  {/if}
  <div class="line-content">
    {if $node.data_map.body.has_content}
    <div class="line-content-summary">
      <a href="{$node.data_map.link.content}" target="_blank">{attribute_view_gui attribute=$node.data_map.link_text}</a>
    </div>
    {/if}
  </div>
</div>