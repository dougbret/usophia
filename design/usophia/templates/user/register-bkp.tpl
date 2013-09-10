{* Registration *}

<div class="user-register">


  <h1>Register</h1>

  <form enctype="multipart/form-data"  action={"/user/register/"|ezurl} method="post" name="Register">
  
    <div class="attribute-short">
            {*{attribute_view_gui attribute=$node.data_map.description}*}
            <h2>Register</h2>
            <p>Please Enter Your Personal Information.</p>
    </div>
    {default attribute_base='ContentObjectAttribute'}

      {if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
          <div class="message-error">
              <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
          </div>
      {/if}

      {if $validation.processed}
      
          {if $validation.attributes|count|gt(0)}
              <div class="warning">
              <h2>{"Input did not validate"|i18n("design/ezwebin/user/register")}</h2>
              <ul>
              {foreach $validation.attributes as $attribute}
                  <li>{$attribute.name}: {$attribute.description}</li>
              {/foreach}
              </ul>
              </div>
          {else}
              <div class="feedback">
              <h2>{"Input was stored successfully"|i18n("design/ezwebin/user/register")}</h2>
              </div>
          {/if}
      
      {/if}
                           
      <div class="left">
        {let attribute=$object.data_map.first_name}
          <div class="box">
            <label>{$attribute.contentclass_attribute.name}</label>
            <div class="attribute-content">{attribute_edit_gui attribute=$attribute}</div>
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            <div class="break"></div>
          </div>
        {/let}
        {let attribute=$object.data_map.last_name}
          <div class="box">
            <label>{$attribute.contentclass_attribute.name}</label>
            <div class="attribute-content">{attribute_edit_gui attribute=$attribute}</div>
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            <div class="break"></div>
          </div>
        {/let}
        {let attribute=$object.data_map.user_account}
          {if ne( $attribute_base, 'ContentObjectAttribute' )}
              {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
          {else}
              {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
          {/if}
          <div class="box">
            <label>Username</label>
            <div class="attribute-content">
              {if $attribute.content.has_stored_login}
                  <input id="{$id_base}_login" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}_stored_login" size="16" value="{$attribute.content.login}" disabled="disabled" />
                  <input id="{$id_base}_login_hidden" type="hidden" name="{$attribute_base}_data_user_login_{$attribute.id}" value="{$attribute.content.login}" />
              {else}
                  <input id="{$id_base}_login" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}" size="16" value="{$attribute.content.login}" />
              {/if}
            </div>
            <div class="break"></div>
          </div>
          <div class="box">
            <label>Password</label>
            <div class="attribute-content"><input id="{$id_base}_password" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_{$attribute.id}" size="16" value="{if $attribute.content.original_password}{$attribute.content.original_password}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" /></div>
            <div class="break"></div>
          </div>
          <div class="box">
            <label>Confirm password</label>
            <div class="attribute-content"><input id="{$id_base}_password_confirm" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_confirm_{$attribute.id}" size="16" value="{if $attribute.content.original_password_confirm}{$attribute.content.original_password_confirm}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" /></div>
            <div class="break"></div>
          </div>
          <div class="box">
            <label>Email</label>
            <div class="attribute-content"><input id="{$id_base}_email" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_email_{$attribute.id}" size="28" value="{$attribute.content.email|wash( xhtml )}" /></div>
            <div class="break"></div>
          </div>
          <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {/let}
        
        {let attribute=$object.data_map.interests}
          <div class="box">
            <label>{$attribute.contentclass_attribute.name}</label>
            <div class="attribute-content">
            {let selected_id_array=$attribute.content}

                      <input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}" value="" />                  
                      {section var=Options loop=$attribute.class_content.options}
                        <label><input type="checkbox" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]" value="{$Options.item.id}" {if $selected_id_array|contains( $Options.item.id )}checked="checked"{/if} />{$Options.item.name|wash( xhtml )}</label>                  
                      {/section}
            {/let}
            </div>
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            <div class="break"></div>
          </div>
        {/let}

        {let attribute=$object.data_map.other_interests}
          <div class="box">
            <label>{$attribute.contentclass_attribute.name}</label>
            <div class="attribute-content">{attribute_edit_gui attribute=$attribute}</div>
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            <div class="break"></div>
          </div>
        {/let}

        
      </div>
      <div class="right">  
      
        {let attribute=$object.data_map.image}
          <div class="box">
            <label>{$attribute.contentclass_attribute.name}</label>
            <div class="attribute-content">{attribute_edit_gui attribute=$attribute}</div>
            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
            <div class="break"></div>
          </div>       
        {/let}
        
        {let attribute=$object.data_map.newsletter}
              <label>{attribute_edit_gui attribute=$attribute} {$attribute.contentclass_attribute.name}</label>
              <p>(We will never sell or trade your information. Our privacy policy can be found <a href={"/Footer-Articles/Privacy-Policy"|ezurl}>here</a>) </p>
        {/let}

        
        {let attribute=$object.data_map.captcha}
              {attribute_edit_gui attribute=$attribute}
        {/let}
        
        {if count($content_attributes)|gt(0)}
            <div class="buttonblock">
                 <input class="button" type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
            {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
                <input class="button" type="image" id="PublishButton" name="PublishButton" src={"images/register-but.png"|ezdesign} />
            {else}    
                <input class="button" type="image" id="PublishButton" name="PublishButton" disabled="disabled" src={"images/register-but.png"|ezdesign} />
            {/if}
            {*<input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />*}
            </div>
        {else}
            <div class="warning">
                 <h2>{"Unable to register new user"|i18n("design/ezwebin/user/register")}</h2>
            </div>
            <input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n('design/ezwebin/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
        {/if}

        
      </div>
      <div class="break"></div>

    
      {/default}
  </form>
      
</div>
