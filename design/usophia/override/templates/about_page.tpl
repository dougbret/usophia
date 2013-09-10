<div class="content-view-full">
    <div class="class-salon">
    
    {if $view_parameters.show|eq('article')}

      <h1>{$node.name|wash}</h1>

          {if $node.object.data_map.short_description.has_content}
              <div class="attribute-short">
                  {attribute_view_gui attribute=$node.data_map.short_description}
              </div>
          {/if}
          
          {if $node.object.data_map.description.has_content}
              <div class="attribute-short">
                  {attribute_view_gui attribute=$node.data_map.description}
              </div>
          {/if}
              
    {else}

      <h1>{$node.name|wash}</h1>

          {if $node.object.data_map.text.has_content}
              <div class="attribute-long">
                  {attribute_view_gui attribute=$node.data_map.text}
              </div>
              <div class="break"></div>
          {/if}

        {if $node.object.data_map.show_children.data_int}
            <br /><br />
            <div class="content-view-children">
                  {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                          'sort_by', $node.sort_array ) ) as $child }
                      {node_view_gui view='line' content_node=$child}
                  {/foreach}
            </div>
        {/if}                                    

     {/if}                         
  

    </div>
</div>