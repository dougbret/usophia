{set-block scope=global variable=cache_ttl}0{/set-block}

{let current_user=fetch( 'user', 'current_user' )}
<div class="profile-page">
    
      <h1>{$node.name|wash}</h1>

          {if $node.object.data_map.text.has_content}
              <div class="attribute-short">
                  {attribute_view_gui attribute=$node.data_map.text}
              </div>
              <a href={concat($node.url_alias,"/(show)/article")|ezurl} class="more-link">&gt;&gt;More</a>
              <div class="break"></div>
          {/if}

            <br /><br />

          <a href={concat("/content/edit/", $current_user.contentobject_id, "/")|ezurl}>(edit your account)</a>
          <br />
          
          <h2>Your content</h2>
          <table class="renderedtable">
            <tr><th>Name</th><th style="width:90px;">Date</th><th>Section</th><th></th></tr>
            {foreach fetch( 'content','tree', hash( 'parent_node_id', 2,attribute_filter, array( array( 'owner', '=', $current_user.contentobject_id ) ) 
             ) ) as $child }
                <tr>
                  <td>{$child.name|wash()}</td>
                  <td>{$child.object.published|datetime( 'custom', '%d/%m/%Y' )}</td>
                  <td>{$child.path.1.name}</td>
                  <td>
                            <form method="post" action={concat("/content/edit/",$child.object.id,"/f/",$child.object.initial_language_code)|ezurl} class="left">
                              <input type="submit" value="Edit" name="Submit" />
                            </form>               
                            <form id="form-remove" method="post" action={"/content/action"|ezurl}>
                              <input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
                              <input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
                              <input type="submit" name="ActionRemove" value="Remove" />
                            </form>                                    
                  </td>
                </tr>
            {/foreach}
          </table>
  
          <h2>Your comments</h2>
          <table class="renderedtable">
            <tr><th>Name</th><th style="width:90px;">Date</th><th>Section</th><th></th></tr>
            {foreach fetch( 'content','tree', hash( 'parent_node_id', 2,'class_filter_type','include','class_filter_array',array('comment'),attribute_filter, array( array( 'owner', '=', $current_user.contentobject_id ) ) 
             ) ) as $child }
                <tr>
                  <td>{$child.name|wash()}</td>
                  <td>{$child.object.published|datetime( 'custom', '%d/%m/%Y' )}</td>
                  <td>{$child.path.1.name}</td>
                  <td>
                            <form method="post" action={concat("/content/edit/",$child.object.id,"/f/",$child.object.initial_language_code)|ezurl} class="left">
                              <input type="submit" value="Edit" name="Submit" />
                            </form>               
                            <form id="form-remove" method="post" action={"/content/action"|ezurl}>
                              <input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
                              <input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
                              <input type="submit" name="ActionRemove" value="Remove" />
                            </form>                                    
                  </td>
                </tr>
            {/foreach}
          </table>
         
</div>
{/let}