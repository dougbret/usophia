{def $siteurl=concat( "http://", ezini( 'SiteSettings', 'SiteURL' ) ) 
     $attribute=$object.data_map.file
     $video=concat( "content/download/",$attribute_file.contentobject_id,"/", $attribute_file.content.contentobject_attribute_id )|ezurl(no)
     $flash_var=concat( "moviepath=", $video )}

    	<a
    		 href={$attribute.content.filepath|ezroot} 
			 style="display:block;width:{$attribute.content.width}px;height:{$attribute.content.height}px"  
			 id="flowPlayerVideo-{$attribute.id}">
		</a>
		<script>
			flowplayer("flowPlayerVideo-{$attribute.id}", "{'images/flowplayer-3.1.1.swf'|ezdesign(no)}", 
			{ldelim} 
			clip: {ldelim} 
			autoPlay:{if $attribute.content.is_autoplay} true,{else} false,{/if} 
			autoBuffering: true
			{rdelim},
				plugins: {ldelim}
				{*{if eq($attribute.content.has_controller, 1)|not}controls: null{/if}*}
				{rdelim}
			{rdelim});
		</script>