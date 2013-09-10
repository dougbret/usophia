{* Art - Full view *}

    <div class="content-view-full">
        <div class="class-art">

          <h1>{$node.name|wash()}</h1>

        <div class="attribute-byline">
        <p class="author">
{if $node.data_map.author.has_content}{attribute_view_gui attribute=$node.data_map.author}{else}{$node.object.owner.name}{/if}
        </p>
        <p class="date">
             {$node.object.published|l10n(shortdatetime)}
        </p>
        </div>

        {if eq( ezini( 'article', 'ImageInFullView', 'content.ini' ), 'enabled' )}
            {if $node.data_map.image.has_content}
                <div class="attribute-image">
          <a href={$node.data_map.image.content["art_lightbox"].full_path|ezroot} class="lightbox"><img src={$node.data_map.image.content["medium"].full_path|ezroot} alt="{$node.name}" /></a>

                    {if $node.data_map.caption.has_content}
                    <div class="caption" style="width: {$node.data_map.image.content.medium.width}px">
                        {attribute_view_gui attribute=$node.data_map.caption}
                    </div>
                    {/if}
                </div>
            {/if}
        {/if}

        {if $node.data_map.description.content.is_empty|not}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.description}
            </div>
        {/if}
        
        {if $node.data_map.file.content.filepath|downcase|contains('.mp3')}
		<br />
            {let attribute=$node.data_map.file
                 download_url=concat( '/content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode)}                 
            <object type="application/x-shockwave-flash" data="/extension/opaudioplayer/design/standard/javascript/dewplayer/dewplayer-mini.swf" width="160" height="20" id="dewplayer" name="dewplayer">            
            <param name="wmode" value="transparent" />
            <param name="movie" value="/extension/opaudioplayer/design/standard/javascript/dewplayer/dewplayer-mini.swf" />
            <param name="flashvars" value="mp3={$download_url}&amp;autostart=1&amp;autoreplay=1&amp;showtime=1&amp;randomplay=1&amp;nopointer=1" />
            </object><br />
            {/let}  
        {elseif $node.data_map.file.content.filepath|downcase|contains('.pdf')}
            {*{if $node.object.data_map.file.content.mime_type|eq('application/pdf')}
            <img src={$node.object.data_map.file.content.filepath|pdfpreview( 400, 600, 1, "My PDF.pdf" )|ezroot} alt="Preview">
            {/if}   *}
          {/if}



        {if $node.data_map.file.has_content}
          <br />Attached file: {attribute_view_gui attribute=$node.data_map.file}<br />
        {/if}

        
        <div class="break"></div>

        <div class="attribute-star-rating">
            {attribute_view_gui attribute=$node.data_map.rating}
        </div>


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
                  <input class="clear-button" type="submit"  name="NewButton" value="Comment" />
                    </form>
                {else}
                        <p>{'%login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( 'design/ezwebin/full/article', , hash( '%login_link_start', concat( '<a href="', '/user/login'|ezurl(no), '?redirect=', $node.url_alias|ezurl(no), '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', "/user/register"|ezurl(no), '">' ), '%create_link_end', '</a>' ) )}</p>
                {/if}

{*        {def $tipafriend_access=fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                      'function', 'tipafriend' ) )}
        {if and( ezmodule( 'content/tipafriend' ), $tipafriend_access )}
        <div class="attribute-tipafriend">
            <p><a href={concat( "/content/tipafriend/", $node.node_id )|ezurl} title="{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}">{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}</a></p>
        </div>
        {/if}
*}
        </div>
    </div>
