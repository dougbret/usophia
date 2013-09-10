{* Slideshow banner for the Art center section *}

{def $banners =  fetch('content','list',hash('parent_node_id',$current_node.node_id,
                                            class_filter_type, include,
                                            class_filter_array, array('banner_art_center'),
                                            limit, 5,
                                            sort_by, array('priority', true())   
                                             ))
}

{if $banners|count}
  <div id="slideshow-container">
    <a id="slider-arrowleft"><img src={'slideshow-arrow-left.png'|ezimage}/></a>
    <div id="slideshow-images ">
      {foreach $banners as $item}
        {node_view_gui content_node=$item view=line_art_center}
      {/foreach}
    </div>
    <a id="slider-arrowright" ><img src={'slideshow-arrow-right.png'|ezimage}/></a>   
    <div id="nav" >
      <ul style="margin-left:400px">
          {foreach $banners as $index => $item}
            {if eq($index,0)}
            <script>
              var current_slide = 'slide-item-{$item.node_id}';
            </script> 
            {/if}
               <li>
                 <a class="slide-item-{$item.node_id}{if eq($index, 0)} active{/if}" href="#" onClick="goto1('#slide-item-{$item.node_id}', this);stop = 1; return false;">
                    {attribute_view_gui image_class=slider_art_center_thumb attribute=$item.data_map.background_image_thumb}
                 </a>
               </li>
          {/foreach}
       </ul> 
    
    </div>
  </div>

  {literal}
  <script type="text/javascript" src="http://cdn.octoshape.net/resources/player/infinitehd2/swfobject.js"></script>
  <script>
  $(function() {
    $("#slider-arrowright").click(function() {
      next_slide = $('#' + current_slide).next(".content-view-line");
      if(next_slide.length) {
        goto1('#' + next_slide.attr('id'), $('.' + next_slide.attr('id')));
        current_slide = next_slide.attr('id');
      }      
    
    });
    $("#slider-arrowleft").click(function() {
      prev_slide = $('#' +  current_slide).prev(".content-view-line");
      if (prev_slide.length) {
        goto1('#' + prev_slide.attr('id'), $('.' + prev_slide.attr('id')));
        current_slide = prev_slide.attr('id');
      }  
    
    });  
  });



  function goto1(id, t){
      //animate to the div id.
      $("#slideshow-images").animate({"left": -($(id).position().left)}, 975);
   
      // remove "active" class from all links inside #nav
      $('#nav a').removeClass('active');
   
      // add active class to the current link
      $(t).addClass('active');
   }

  var timer;
  var next_slide; 
  var prev_slide; 
  var stop =0; 
  function runem() {
      timer = setInterval(function() {
        if(!stop) {
         var next_slide = $('#' + current_slide).next(".content-view-line");
          if(next_slide.length && !stop) {
            goto1('#' + next_slide.attr('id'), $('.' + next_slide.attr('id')));
            current_slide = next_slide.attr('id');
          } else {
            
            
            var back_slide = $('#' + current_slide).parent().children(":first");
            goto1('#' + back_slide.attr('id'), $('.' + back_slide.attr('id')));
            current_slide = back_slide.attr('id');
            stop = 1;
          }   
        }
      }, 8000);
  }
  runem();

    

  </script>
  {/literal}


{/if}
 
 		