    <div class="content-view-full">
        <div class="class-venue">

          <h1>{$node.name|wash()}</h1>

            {if $node.children[0].data_map.image.has_content}
                <div class="attribute-image">
			<img src={$node.children[0].data_map.image.content["medium"].url|ezroot} alt="" id="mainImage" />

<br />
{foreach $node.children as $child}
	<img src={$child.data_map.image.content["small"].url|ezroot} rel={$child.data_map.image.content["medium"].url|ezroot} alt="" onclick="$('#mainImage').attr('src', $(this).attr('src').replace('small','medium') )" />
{/foreach}
                </div>
            {/if}

                <div class="description">
            {if $node.data_map.description.content.is_empty|not}
                    {attribute_view_gui attribute=$node.data_map.description}
            {/if}
</div>




	<div class="break"></div>
	<h1>Getting around the venue</h1>
                {attribute_view_gui attribute=$node.data_map.around_the_venue_text}
	<h1>How to get tickets</h1>
                {attribute_view_gui attribute=$node.data_map.get_tickets_text}

<div class="break"></div>

        
        <div class="break"></div>
        {let related=fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'all_relations', true(), 'group_by_attribute', true(), 'sort_by', array( array( 'class_identifier', true() ), array( 'name', true() ) ) ) )} 
          {if $related}
                    <h1>Related Content</h1>
            <ul>
             
                     {foreach $related[0] as $object}
            <li><a href={$object.main_node.url_alias|ezurl}>{$object.main_node.name}</a></li>
                      {/foreach}
            </ul>
          {/if}
            {*{$related|attribute(show)}*}
        {/let}
  {*      

        <h1>Comments</h1>        
                <div class="content-view-children">
                    {foreach fetch_alias( comments, hash( parent_node_id, $node.node_id ) ) as $comment}
                        {node_view_gui view='line' content_node=$comment}
                    {/foreach}
                </div>

                {if fetch( 'content', 'access', hash( 'access', 'create',
                                                      'contentobject', $node,
                                                      'contentclass_id', 'comment' ) )}
                    <form method="post" action={"content/action"|ezurl}>
                    <input type="hidden" name="ClassIdentifier" value="comment" />
                    <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
                    <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
                    <input class="new-comment" type="submit" name="NewButton" value="{'New comment'|i18n( 'design/ezwebin/full/article' )}" />
                    </form>
                {else}
                    {if ezmodule( 'user/register' )}
                        <p>{'%login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( 'design/ezwebin/full/article', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', "/user/register"|ezurl(no), '">' ), '%create_link_end', '</a>' ) )}</p>
                    {else}
                        <p>{'%login_link_startLog in%login_link_end to comment.'|i18n( 'design/ezwebin/article/comments', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>' ) )}</p>
                    {/if}
                {/if}

*}
          <div class="break"></div>
          <a href="#" class="more-link">Back to top&gt;&gt;</a><a href="/" class="more-link" onclick="history.go(-1); return false;">&lt;&lt;Back</a><a href="/" class="more-link-top" onclick="history.go(-1); return false;">&lt;&lt;Back</a>        

        </div>
    </div>