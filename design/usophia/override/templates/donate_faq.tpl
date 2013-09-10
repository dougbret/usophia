<div class="content-view-full">
    <div class="class-folder">

        
            <h1>{$node.name|wash()}</h1>
                                        
            
               {if $node.object.data_map.show_children.data_int}                
                    <div class="content-view-children">
                      <ol class="faq-entries">
                      {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                              'sort_by', $node.sort_array
                                                               ) ) as $child}
                        {node_view_gui content_node=$child view="list_item"}
                      {/foreach}
                      </ol>
                    </div>

                {/if}
    </div>
</div>
