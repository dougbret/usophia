{* Override string configuration *}
{default attribute_base='ContentObjectAttribute'
         html_class='full'}
         
{def $user =  fetch( 'user', 'current_user' )
  $player_channels = array()   
} 
{if ezini_hasvariable( concat('Channel_user_', $user.contentobject_id), 'Channel', 'usophia.ini' )}
  {set $player_channels =  $player_channels|merge(ezini( concat('Channel_user_', $user.contentobject_id), 'Channel', 'usophia.ini' ))}
{/if}

{foreach $user.role_id_list as $role_id}
  {if ezini_hasvariable( concat('Channel_user_role_', $role_id), 'Channel', 'usophia.ini' )}
    {set $player_channels =  $player_channels|merge( ezini( concat('Channel_user_role_', $role_id), 'Channel', 'usophia.ini' ))}
  {/if}

{/foreach}
    
{set $player_channels =  $player_channels|unique} 
{if $player_channels|count}   

<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="{eq( $html_class, 'half' )|choose( 'box', 'halfbox' )} ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_ezstring_data_text_{$attribute.id}">
 <option value="">Select a Channel</option>
{foreach $player_channels as $channel}
  <option {if eq($channel, $attribute.data_text)}selected="selected"{/if} value="{$channel}">{$channel}</option>

{/foreach}

</select>
{else}
  <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="{eq( $html_class, 'half' )|choose( 'box', 'halfbox' )} ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezstring_data_text_{$attribute.id}" value="{$attribute.data_text|wash( xhtml )}" />
{/if}

{/default}

