{def $attribute=$object.data_map.video
     $width=$attribute.content.width
     $height=$attribute.content.height
     $flv=concat( 'video/flv/', $attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id )
     $preview=concat( 'video/preview/', $attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id )
     $player=ezini( 'FLVPlayer', 'File', 'ezvideoflv.ini' )
     $options=ezini( 'FLVPlayer', 'Options', 'ezvideoflv.ini' )
     $opt_string=''}
{if $attribute.has_content}
    {if $attribute.content.has_flv}
        {foreach $options as $key => $value}
            {set opt_string=concat( $opt_string, '&amp;', $key, '=', $value )}
        {/foreach}


    	{*<a href={$attribute.content.filepath_flv|ezroot} 
			 style="display:block;width:{$width}px;height:{$height}px"  
			 id="flowPlayerVideo-{$attribute.id}">
		</a>*}
<a href={$attribute.content.filepath_flv|ezroot} 
			 style="display:block;width:263px;height:163px"  
			 id="flowPlayerVideo-{$attribute.id}">
		</a>
		<script>
			flowplayer("flowPlayerVideo-{$attribute.id}", "/extension/ezflowplayer/design/standard/images/flowplayer-3.1.1.swf", 
{literal}
			{ 
			clip: { 
			autoPlay: false, 
			autoBuffering: true
			},
				plugins: {				
				}			});
		</script>
{/literal}



    {else}
    <p>{'FLV version not yet generated'|i18n( 'ezvideoflv/datatype' )}
    {/if}
    {*<p><a href={concat( "content/download/", $attribute.contentobject_id, "/", $attribute.content.contentobject_attribute_id, "/", $attribute.content.original_filename )|ezurl}>{'Download the original video file'|i18n( 'ezvideoflv/datatype' )}</a></p>*}
{else}
    <p>{'No file'|i18n( 'ezvideoflv/datatype' )}</p>
{/if}
{undef $width $height $flv $opt_string $options $player $preview}
