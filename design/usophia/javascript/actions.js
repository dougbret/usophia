$(document).ready(function() {
    /*if( $.cookie("amazon-country-code") ){
      $('#amazon-' + $.cookie("amazon-country-code") + '-content').show();
      $("#amazon-selector").hide();
    }*/
    $("#NewWikiPage").click(function(e) {
			e.preventDefault();			
			$('#NewWikiPageForm').submit();			
		});


     searchFormDefaults = new Array();
     searchFormDefaults["SearchText"] = "Keyword(s): (put exact phrase in double quotes)";
     searchFormDefaults["Title"] = "Title";
     searchFormDefaults["Author"] = "Author";
     searchFormDefaults["Subject"] = "Subject";
     searchFormDefaults["Publisher"] = "Publisher";
     searchFormDefaults["PublicationYearAfter"] = "After";
     searchFormDefaults["PublicationYearBefore"] = "Before";
     searchFormDefaults["PublicationYearExact"] = "Exact";

     if($("#library-search-form").length > 0 ) {
       $("#library-search-form input:text").focus(function() {
         this.value='';
       });
       $("#library-search-form input:text").blur(function() {
          if(this.value == '')
            this.value = searchFormDefaults[this.name];
       });
       $("#library-search-form").submit(function() {
         $("#library-search-form input:text").each(function() {  
           if(this.value == searchFormDefaults[this.name]) this.value = '';
         });
       });
     }
     
     
     
     salonFormDefaults = new Array();
     salonFormDefaults["ContentObjectAttribute_ezstring_data_text_3091"] = "Full Name";
     salonFormDefaults["ContentObjectAttribute_ezstring_data_text_3094"] = "Pertinence to U-Sophia";
     salonFormDefaults["ContentObjectAttribute_ezstring_data_text_3095"] = "Moderator";
     salonFormDefaults["ContentObjectAttribute_ezstring_data_text_3096"] = "Moderator";
     salonFormDefaults["ContentObjectAttribute_ezstring_data_text_3093"] = "Personal acquaintance";

     if($("#salon-suggest-form").length > 0 ) {
       $("#salon-suggest-form input:text").focus(function() {
         this.value='';
       });
       $("#salon-suggest-form input:text").blur(function() {
          if(this.value == '')
            this.value = salonFormDefaults[this.name];
       });
       $("#salon-suggest-form").submit(function() {
         $("#salon-suggest-form input:text").each(function() {  
           if(this.value == salonFormDefaults[this.name]) this.value = '';
         });
       });
     }

    /* $("#amazon-selector").change(function(e) {
      country_code = $(this).val();
      $('#amazon-' + country_code + '-content').show();
      $(this).hide();
      $.cookie("amazon-country-code", country_code ); 	
		});*/
		
    /*$("#tabs").tabs();*/
     
		$("#expanded_content").hide().addClass("hidden");
		$("#toggleMenu").live("click", function(e) {
			e.preventDefault();
			$('#expanded_content').html( $("#topmenu").html() );
			widthList = [];
      $("#topmenu").find("ul.menu-list>li").each(function(index) {
			 widthList.push( $(this).width() + 32);
      });

      $("#expanded_content").find("ul.menu-list>li").each(function(index) {
        $(this).width( widthList[index] );
      });
      

			$("#expanded_content").slideToggle();
			if ($("#expanded_content").hasClass("hidden")) {
				$("#expanded_content").addClass("visible").removeClass("hidden");
				$("#toggleMenu").html('Hide expanded menu');
			} else {
				$("#expanded_content").addClass("hidden").removeClass("visible");
				$("#toggleMenu").html('Show expanded menu');
			}
		});
    
    $('#art-center-select').change(function(){
      document.location = $(this).val();
    });
		/*$("ul.event-tabs li a").click(function(e) {
			e.preventDefault();
			
			$("div.eventlist").hide();
			$("#" + this.rel).show();
			
			$("ul.event-tabs li a").removeClass('selected');
			$(this).addClass('selected');
		});*/

	    $(document).ready(function() {
				
				$(".ac-see-all-body a").click(function(){
          if( $('.show-more-body').hasClass("up")) {
             $('.show-more-body').hide().slideDown();
             $('.show-more-body').removeClass("up");
             $('.show-more-body').addClass("down");
             $(this).html("Less");
          }else{
            $('.show-more-body').slideUp();
             $('.show-more-body').removeClass("down");
             $('.show-more-body').addClass("up");
             $('.show-more-body').addClass("up");
              $(this).html("More");
          }
          return false;
        });		

			$("a.lightbox").fancybox({
        width   : '650',
        height   : '400',
        fitToView   : true,
        width       : '70%',
        height      : '70%',
        autoSize    : true,
        closeClick  : false,
        openEffect  : 'none',
        closeEffect : 'none',
        autoDimensions: false,

			});			

			$("a.modalbox").fancybox({
				'autoScale'     	: true,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'hideOnContentClick': false,
/*				'type'				: 'iframe',*/
				'width'				: '600px',
				'height'			: '600px',
				'scrolling'   		: 'no',
				'onComplete': accordion
			});			
				
		});

		$("ol.faq-entries li a").click(function(e) {
			e.preventDefault();
			contentEl = $(this.parentNode).find('div');
      if( contentEl.hasClass('hide') ) {
			 contentEl.slideDown();
       contentEl.removeClass('hide')			 
      } else {
			 contentEl.slideUp();
       contentEl.addClass('hide')			 
      }                             

		});


    function accordion() {
      $("#accordion").accordion( );
      $('#accordion >div').css('height', '580');
    }

  ajaxizeLinks();
    	




/*
$f("audio", "http://releases.flowplayer.org/swf/flowplayer-3.2.7.swf", {

	// fullscreen button not needed here
	plugins: {
		controls: {
			fullscreen: false,
			height: 30,
			autoHide: false
		}
	},

	clip: {
		autoPlay: false,

		// optional: when playback starts close the first audio playback
		onBeforeBegin: function() {
			$f("player").close();
		}
	}

});
*/
  $("#item-player-click").click(function(){
    $("#play-info").hide().slideDown(); 
    
    player.os_load('my_stream_play');
  
  });
  $("#item-player-click-login").click(function(){
    $("#play-info").hide().slideDown(); 
  
  });



});

function ajaxizeLinks(container) {
    $("form.ajax").submit(function() {
  	  if( $(this).attr('rel') ) {
  	    var el = document.getElementById( $(this).attr('rel') ); 
      } else {
        var el = container;
      }
      
      $.post( $(this).attr('action'), $(this).serialize(),function(data) {  el.innerHTML = data; ajaxizeLinks();  } );
      return false;
    });

	$("a.ajax").click(function(){
	  if( $(this).attr('rel') ) {
	    var el = document.getElementById( $(this).attr('rel') ); 
    } else {
      var el = container;
    }

	  $.get( $(this).attr('href'), function(data) { var GMapOnLoad = false; el.innerHTML = data; ajaxizeLinks();  loadGmaps();   } );
	  return false;
	});
}


