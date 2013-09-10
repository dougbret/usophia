{* Streaming - Full view *}

    <div class="content-view-full">
        <div class="class-article">

          <h1>{$node.data_map.name.content|wash()}</h1>


        {if $node.data_map.code.data_text}
            <div class="content-player">
                {$node.data_map.code.data_text}
              </div>
        {/if}

        {if $node.data_map.description.content.is_empty|not}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.description}
            </div>
        {else}    
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.summary}
            </div>
        {/if}
        
        <div class="break"></div>


   

        <a href="#" class="more-link">Back to top&gt;&gt;</a><a href="/" class="more-link" onclick="history.go(-1); return false;">&lt;&lt;Back</a><a href="/" class="more-link-top" onclick="history.go(-1); return false;">&lt;&lt;Back</a>        

        </div>
    </div>
