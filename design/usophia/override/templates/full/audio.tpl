{* Audio - Full view *}

    <div class="content-view-full">
        <div class="class-art">

          <h1>{$node.name|wash()}</h1>

        <div class="attribute-byline">
        {*{if $node.data_map.author.content.is_empty|not()}*}
        <p class="author">
             {$node.object.creator.name}
        </p>
        {*{/if}*}
        <p class="date">
             {$node.object.published|l10n(shortdatetime)}
        </p>
        </div>

        
            {let attribute=$node.data_map.file}
<div id="audio" style="display:block;width:450px;height:30px;"
	href={$attribute.content.filepath|ezurl}></div>
            {/let}  
        

<script type="text/javascript">
{literal}
$(function() {
	
	// setup player normally
	$f("audio", "http://releases.flowplayer.org/swf/flowplayer-3.2.7.swf", {
		clip: {
			autoPlay: false,
		},
				
		// show playlist buttons in controlbar
		plugins: {
			controls: {
				playlist: false,
				fullscreen: false,
				height: 30,
				autoHide: false
			}
		}
	});
	
});
{/literal}
</script>


        <div class="break"></div>

        <div class="attribute-star-rating">
            {attribute_view_gui attribute=$node.data_map.rating}
        </div>
        
        <br /><br />


            <h1>{"Comments"|i18n("design/ezwebin/full/article")}</h1>
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
                    <input class="button new_comment" type="submit" name="NewButton" value="{'New comment'|i18n( 'design/ezwebin/full/article' )}" />
                    </form>
                {else}
                    {if ezmodule( 'user/register' )}
                        <p>{'%login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( 'design/ezwebin/full/article', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', "/user/register"|ezurl(no), '">' ), '%create_link_end', '</a>' ) )}</p>
                    {else}
                        <p>{'%login_link_startLog in%login_link_end to comment.'|i18n( 'design/ezwebin/article/comments', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '">' ), '%login_link_end', '</a>' ) )}</p>
                    {/if}
                {/if}

        {def $tipafriend_access=fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                      'function', 'tipafriend' ) )}
        {if and( ezmodule( 'content/tipafriend' ), $tipafriend_access )}
        <div class="attribute-tipafriend">
            <p><a href={concat( "/content/tipafriend/", $node.node_id )|ezurl} title="{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}">{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}</a></p>
        </div>
        {/if}

        </div>
    </div>
