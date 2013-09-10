{def $article-blocks = fetch(content,list,hash(parent_node_id, $current_node.node_id,
                                              class_filter_type, include,
                                              class_filter_array, array('article_block'),
                                              sort_by, array('priority', true())
                                              ))
  $object = false()  
  $edit = false()  
}
{if $article-blocks|not}
  {set $article-blocks = fetch(content,list,hash(parent_node_id, 2,
                                              class_filter_type, include,
                                              class_filter_array, array('article_block'),
                                              sort_by, array('priority', true())
                                              ))}
{/if}

{if $article-blocks|count}
<div id="right-sidebar">
{*
  {let donate_node=fetch('content','node',hash('node_id',106))}
    <div class="article-block">
    <h2>{$donate_node.name|wash}</h1>
    <div class="content donate article-block-content">                
        <ul>                       
         <li><input class="clear-button blue-bg" type="submit"  name="NewButton" value="Donate" onclick="window.location={"/Help-keep-U-Sophia-free/Donate-to-U-Sophia"|ezurl('single')};" /> </li>	                      
         <li><a href="/Help-keep-U-Sophia-free/Donors-FAQ" target="_blank">Donors' FAQ</a></li>

        </ul>
    </div>
  </div>
  {/let}  
*}

  {foreach $article-blocks as $block}
  {set  $edit = fetch( 'content', 'access',
                  hash( 'access', 'edit',
                        'contentobject', $block ) )}
  
  <div class="article-block">
     <h2>{$block.name}</h2>
    <div class="article-block-content color-schema-{$block.data_map.color_schema.content.0}">
    {if $block.data_map.article_relation.has_content}
      {set $object = fetch( content, object, hash( object_id, $block.data_map.article_relation.content.relation_list.0.contentobject_id))} 
       
       <div class="class-article float-break">

          <div class="attribute-image">
            {section show=$object.main_node.data_map.image.has_content}
                {attribute_view_gui image_class=articlethumbnail href=$object.main_node.url_alias|ezurl attribute=$object.main_node.data_map.image}
            {/section}            
          </div>

          <div class="right">
           
            
            {if $object.main_node.data_map.intro.content.is_empty|not}
              <div class="attribute-short">
                  {$object.main_node.data_map.intro.content.output.output_text|strip_tags|shorten(180)}
              </div>                                     
            {else}
              <div class="attribute-short">
                  {$object.main_node.data_map.body.content.output.output_text|strip_tags|shorten(180)}
              </div>                                     
            {/if}
                  
            <a class="block-more-color" href={$object.main_node.url_alias|ezurl}>More &gt;&gt;</a>
             {*if $edit}
                <div class="edit-link"><a href="/content/edit/{$block.object.id}">Edit</a></div>
              {/if*}
          </div>
          

          </div>
    {else} 
      <div class="class-article float-break">     
         <div class="right">
          <div class="attribute-short">
              {attribute_view_gui attribute=$block.data_map.summary}
          </div>

          <div style="display:none"><div id="event-nid-{$block.node_id}">{attribute_view_gui attribute=$block.data_map.body}</div></div>  
                  
          <a class="block-more-color lightbox" href="#event-nid-{$block.node_id}">More &gt;&gt;</a>
        </div>
      </div>
    {/if}  
    </div>
  </div>
{/foreach}  
</div>
{/if}