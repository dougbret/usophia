{let frontpage_node=fetch('content','node',hash('node_id',$module_result.path[1].node_id))}
    <div id="extrainfo-position">
      <div id="extrainfo">
        {switch match=$frontpage_node.node_id}  
        {case match=59}    

          <h1>Joining an on-line event is easy</h1>
          <div class=" " style="padding-bottom:6px">
		  	<img src='/design/base/images/play.jpg' id='hovervideo' />
		  	<div style='display:none'  id='playeshow'>
            {attribute_view_gui attribute=$frontpage_node.data_map.right_column_text}
			</div>
           </div> 

          <h1>Guests</h1>
           <div class="content">                                             
              {let  guests_node=fetch('content','node',hash('node_id',144))
                    guests=fetch( 'content', 'list', hash( 'parent_node_id', $guests_node.node_id,'limit',3,'sort_by',$guests_node.sort_array
                                                                          ))}
                {foreach $guests as $child}
                  <div class="box">
                    <img src={$child.data_map.image.content["small"].url|ezroot} alt="" />
                    <input type="button" value="Read More" class="clear-button" onclick="window.location={$child.url_alias|ezurl('single')}" />
<div class="break"></div>

                    <h4><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></h4>{* <a href={$child.url_alias|ezurl} class="readmore">Read More &gt;&gt;</a>*}
                  </div>
                {/foreach}
              {/let}
              <a href={"/Salon-Online/Guests/"|ezurl} class="seealllink">See all guests</a>
<div class="break"></div>
           </div>   

    
          {let series_node=fetch('content','node',hash('node_id',143))}
            <h1>{$series_node.name|wash}</h1>
            {let master_classes=fetch( 'content', 'list', hash( 'parent_node_id', $series_node.node_id,
                                                                        'sort_by', $series_node.sort_array,
										'class_filter_type','include',
										'class_filter_array',array('series')
                                                                        ))}
               <div class="content">                                          
                    {foreach $master_classes as $child}
                      <div class="box">  
                        <h4><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></h4> &nbsp;|&nbsp; {*{$child.data_map.short_description.content.output.output_text|strip_tags}*} <a href={$child.url_alias|ezurl} class="readmore">Read More &gt;&gt;</a>
                      </div>
                    {/foreach}   
               </div>                                                              
            {/let}
          {/let}                                                             
          

        {/case}
        {case match=188}
          <h1>Entry of the week</h1>
           <div class="content">
           {let featured=$frontpage_node.data_map.featured.content}
            <h2>{$featured.name}</h2>
            {attribute_view_gui attribute=$featured.data_map.file}
           {/let}                
           </div>  
          <h1>Coming soon to the library:</h1>
           <div class="content">     
            {attribute_view_gui attribute=$frontpage_node.data_map.right_column_text}           

           </div>  
    
	{let content_node=fetch('content','node',hash('node_id',294))}
          <h1>{$content_node.name|wash}</h1>
             <div class="content" id="inline-form-content">
{node_view_gui content_node=$content_node view="full"}            
             </div>
	{/let}

          {include uri="design:amazon.tpl"}          
        {/case}
        {case match=64}  
          <h1>In the news:</h1>
           <div class="content">     
            {attribute_view_gui attribute=$frontpage_node.data_map.right_column_text}
           </div>  
          <h1>Latest entries:</h1>
           <div class="content">
            {let latest=fetch( 'content', 'list', hash( 'parent_node_id', 64,
                                                                        'sort_by', array('published', false() ),
                                                                        'limit',10
                                                                        ))}
              <ul>                                              
                {foreach $latest as $child}
                  <li><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></li>
                {/foreach}
              </ul>                                                                            
            {/let}     
           </div> 
        {/case}
        {case match=65}
          <h1>From the editors table</h1>
           <div class="content">         
            {attribute_view_gui attribute=$frontpage_node.data_map.right_column_text}       
  
           </div>   
          <h1>Most viewed</h1>
           <div class="content">                
              {def $popular_nodes=fetch( 'content', 'view_top_list',
                                         hash( 'class_id',  50,
                                               'limit',    5,
                                               'offset',    0 ) )}
                                               
              {foreach $popular_nodes as $child}
                <h3>{$child.parent.name}</h3>
                <p><a href={$child.url_alias|ezurl}>{$child.name}</a> by {$child.object.owner.name} ({$child.view_count} views)</p>
              {/foreach}
           </div>   
          <h1>Statistics</h1>
           <div class="content">                


        {def
        $classes =array('art')
        $contributors=array()}
        
          {foreach fetch( 'content','tree', hash( 'parent_node_id', 65,
                'offset', $view_parameters.offset,
                'sort_by', array('name',true() ),
                'class_filter_type', 'include',
                'class_filter_array', $classes,
                'limit', $page_limit ) ) as $child }
           {set $contributors=$contributors|append($child.object.owner.name)}
          {/foreach}
          {set $contributors=$contributors|unique($contributors)}
		<ul>
          		<li>Contributors: {$contributors|count}</li>
          		<li>Online users: {fetch( 'user', 'logged_in_count' )}</li>
           </div>   
        {/case}     
        {case match=663}
		{if $module_result.path[2].node_id|eq(665)} {* MARKETPLACE *}
			{if $module_result.path[3].node_id|eq(1047)} {* BOUTIQUE *}



			   {let $boutique_node=fetch('content','node',hash('node_id',$module_result.path[4].node_id))}

