  
  
 
 
  <div id="path">
   <!-- <a id="toggleMenu" href="#">Show expanded menu</a>-->
<!--
<div class="socials">




 
	

	{literal}
<span id='plusone'>
<g:plusone annotation="inline" size="medium"></g:plusone>
</span>
<script type="text/javascript">
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
{/literal}
	<a href="http://www.facebook.com/pages/U-Sophia-the-conversational-salon-online/105124429533293" target="_blank"><img src="http://www.cztour.cz/i/facebook-icon.jpg" /> Befriend us on Facebook</a>
 
</div>
-->

    {if $module_result.node_id|ne(2)}
      {include uri=concat('design:parts/', $pagedata.show_path, '.tpl')}
	  {set toolpa=1}
    {/if}  


  </div>