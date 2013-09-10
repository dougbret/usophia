{set-block scope=global variable=cache_ttl}0{/set-block}

<div class="content-view-full">
    <div class="class-salon">
    {*
      <h1>{$node.name|wash}</h1>

        {if $node.object.data_map.text.has_content}
            <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.text}
            </div>
            <div class="break"></div>
        {/if}                                                             
  *}

{def $tmp=logCurrentUser()}

{if $view_parameters.page}
<iframe src="/mediawiki/index.php/{$view_parameters.page}" width="976" height="1000" />
{elseif ezhttp('SearchText','get')}
<iframe src="/mediawiki/index.php?title=Special%3ASearch&redirs=0&search={ezhttp('SearchText','get')}&fulltext=Search&ns0=1" width="976" height="1000" />
{else}
<iframe src="/mediawiki/index.php/Main_Page" width="976" height="1000" />
{/if}
    </div>
</div>