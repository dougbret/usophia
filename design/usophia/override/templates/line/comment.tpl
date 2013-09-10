{* Comment - Line view *}

<div class="content-view-line">
    <div class="class-comment float-break">
    
    <div class="left">
	            {if $node.object.owner.data_map.image.has_content}
      {attribute_view_gui attribute=$node.object.owner.data_map.image image_class="small"}
				{else}
				<img src={"images/blank_avatar.png"|ezdesign} width="100" alt="" />
	           	 {/if}

    </div>
    
    <div class="right">
  
      <h2>{$node.name|wash}</h2>
  

      <div class="attribute-byline float-break">
          <p class="date">{$node.object.published|l10n(datetime)}</p>
          <p class="author">{$node.object.owner.name|wash}</p>
      </div>
  
      <div class="attribute-message">
          <p>{$node.data_map.message.content|wash(xhtml)|break}</p>
      </div>

                          {section show=$node.object.can_remove}
                              <form method="post" action={"content/action/"|ezurl}>
                                  <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                                  <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
					    <input type="hidden" name="HideRemoveConfirmation" value="1" />
                                  <input class="button" type="submit" name="ActionRemove" value="{'Remove'|i18n( 'design/ezwebin/full/forum_topic' )}" onclick="if( confirm('Do you really want to delete the comment?') ) return true; else return false;"  />
                                  </form>
                          {/section}

    </div>

    </div>
</div>