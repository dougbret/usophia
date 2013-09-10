{* Donation form - Full view *}
{def  $contribute = false()
}


<div class="content-view-full">
    <div class="class-donation-form">         

        <h1>{$node.name|wash()}</h1>
{*	 {if eq($node.name|wash(), 'U-Sophia is an Art democracy')}  *}
           {set $contribute = true()}
{*        </if>   *}

        <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
          <input type="hidden" name="cmd" value="_s-xclick">
          <input type="hidden" name="hosted_button_id" value="TYC6EZQYA6NLG">
          <input type="image" src="http://u-sophia.com/extension/usophia/design/usophia/images/donate.png" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
          <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
        </form>


        <form method="post" action={"content/action"|ezurl}>
       
          <div class="attribute-short">
                  {attribute_view_gui attribute=$node.data_map.description}
          </div>
          {default attribute_base='ContentObjectAttribute'}
   
            {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                     class='message-warning'
                     validation=$validation collection_attributes=$collection_attributes}
                     
            <div class="left">

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
            </div>
{*            <div class="right">
                   
            <div class="buttonblock">
			<input class="clear-button donate" type="submit" name="ActionCollectInformation" value="Donate"  />
                  <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                  <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                  <input type="hidden" name="ViewMode" value="full" />
              </div>
 
     
            </div>
*}
            {/default}
        </form>

                 
       
    </div>
</div>