<h1>My Showcase</h1>

{foreach $boutique_node.children as $child}
  {node_view_gui content_node=$child view="line"}
{/foreach}


		          <h1>Favorite U-Sophia Boutique</h1>
       		   <div class="content" style="padding-bottom:6px;">
				{let favorite_boutique=$boutique_node.data_map.favorite_boutique.content.main_node}
					<h2><a href={$favorite_boutique.url_alias|ezurl}>{$favorite_boutique.name}</a></h2>
                    <img src={$favorite_boutique.data_map.image.content["small"].url|ezroot} style="float:left;padding-right:5px;" alt="" />
			{$favorite_boutique.data_map.description.content.output.output_text|strip_tags|shorten(100)} 
				<div class="break"></div>
				{/let}
		          </div> 


		          <h1>Meet me at U-Sophia</h1>
       		   <div class="content" style="padding-bottom:6px;{*background:none;*}">
				<br /><br /><br /><br />
		          </div> 
			   {/let}



			{else}
				{let marketplace_node=fetch('content','node',hash('node_id',$module_result.node_id))}
		          <h1>{$marketplace_node.data_map.right_column_section_name_1.content}</h1>
       		   <div class="content" style="padding-bottom:6px;background:none;">
				<br /><br /><br /><br />
		          </div> 
	       	   <h1>Write a review	</h1>
	       	   <div class="content" style="padding-bottom:6px;background:none;">
			<br /><br /><br /><br />
	       	   </div> 
	       	   <div class="content" style="padding-bottom:6px;">
				<a href="#">{$marketplace_node.data_map.right_column_section_name_2.content}</a><br />
			{*		<a href="#">Email The Books' Market</a>*}
			<br /><br /><br /><br />
		          </div> 
				{/let}
			{/if}
		{else}

           {let root_node=fetch('content','node',hash('node_id',663))}
          <h1>Markets</h1>
          <div class="content marketplace" style="padding-bottom:6px">
		<ul>
            {foreach fetch('content','list',hash('parent_node_id',665)) as $child}
			{if $child.node_id|ne(1047)}
				<li><input class="clear-button blue-bg" type="button" onclick="window.location='{$child.url_alias|ezurl('no')}';" value="{$child.name}" name="NewButton"></li>
			{/if}
            {/foreach}
		</ul>
          </div> 

          <h1>Personal Boutiques</h1>
           <div class="content">                                             
              {let  guests_node=fetch('content','node',hash('node_id',144))
                    guests=fetch( 'content', 'list', hash( 'parent_node_id', $guests_node.node_id,'limit',3,'sort_by',$guests_node.sort_array
                                                                          ))}
                {foreach $guests as $child}
                  <div class="box">
                    <h4><a href={$child.url_alias|ezurl}>{$child.name|wash}'s Boutique</a></h4>{* <a href={$child.url_alias|ezurl} class="readmore">Read More &gt;&gt;</a>*}
                    <img src={$child.data_map.image.content["medium"].url|ezroot} alt="" />
                    <input type="button" value="Enter here" class="clear-button" onclick="window.location={$child.url_alias|ezurl('single')}" />
			<div class="break"></div>

                  </div>
                {/foreach}
              {/let}
              <a href={"/Salon-Online/Guests/"|ezurl} class="seealllink">See all guests</a>
<div class="break"></div>
           </div>   



          <h1>Amazon's Specials</h1>
          <div class="w100p" style="padding-bottom:6px">
            {$root_node.data_map.amazon_code.content}
          </div> 


          {/let}

	   {/if}
        {/case}   
        {case}

          {*let donate_node=fetch('content','node',hash('node_id',106))}
            <h1>{$donate_node.name|wash}</h1>
               <div class="content donate">                
                  <ul>                       
                   <li><input class="clear-button blue-bg" type="submit"  name="NewButton" value="Donate" onclick="window.location={"/Help-keep-U-Sophia-free/Donate-to-U-Sophia"|ezurl('single')};" /> </li>	                      
                   <li><a href="/Help-keep-U-Sophia-free/Donors-FAQ" target="_blank">Donors' FAQ</a></li>

                  </ul>
               </div>
          {/let}     

		{if $current_user.is_logged_in}

		<h1>My U-Sophia</h1>
		<div class="content myusophia"> 
			{attribute_view_gui attribute=$current_user.contentobject.data_map.image image_class="small"}
			<h2>{$current_user.contentobject.name}</h2>
			<div class="break"></div>
			<ul> 
				<li><a href={"/Profile/"|ezurl}>My Uploaded Works</a></li>
				<li class="last"><a href={concat("/content/edit/", $current_user.contentobject_id, "/")|ezurl}>My Preferences</a></li>
			</ul>
		</div>                                                         

		{/if}

          
          {let root_node=fetch('content','node',hash('node_id',2))
               person_node=fetch('content','node',hash('node_id',104))}
          <h1>Share your knowledge and insight</h1>
          <div class="content" style="padding-bottom:6px">
            {attribute_view_gui attribute=$root_node.data_map.right_column_text}

          </div> 

          <h1>Share your creativity and your thoughts</h1>
          <div class="content" style="padding-bottom:6px">
            {attribute_view_gui attribute=$root_node.data_map.right_column_text_2}
          </div> 

          <h1>Find out more about our guests</h1>
          <div class="content" style="padding-bottom:6px">
            {attribute_view_gui attribute=$root_node.data_map.right_column_text_3}
          </div> 
         

   
<br />


          {/let*}
          
{def $article-blocks = fetch(content,list,hash(parent_node_id, 2,
                                    class_filter_type, include,
                                    class_filter_array, array('article_block'),
                                              sort_by, array('priority', true())
                                              ))
  $object = false()                                              
}
{if $article-blocks|count}
<div id="right-sidebar">
{let donate_node=fetch('content','node',hash('node_id',106))}
<div class="article-block">
  <h2>{$donate_node.name|wash}</h1>
  <div class="content donate article-block-content">                
      <ul>                       
       <li><input class="clear-button blue-bg" type="submit"  name="NewButton" value="Donate" onclick="window.location={"/Help-keep-U-Sophia-free/Donate-to-U-Sophia"|ezurl('single')};" /> </li>	                      
       <li><a href="/Help-keep-U-Sophia-free/Donors-FAQ" target="_blank">Donors' FAQ</a></li>

      </ul>
  </div>
</div>
{/let}  

{foreach $article-blocks as $block}
  <div class="article-block">
     <h2>{$block.name}</h2>
    <div class="article-block-content" style="background:{$block.data_map.background_color.content}">
    {if $block.data_map.article_relation.has_content}
      {set $object = fetch( content, object, hash( object_id, $block.data_map.article_relation.content.relation_list.0.contentobject_id))} 
       
       <div class="class-article float-break">

          <div class="attribute-image">
            {section show=$object.main_node.data_map.image.has_content}
                {attribute_view_gui image_class=articlethumbnail href=$object.main_node.url_alias|ezurl attribute=$object.main_node.data_map.image}
            {/section}            
          </div>

          <div class="right">
           
            
            {if $object.main_node.data_map.intro.content.is_empty|not}
              <div class="attribute-short">
                  {$object.main_node.data_map.intro.content.output.output_text|strip_tags|shorten(180)}
              </div>                                     
            {else}
              <div class="attribute-short">
                  {$object.main_node.data_map.body.content.output.output_text|strip_tags|shorten(180)}
              </div>                                     
            {/if}
                  
            <a class="block-more-color" href={$object.main_node.url_alias|ezurl}>More &gt;&gt;</a>
          </div>
          

          </div>
    {/if}  
    </div>
  </div>
{/foreach}  
</div>
{/if}
          

          {/case}
        {/switch}   
      </div>
    </div>