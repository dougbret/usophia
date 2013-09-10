{* Art Center - Line Art Centers View *}
{def $about = fetch(content, tree, hash(parent_node_id, $node.node_id,
                                                    class_filter_type, include,
                                                    limit, 1,
                                                    class_filter_array, array('about_art_center'),
                                                    sort_by, array('priority', true())      
                                                    ))

}

<div class="content-view-line">
  <div class="line-image-floating">{attribute_view_gui image_class=art_center_thumb href=$about.0.url_alias|ezurl attribute=$about.0.data_map.image}</div>
  <div class="line-content">
    <div class="line-content-title"><a href={$node.url_alias|ezurl} title="{$node.name|wash()}" >{$node.name|wash()}</a></div>
    {if $about.0.data_map.summary.has_content}
    <div class="line-content-summary"><a href={$node.url_alias|ezurl} title="{$about.0.name|wash()}" >{$about.0.data_map.summary.data_text|strip_tags|shorten(120)}</a></div>
    {/if}
  </div>
</div>