<div class="content-view-full">
    <div class="class-salon">
    {if $view_parameters.show|eq('all')}
      <h1>All recorded sessions</h1>
            {def $page_limit = 50
                 $children = array()
                 $children_count = ''}

            {set $children_count=fetch( 'content', 'tree_count', hash( 'parent_node_id', $node.node_id,
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', array('link') ) )}
          <div class="content-view-children">
                  {foreach fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id,
                                                          'offset', $view_parameters.offset,
                                                          'sort_by', array('priority',false() ),
                                                          'class_filter_type', 'include',
                                                          'class_filter_array', array('session'),
                                                          'limit', $page_limit ) ) as $child }
                       {node_view_gui content_node=$child view="line2"}
                  {/foreach}
          </div>
            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}
    {else}
      <h1>{$node.name|wash}</h1>

      {if $node.object.data_map.text.has_content}
          <div class="attribute-short">
              {attribute_view_gui attribute=$node.data_map.text}
          </div>
          {*<a href={concat($node.url_alias,"/(show)/article")|ezurl} class="more-link">&gt;&gt;More</a>*}
          <div class="break"></div>
      {/if}

        <br /><br />
            
     {* <h1>Series</h1>
      {let series=fetch( 'content', 'tree', hash( 'parent_node_id', 148,
      'class_filter_type','include',
      'class_filter_array',array('series')                                                                  
                                                                  ))}
        {foreach $series as $child}
          {node_view_gui content_node=$child view="line"}
        {/foreach}                                                                
      {/let}
                                                           
      <h1>Guests at U-Sophia</h1>
      {let guests=fetch( 'content', 'list', hash( 'parent_node_id', 144, 
                                                                  'sort_by', $usophia_suggests_node.sort_array
                                                                  ))}
        {foreach $guests as $child}
          {node_view_gui content_node=$child view="line"}
        {/foreach}                                                                
      {/let}                                       
      *}  
     {/if}                         
  

    </div>
</div>