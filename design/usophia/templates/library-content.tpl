<div id="library-content">
<h1>U-Sophia's Libraries</h1>
  <div id="tabs">
      <ul>
        {foreach fetch_alias( 'children', hash( 'parent_node_id', 188,
                                                'sort_by', $node.sort_array ) ) as $index => $child }
          <li><a href="#fragment-{$index}"><span>{$child.name}</span></a></li>
        {/foreach}
      </ul>
      {foreach fetch_alias( 'children', hash( 'parent_node_id', 188,
                                              'sort_by', $node.sort_array ) ) as $index => $child }
        <div id="fragment-{$index}">
            <table class="renderedtable">
              <tr><th>Title</th><th style="width:90px;">Date</th><th>Description</th><th>Download</th></tr>
              {foreach fetch_alias( 'children', hash( 'parent_node_id', $child.node_id ) ) as $subchild }
                  <tr>
                    <td>{$subchild.name|wash()}</td>
                    <td>{$subchild.object.published|datetime( 'custom', '%d/%m/%Y' )}</td>
                    <td>{attribute_view_gui attribute=$subchild.data_map.description}</td>
                    <td><a href={$subchild.data_map.file.content.filepath|ezroot}>{$subchild.data_map.file.content.original_filename|wash}</a></td>
                  </tr>
              {/foreach}
            </table>
        </div>
      {/foreach}
  </div>
</div>