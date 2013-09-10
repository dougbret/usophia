{* Feedback form - Full view *}

<div class="content-view-full">
    <div class="class-feedback-form">

            <h1>{$node.name|wash()}</h1>

        {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                 class='message-warning'
                 validation=$validation collection_attributes=$collection_attributes}

        <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.description}
        </div>
        <form method="post" action={"content/action"|ezurl}>

              {let attribute=$node.data_map.sender_name}
                <div class="box">
                  <label>{$attribute.contentclass_attribute.name}</label>
                  <div class="attribute-content">
                    {attribute_view_gui attribute=$attribute}
                  </div>
                  <div class="break"></div>
                </div>
              {/let}

              {let attribute=$node.data_map.email}
                <div class="box">
                  <label>{$attribute.contentclass_attribute.name}</label>
                  <div class="attribute-content">
                    {attribute_view_gui attribute=$attribute}
                  </div>
                  <div class="break"></div>
                </div>
              {/let}

              {let attribute=$node.data_map.category}
                <div class="box">
                  <label>{$attribute.contentclass_attribute.name}</label>
                  <div class="attribute-content">
                    {attribute_view_gui attribute=$attribute}
                  </div>
                  <div class="break"></div>
                </div>
              {/let}
              
              {let attribute=$node.data_map.suggestion}
                <div class="box">
                  <label>{$attribute.contentclass_attribute.name}</label>
                  <div class="attribute-content">
                    {attribute_view_gui attribute=$attribute}
                  </div>
                  <div class="break"></div>
                </div>
              {/let}
        <div class="content-action">
            <input type="submit" class="defaultbutton" name="ActionCollectInformation" value="{"Send form"|i18n("design/ezwebin/full/feedback_form")}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
        </div>
        </form>

    </div>
</div>