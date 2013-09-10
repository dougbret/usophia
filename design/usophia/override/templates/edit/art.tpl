<form name="editform" id="editform" enctype="multipart/form-data" method="post" action={concat( '/content/edit/', $object.id, '/', $edit_version, '/', $edit_language|not|choose( concat( $edit_language, '/' ), '/' ), $is_translating_content|not|choose( concat( $from_language, '/' ), '' ) )|ezurl}>

{include uri='design:parts/website_toolbar_edit.tpl'}


<div class="content-edit">

{* Current gui locale, to be used for class [attribute] name & description fields *}
{def $content_language = ezini( 'RegionalSettings', 'Locale' )}

        <h1 class="long">{'Edit <%object_name> (%class_name)'|i18n( 'design/ezwebin/content/edit', , hash( '%object_name', $object.name, '%class_name', first_set( $class.nameList[$content_language], $class.name ) ) )|wash}</h1>

    {include uri='design:content/edit_validation.tpl'}

    {if $is_translating_content}
    <div class="content-translation">
    {/if}

    <div class="context-attributes">
	{if or( $object.current.main_parent_node_id|eq(69), $object.current.main_parent_node_id|eq(68) )}
  {let attribute=$object.data_map.name}
    <div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute.contentclass_attribute_identifier}">
        <label{if $attribute.has_validation_error} class="validation-error"{/if}>{$attribute.contentclass_attribute.name|wash}</label><div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}
    </div>
  {/let}

  {let attribute=$object.data_map.author}
    <div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute.contentclass_attribute_identifier}">
        <label{if $attribute.has_validation_error} class="validation-error"{/if}>{$attribute.contentclass_attribute.name|wash}</label><div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}
    </div>
  {/let}

  {let attribute=$object.data_map.description}
    <div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute.contentclass_attribute_identifier}">
        <label{if $attribute.has_validation_error} class="validation-error"{/if}>Type or copy and paste your text here</label><div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}
    </div>
  {/let}

  {let attribute=$object.data_map.image}
    <div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute.contentclass_attribute_identifier}">
        <label{if $attribute.has_validation_error} class="validation-error"{/if}>{$attribute.contentclass_attribute.name|wash}</label><div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}
    </div>
  {/let}

  {let attribute=$object.data_map.rating}
    <div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute.contentclass_attribute_identifier}">
        <label{if $attribute.has_validation_error} class="validation-error"{/if}>{$attribute.contentclass_attribute.name|wash}</label><div class="labelbreak"></div>
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}
    </div>
  {/let}
{else}
    {include uri='design:content/edit_attribute.tpl' view_parameters=$view_parameters}

{/if}








    </div>

    {if $is_translating_content}
    </div>
    {/if}

    <div class="buttonblock">
    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/ezwebin/content/edit' )}" />
    <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/ezwebin/content/edit' )}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/ezwebin/content/edit' )}" />
    <input type="hidden" name="DiscardConfirm" value="0" />
    <input type="hidden" name="RedirectIfDiscarded" value="{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}{ezhttp( 'LastAccessesURI', 'session' )}{/if}" />
    <input type="hidden" name="RedirectURIAfterPublish" value="{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}{ezhttp( 'LastAccessesURI', 'session' )}{/if}" />
    </div>
</div>


</form>