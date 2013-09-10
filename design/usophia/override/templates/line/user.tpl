{* Article - Line view *}

<div class="content-view-line">
    <div class="class-article float-break">

    <div class="attribute-image">
      {section show=$node.data_map.image.has_content}
          {attribute_view_gui attribute=$node.data_map.image image_class=articlethumbnail href=concat("/Life-On-U-Sophia/(contributor)/", $node.data_map.user_account.content.login)}
      {/section}            
    </div>

    <div class="right">
      <h2><a href={concat("/Life-On-U-Sophia/(contributor)/", $node.data_map.user_account.content.login)|ezurl}>{$node.name|wash}</a></h2>
              <div class="attribute-short">
            {$node.data_map.description.content.output.output_text|strip_tags|shorten(150)}
            {$node.data_map.description.content|shorten(150)}
        </div>                                     
            {*
      <a href={$node.url_alias|ezurl}>See profile</a>*}
    </div>
    

    </div>
</div>