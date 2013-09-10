	<div id="main-position">
      <div id="main" class="float-break">
        <div class="overflow-fix">
		
		
		
		  {if eq(ezhttp( 'is_logged_in', 'cookie' ),true)}
			
			<!-- Select Courser What is active to pay-->
			
		
									{def $sourses2=  fetch('content','list',hash('parent_node_id',1414))}
								    {def $object_license=fetch( 'content', 'object', hash( 'object_id', 2091) )}
				
			<!-- License Agree--> 
			<form name="iagree" >
		
		
			
			
	  <fieldset>
			<legend>  Select course </legend>
			{foreach $sourses2 as $course}
			 {if eq($course.data_map.active.value,1)}
				<h3> <strong><input type="checkbox" class='selectedcourse'  value='{$course.data_map.info.contentobject_id}' rel="{$course.data_map.price.data_text}" alt="{$course.name}"> <a href='{$course.url_alias|ezurl('no')}'> {$course.name} </a>  </strong>  </h3>
			{/if}
			{/foreach}
			
	 
			
			
		</fieldset>
		
				<div id='igreetext'>   {$object_license.data_map.licanese_text.data_text}</div> 
			
			<input type='checkbox' id='iagree' /> I agree
			
			<br> 
			
			<br> 
			<a href='javascript:void(0)'  onclick="proceed()">  Proceed payment </a>
 			</form>
			
			{literal}
				<script type="text/javascript">
					function proceed(){
					 if(!jQuery("#iagree").attr("checked")){
						alert(" You mus agrre with terms "); 
						return false; 
					 }
					 var counter_selected = 0 ; 
					 var total = 0 ; 
					 var it = 1 ;
						// Next step foreach  
					jQuery(".selectedcourse").each(function(){
					
						if (this.checked){
							total =  parseFloat(jQuery(this).attr("rel"))  + total ;
							counter_selected++; 
							// Add item name 
							jQuery('<input>').attr({
								type: 'hidden',
								name: 'item_name_'+it,
								value: jQuery(this).attr("alt") + " course " 
							}).appendTo('#payPalForm');
							// add item number stuff 
							jQuery('<input>').attr({
								type: 'hidden',
								name: 'item_number_'+it,
								value: this.value
							}).appendTo('#payPalForm');
							// Else other paramter 
						 
						   jQuery('<input>').attr({
								type: 'hidden',
								name: 'amount_'+it,
								value:  parseFloat(jQuery(this).attr("rel"))
							}).appendTo('#payPalForm');
						 it++; 
						}
					});
					// if counter 
					if (counter_selected==0){
					alert(" Please select at least one course "); 
					}else{
					// Submit For 
				 		jQuery('#payPalForm').submit(); 
					}
					// And Finaly Submit payment Form 
					
			
					
					}
							
				</script> 
			{/literal}
			
				<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" id="payPalForm">
					<input type="hidden" name="cmd" value="_cart">
					<input type="hidden" name="upload" value="1">
					<input type="hidden" name="rm" value="2">
					<input type="hidden" name="business" value="pashko_1328368955_biz@gmail.com"/>
			 		<input type="hidden" name="currency_code" value="USD">
					<input type="hidden" name="no_shipping" value="1">
					<input type="hidden" name="cancel_return" value="http://u-sophia.com">
					<input type="hidden" name="return" value="http://u-sophia.com/Payment_Articles/Thank-you">
					<input type="submit" value="Buy Now" style='display:none;'>
			
				</form> 
			<!-- Proceed Paypal payment --> 
			{else}
			
			
				<h4>  Please login  </h4> 
			
			
			{/if}
		
		
		</div>
		</div>
		</div>