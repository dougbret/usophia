<div class="content-view-full">
    <div class="class-frontpage">
    {* Code for streaming player *}
    {def $streaming = fetch(content,list,hash(parent_node_id, $node.node_id,
                                              limit,1,
                                              class_filter_type, include,
                                              class_filter_array, array('streaming')
                                              ))}
    
    {if $streaming.0}                                          
      {node_view_gui content_node=$streaming.0 view=line}
    {/if}
    
    
    {let news_noteworthy_node=fetch('content','node',hash('node_id',91))}
      <div class="attribute-header">
        <h1>{$news_noteworthy_node.name|wash}</h1>
        <a href={"rss/feed/news-noteworthy"|ezurl}><img src={"images/rss.png"|ezdesign} alt="News and Noteworthy RSS feed" /></a>
      </div>
      
      <div class="break"></div>
      {let news=fetch( 'content', 'list', hash( 'parent_node_id', $news_noteworthy_node.node_id,
                                                                  'sort_by', $news_noteworthy_node.sort_array,
                                                                  limit,12
                                                                  ))}
        {foreach $news as $index => $child}
              
          {node_view_gui content_node=$child view="line"}
        {/foreach}                                                                
      {/let}
      <p><a href={$news_noteworthy_node.url_alias|ezurl}>Show all</a></p>
    {/let}
    
  
    
    
    {*let usophia_suggests_node=fetch('content','node',hash('node_id',92))}                                                                
      <div class="attribute-header">
        <h1>{$usophia_suggests_node.name|wash}</h1> 
        <a href={"rss/feed/usophia-suggests"|ezurl}><img src={"images/rss.png"|ezdesign} alt="U-Sophia suggests RSS feed" /></a>
      </div>
      <div class="break"></div>

      {let events=fetch( 'content', 'list', hash( 'parent_node_id', $usophia_suggests_node.node_id, 
                                                                  'sort_by', $usophia_suggests_node.sort_array,
                                                                  limit,4
                                                                  ))}
        {foreach $events as $child}
          {node_view_gui content_node=$child view="line"}
        {/foreach}                                                                
      {/let}                                       
      
      <p><a href={$usophia_suggests_node.url_alias|ezurl}>Show all</a></p>
    {/let*}         
    
      
    </div>
</div>