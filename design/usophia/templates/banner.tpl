 <!-- Fetch Blocks f -->
 {def $banners =  fetch('content','list',hash('parent_node_id',1413,'limit',125))    }
 <!-- blocks rembl -->
	


	<link rel="stylesheet" href="/lightbox/pretty/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
	<script src="/lightbox/pretty/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
	
		
  {foreach $banners  as $ban} 
 		<!--   Banner Server  -->
	 
  		{if eq($ban.data_map.id_material.data_text,$module_result.content_info.object_id)}
  	 
  
  	<div id="ban6"   {if eq($module_result.content_info.object_id, 91)}  class='nomrag'{/if}   {if eq($module_result.content_info.object_id, 2023)}  class='nomrag'{/if} >
	<!-- Create Banner Stuff -->

	
	<div class='closer'> <a href='javascript:void(0)'   onclick="jQuery('#ban6').hide(); jQuery('#path').show().css('margin-top','40px');jQuery('#ban3').css('margin-top','10px');jQuery('.marjetsmall ').css('margin-top','20px !important;')"> Close</a>  </div>
	
		
	
	
		
		{if eq($ban.data_map.image.content["original"].url|ezroot,"/")}
		{else}	
		
		
		
			{if $ban.data_map.lbi.has_content} 
			<a href="{$ban.data_map.lbi.data_text}" {if $ban.data_map.lbi.data_text|contains("watch")}  rel="prettyPhoto" class='playvideo' {/if}  alt="U-Sophia" title="U-Sophia" ><img src={$ban.data_map.image.content["original"].url|ezroot} alt="" /></a>
			
		{else}	
		<img src={$ban.data_map.image.content["original"].url|ezroot} alt="" />
		
		{/if}	
		 
		{/if}
		 
		<div class='banner_stuff'>
		
		<h3> {$ban.data_map.header.data_text}  </h3>
		
			<h4> {$ban.data_map.header2.data_text}  </h4>
		
		
		
			 	<div class='bannerdesc2'>  {$ban.data_map.desc.data_text}  </div>
		
		
		{if eq($ban.data_map.videolink.data_text,"")}
		
				{if eq($ban.data_map.simplelink.data_text,"")}
				{else}
				<a    href='{$ban.data_map.simplelink.data_text}'  class='playvideo'   title="U-Sophia"  > 
				{$ban.data_map.link_text.data_text}
				</a>
		
				{/if}
		{else}
				
				
		
				 <a    href='{$ban.data_map.videolink.data_text}'  class='playvideo'  rel="prettyPhoto" title="U-Sophia"  > 	{$ban.data_map.link_text.data_text}
		</a>
			 
		
		
		
		{/if}


		
		</div>
				 	<div class='bannerdesc'>  {$ban.data_map.descunder.data_text}  </div>
		{literal}	
		<style type="text/css"> #path{  display:none; }  </style> 



		{/literal} 
		</div>
  
  
  
  
  
  
  
  
  
  
  
  
   
		{/if}
	 
 {/foreach}
 
 
		<script type="text/javascript">
		{literal}
			jQuery(document).ready(function(){
				jQuery("a[rel^='prettyPhoto']").prettyPhoto();
						 
			});
 		{/literal}
		</script>
 
 		