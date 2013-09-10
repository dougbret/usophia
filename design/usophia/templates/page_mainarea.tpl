 
	  {*if $module_result.node_id|ne(2)}
      {if eq($toolpa,1)|not}
        {include uri=concat('design:parts/', $pagedata.show_path, '.tpl')}
      {/if}  
    {/if*}  

	
	{if eq($module_result.content_info.object_id,  2079)}
		  {include uri='design:pay.tpl'}
	{else}
	<div id="main-position">
      <div id="main" class="float-break">
        <div class="overflow-fix">
          <!-- Main area content: START -->
          {$module_result.content}
          <!-- Main area content: END -->
        </div>
      </div>
    </div>
	{/if}
	
	
