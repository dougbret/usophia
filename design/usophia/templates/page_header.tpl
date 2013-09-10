  <div id="header-position">
  <div id="header" class="float-break">

    <div id="logo">
        <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')|wash}"><img src={"images/logo.png"|ezdesign} alt="" width="200" height="51" /></a>
    </div>

{switch match=$module_result.path[1].node_id}
  {case match=59}
      <div id="page-name" class="salon">
       <img src={"images/salon_logo.png"|ezdesign} alt="Salon Online" />
      </div>
  {/case}
  {case match=106}
      <div id="page-name" class="donate">
       <img src={"images/donate_logo.png"|ezdesign} alt="Donate" />
      </div>
  {/case}
  {case match=663}
      <div id="page-name" class="marketplace">
       <img src={"images/marketplace_logo.png"|ezdesign} alt="Marketplace" />
      </div>
  {/case}
  {case match=188}
      <div id="page-name" class="library">
       <img src={"images/library_logo.png"|ezdesign} alt="Library" />
      </div>
  {/case}
  {case match=65}
      <div id="page-name" class="life">
       <img src={"images/life_logo.png"|ezdesign} alt="Life" />
      </div>
  {/case}
  {case match=74}
      <div id="page-name" class="aboutus">
       <img src={"images/aboutus_logo.png"|ezdesign} alt="About Us" />
      </div>
  {/case}
  {case match=413}
      <div id="page-name" class="wikisophia">
       <img src={"images/wikisophia_logo.png"|ezdesign} alt="WikiSophia" />
      </div>
  {/case}

  {case match=1869}
      <div id="page-name" class="wikisophia artcenter-wording-image">
       <img src={"images/Art-Center-Header.png"|ezdesign} alt="WikiSophia" />
      </div>
  {/case}
{/switch} 
    <img id="beyond" src={"images/beyond.png"|ezdesign} alt="" width="283" height="11"  {if $module_result.path[1].node_id|eq(1869)}class="artcenter-header"{/if} />
    
   {* {if $module_result.path[1].node_id}
      <div id="page-name">
          {let path1node=fetch('content','node',hash('node_id',$module_result.path[1].node_id ))}
            <h1><a href={"/"|ezurl}>{ezstr_replace('U-Sophia','<br />U-Sophia',$path1node.name)}</a></h1>
          {/let}
      </div>
    {/if}*}
    <div style="width:270px;float:right;margin-top:10px;" {if $module_result.path[1].node_id|eq(1869)}class="artcenter-header-search"{/if}>
      <div id="searchbox">
        <form action={"/content/search"|ezurl}>
          <label for="searchtext" class="hide">{'Search text:'|i18n('design/ezwebin/pagelayout')}</label>
          {if $pagedata.is_edit}
          <input id="searchtext" name="SearchText" type="text" value="" size="12" disabled="disabled" />
          <input id="searchbutton" class="button-disabled" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" disabled="disabled" />
          {else}
          <input id="searchtext" name="SearchText" type="text" value="" size="12" />
          <input id="searchbutton" class="button" type="submit" value="&nbsp;" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" />
              {if eq( $ui_context, 'browse' )}
               <input name="Mode" type="hidden" value="browse" />
              {/if}
          {/if}
        </form>
      </div>
      <ul id="account-info">
        <li>{if $current_user.is_logged_in}<a href={"/user/logout"|ezurl}>Logout</a>{else}<a href={concat("/user/login/?redirect=",$module_result.uri)|ezurl}>Log-in</a>{/if}</li>
      {if $current_user.is_logged_in}
        <li class="my-usophia"><a href={"/user/edit"|ezurl}>My U-Sophia</a></li>
	{else}
      <li ><a href={"/user/register"|ezurl}>Register</a></li>
	{/if}
  {if $current_user.is_logged_in}
      <li class="last"><a href={"/shop/basket"|ezurl}><img src={"cart.png"|ezimage} /></a></li>
  {else}
     <li class="last"><a href={"/user/login"|ezurl}><img src={"cart.png"|ezimage} /></a></li>
  {/if}  

      {if $current_user.is_logged_in}
        <li class="welcome-text">Welcome back, {$current_user.contentobject.data_map.first_name.content} </li>
      {/if}
      </ul>
</div>

  {*  <ul id="header-links">
    {let header_links=fetch('content','list',hash('parent_node_id',88,sort_by,array( 'priority',true() ) ))}
        {foreach $header_links as $index => $child}
          {if eq( $child.class_identifier, 'link')}
            <li {if $header_links|count|eq( $index|inc )}class="last"{/if}><a href={$child.data_map.location.content|ezurl} class="{$child.class_identifier}">{$child.name|wash}</a></li>
          {else}
            <li {if $header_links|count|eq( $index|inc )}class="last"{/if}><a href={concat('layout/set/popup/',$child.url_alias)|ezurl} class="modalbox {$child.class_identifier}">{$child.name|wash}</a></li>
          {/if}
        {/foreach}
    {/let}
    </ul>
*}    
    <div class="break"></div>
        
{*    <div id="motto">
      <div class="left">beyond knowledge</div>
      <div class="right">beyond the obvious</div>
    </div>
*}    

    <p class="hide"><a href="#main">{'Skip to main content'|i18n('design/ezwebin/pagelayout')}</a></p>
  </div>
  </div>
  
  
