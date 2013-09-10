{* Banner Art Center - Line Art Center View *}
{def $edit = fetch( 'content', 'access',
                  hash( 'access', 'edit',
                        'contentobject', $node ) )}

<div class="content-view-line" id="slide-item-{$node.node_id}">
  {if $edit}
  <div class="edit-link"><a href="/content/edit/{$node.object.id}">Edit</a></div>
  {/if}
  {if $node.data_map.template.content.0|gt(0)}
    <div class="banner-image art-center-banner-line" style="background:url({$node.data_map.background_image.content['banner_art_center_short'].url|ezroot(no)}) no-repeat right 0; color:{$node.data_map.text_color.content}">
  {else}
    <div class="banner-image art-center-banner-line" style="background:url({$node.data_map.background_image.content['banner_art_center'].url|ezroot(no)}) no-repeat right 0; color:{$node.data_map.text_color.content}">
  {/if}
  
    {if $node.data_map.template.content.0|eq(1)}
      <div class="banner-line-content" style="background:url('{'banner-red.png'|ezimage(no)}') no-repeat;width: 327px">
    {elseif $node.data_map.template.content.0|eq(2)}
      <div class="banner-line-content" style="background:url('{'banner-blue.png'|ezimage(no)}') no-repeat;width: 327px">
    {elseif $node.data_map.template.content.0|eq(3)}
      <div class="banner-line-content" style="background:url('{'banner-gold.png'|ezimage(no)}') no-repeat;width: 327px">
    {else}
      <div class="banner-line-content">
    {/if}
      <div class="banner-content">
        
        <div class="banner-info">
          {if $node.data_map.logo.content.is_empty|not}
            <div class="banner-logo">{attribute_view_gui image_class=art_center_thumb href=$node.url_alias|ezurl attribute=$node.data_map.logo}</div>
          {/if}
          <div class="line-banner-title">{$node.name|wash()}</div>
          
          <div class="banner-info-container">
            {if $node.data_map.subtitle.content.is_empty|not}
            <div class="line-content-subtitle" >{attribute_view_gui attribute=$node.data_map.subtitle}</div>
            {/if} 
            {if $node.data_map.description.content.is_empty|not}
            <div class="line-content-summary" style="padding-top:7px;">{$node.data_map.description.content|strip_tags|shorten(200)}</div>
            {/if}
          </div>
        </div>
        {if $node.data_map.learn_more_link.has_content}
          <div class="line-banner-learn-more"><a href="{$node.data_map.learn_more_link.content}" target="_blank" >{$node.data_map.learn_more_button_text.content}</a></div>
        {/if}
        
        {if $node.data_map.video_button_link.has_content}
        
        <div class="video-container">
          <div class="line-banner-video" id="player-link-{$node.node_id}"><a href="#"  class="inline" >{$node.data_map.video_button_text.content}</a></div>
          <div style="display:none">
          <div class="content-player-container">
            
            {literal}
            <script type="text/javascript">
             
              
               // $("#player-link-{/literal}{$node.node_id}{literal} a").click(function(e) {
               // var video = $(this).parent().parent().find('.content-player').html();
                //e.preventDefault();
                

                $("#player-link-{/literal}{$node.node_id}{literal} a").fancybox(
                  {
                        'content':'<div id="player" style="width:450px;height:320px"></div>',

                          width   : 650,
                          height   : 400,
                          fitToView   : false,
                          width       : '70%',
                          height      : '70%',
                          autoSize    : false,
                          closeClick  : false,
                          openEffect  : 'none',
                          closeEffect : 'none',
                          onComplete: function() {
                              window.player_id = "player";
                              window.player_width = 600;
                              window.player_height = 377;
                              window.player_stream = 'my_stream';
                              window.player_streams = [{
                                id: 'my_stream',
                                stream: '{/literal}{$node.data_map.video_button_link.content}{literal}',
                                //eventStart: (new Date().getTime() - (60*15*1000))
                              }];
                              window.player_scalingMode = null;
                              window.player_controlsPlacement = null;
                              window.player_language = null;
                              window.player_backgroundImage = null;

                              var params = {allowFullScreen: true, scale: 'noscale', allowScriptAccess: 'always'};
                              var attributes = {id: player_id, name: player_id};
                              swfobject.embedSWF(document.location.protocol+'//d2iwzbhgddzdwl.cloudfront.net/resources/player/infinitehd2/player.swf', player_id, player_width, player_height, "10.2.0", null, null, params, attributes);

                              
                          },
                  }
                );
                
              /*  return false;
              });*/
              
              
            </script>
            {/literal}  
            
          </div>
          
          </div>
        </div>
        {/if}
      </div>
    </div>
  </div>
</div>