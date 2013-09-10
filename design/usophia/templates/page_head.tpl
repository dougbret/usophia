{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{*?template charset=latin1?*}
{default enable_help=true() enable_link=true()}

{let name=Path
     path=$module_result.path
     reverse_path=array()}
  {section show=is_set($module_result.title_path)}
    {set path=$module_result.title_path}
  {/section}
  {section loop=$:path}
    {set reverse_path=$:reverse_path|array_prepend($:item)}
  {/section}

{set-block scope=root variable=site_title}
{section loop=$Path:reverse_path}{$:item.text|wash}{delimiter} | {/delimiter}{/section} - {$site.title|wash}
{/set-block}

{/let}

    <title>{$site_title}</title>

    {section show=and(is_set($#Header:extra_data),is_array($#Header:extra_data))}
      {section name=ExtraData loop=$#Header:extra_data}
      {$:item}
      {/section}
    {/section}

    {* check if we need a http-equiv refresh *}
    {section show=$site.redirect}
    <meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />

    {/section}

    {section name=HTTP loop=$site.http_equiv}
    <meta http-equiv="{$HTTP:key|wash}" content="{$HTTP:item|wash}" />

    {/section}
{let object=fetch('content','object',hash('object_id', $module_result.content_info.object_id))
     metadata=fetch('metadata','get',hash('object_id',$object.id,'language',$object.default_language) )}
    {section name=meta loop=$site.meta}
      {if $metadata[$meta:key]}
          <meta name="{$meta:key|wash}" content="{$metadata[$meta:key]}" />
      {else}
          <meta name="{$meta:key|wash}" content="{$meta:item|wash}" />
      {/if}
    {/section}
{/let}



    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <meta name="generator" content="eZ Publish" />

{section show=$enable_link}
    {include uri="design:link.tpl" enable_help=$enable_help enable_link=$enable_link}
{/section}

{/default}





