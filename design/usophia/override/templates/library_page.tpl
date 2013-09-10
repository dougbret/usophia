{set-block scope=global variable=cache_ttl}0{/set-block}
<div class="content-view-full">
    <div class="class-salon">
    {switch match=$view_parameters.show}  
      {case match='categories'}
            <div class="content-view-children">
                {let categories=fetch('content','list',hash('parent_node_id',188,class_filter_type,'include',class_filter_array,array('folder')))}
                  {foreach $categories as $child}
                      {node_view_gui view='line' content_node=$child}
                  {/foreach}
                {/let}
            </div>
      {/case}    
      {case match='all'}
            <h1>{$node.name|wash}</h1>
            {def $page_limit = 10
                 $classes =array('folder')
                 $children = array()
                 $children_count = ''}
                 
            {set $children_count=fetch( 'content', 'tree_count', hash( 'parent_node_id', $node.node_id,
                                                                      'class_filter_type', 'exclude',
                                                                      'class_filter_array', $classes ) )}
       
            <div class="content-view-children">
                    {foreach fetch( 'content','tree', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array('name',true() ),
                                                            'class_filter_type', 'exclude',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) ) as $child }
 			{node_view_gui content_node=$child view="line"}
                    {/foreach}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

      {/case} 
      {case match='article'}    
          <h1>{$node.name|wash}</h1>

            <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.text}
            </div>
              <a href="#" class="more-link">Back to top&gt;&gt;</a><a href="/" class="more-link" onclick="history.go(-1); return false;">&lt;&lt;Back</a><a href="/" class="more-link-top" onclick="history.go(-1); return false;">&lt;&lt;Back</a>
      {/case}              
      {case match='search'}
          <h1>Advanced Search</h1>      
        {if ezhttp('submit')|is_set}
          {let search_results=array()
               search_count=0
               page_limit=20
               filters=array()}
          
          {if ezhttp('Title')}
            {set $filters=$filters|append( concat( 'library_item/name:', ezhttp('Title') ) )}
          {/if}    
          {if ezhttp('Author')}
            {set $filters=$filters|append( concat( 'library_item/author:', ezhttp('Author') ) )}
          {/if}    
          {if ezhttp('Subject')}
            {set $filters=$filters|append( concat( 'library_item/subject:', ezhttp('Subject') ) )}
          {/if}
          {if ezhttp('Publisher')}
            {set $filters=$filters|append( concat( 'library_item/publisher:', ezhttp('Publisher') ) )}
          {/if}    
          {if ezhttp('PublicationYearAfter')}
            {set $filters=$filters|append( concat( 'library_item/publication_year:[', ezhttp('PublicationYearAfter'), ' TO 2020]' ) )}
          {/if}    
          {if ezhttp('PublicationYearBefore')}
            {set $filters=$filters|append( concat( 'library_item/publication_year:[-10000 TO ', ezhttp('PublicationYearBefore'), ']' ) )}
          {/if}    
          {if ezhttp('PublicationYearExact')}
            {set $filters=$filters|append( concat( 'library_item/publication_year:', ezhttp('PublicationYearExact') ) )}
          {/if}    
          {if ezhttp('MediaTypes')}
            {let optionsText=ezhttp('MediaTypes')|implode(' OR ')}
              {set $filters=$filters|append( concat( 'library_item/type:(',$optionsText, ')'  ) )}
            {/let}
          {/if} 
          
                                                    
          {set $search_results=fetch( ezfind, search,
                                      hash( query, ezhttp('SearchText'),
                                            subtree_array, ezhttp('SubTreeArray'),
                                            class_id,58,
                                           'offset', $view_parameters.offset,
                                           'limit', $page_limit,                                            
                                            spell_check, array( true(), 'default' ),
                                            filter, $filters ) )
                                            }
          {set $search_count=$search_results.SearchCount}
          
          {if $search_count}
                {foreach $search_results.SearchResult as $child}
                  {node_view_gui content_node=$child.object.main_node view="line"}
                {/foreach}
          {else}
            <p>Your search for "{ezhttp('SearchText')}" returned no results.</p>
            <p> <a href={"Library-at-U-Sophia/(show)/search"|ezurl}>Go Back</a> </p>
          {/if}

    {include name=Navigator
             uri='design:navigator/google.tpl'
             page_uri='/content/search'
             page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)), $uriSuffix )
             item_count=$search_count
             view_parameters=$view_parameters
             item_limit=$page_limit}
             
          {/let}
        {else}
          <br />
          <form action={concat($node.url_alias,'/(show)/search')|ezurl} method="post" class="search" id="library-search-form">

    <div class="left">

            <input class="box" name="SearchText" type="text" value="Keyword(s): (put exact phrase in double quotes)" size="12" class="text" />


            <input class="box" name="Title" type="text" value="Title" size="12" class="text" />


            <input class="box" name="Author" type="text" value="Author" size="12" class="text" />

            <input class="box" name="Subject" type="text" value="Subject" size="12" class="text" />
            
            <input class="box" name="Publisher" type="text" value="Publisher" size="12" class="text" />
     


            <div class="block float-break">
              <label>Publication year:</label>
              <input name="PublicationYearAfter" type="text" value="After" size="12" class="text" />
              <input name="PublicationYearBefore" type="text" value="Before" size="12" class="text" />
              <input name="PublicationYearExact" type="text" value="Exact" size="12" class="text" />
            </div>

            <div class="box first float-break">
            <label>Media Types:</label>
              {def $class=fetch( 'content', 'class', hash( 'class_id', 58 ) )}
                {foreach $class.data_map.type.content.options as $option}
                  <div class="checkbox-box">
                    <input type="checkbox" {*value="{$option.id}"*} name="MediaTypes[]" value="{$option.name}" />{$option.name}
                  </div>
                {/foreach}
                <div class="break"></div>
            </div>
            <div class="box second float-break">
            <label>Category(ies):</label>
                    <div class="checkbox-box">
                <input type="checkbox" value="{$node.node_id}" name="SubTreeArray[]" checked="checked" />Entire Library<br />
                    </div>
                {let categories=fetch('content','list',hash('parent_node_id',188,class_filter_type,'include',class_filter_array,array('folder')))}
                  {foreach $categories as $child}
                    <div class="checkbox-box">
                      <input type="checkbox" value="{$child.node_id}" name="SubTreeArray[]" />{$child.name|wash}<br />
                    </div>
                  {/foreach}
                <div class="break"></div>
                {/let}
            </div>
            <br />                
	<div class="search-buttons">
            <input name="submit" class="search-button" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" />
            <input type="reset" value="Clear search" class="clear-button">
	</div>            

        </div>

    <div class="search-tips">
    
      <!--<div class="border-box">-->
      <!--<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>-->
      <!--<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">-->
       
          <div class="content">
          <h3>Search Tips</h3> 
          To search for an exact phrase, enclose the phrase in double quotation marks (e.g., "industrial revolution"). In the Keyword search box you can use Boolean operators (AND, OR, NOT) to connect your search words. AND means you want publications having all your search terms; OR means you want publications having any of the terms; NOT means you want the first term but not the second term. 
          </div>
      

      <!--</div></div></div>-->
      <!--<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>-->

      <!--</div>-->
    
    </div>
        
        
          </form> 
             <div class="break"></div>
             <h1>Search Amazon</h1>
<select id="amazon-selector">
  <option>Select store</option>
  <option value="US">Amazon US</option>
  <option value="CA">Amazon CA</option>
  <option value="FR">Amazon FR</option>
  <option value="DE">Amazon DE</option>  
</select>

<div id="amazon-US-content" class="hide">
  <SCRIPT charset="utf-8" type="text/javascript" src="http://ws.amazon.com/widgets/q?ServiceVersion=20070822&MarketPlace=US&ID=V20070822/US/usoph-20/8002/00321291-93d6-4d50-9878-8a2035a2f8dc"> </SCRIPT> <NOSCRIPT><A HREF="http://ws.amazon.com/widgets/q?ServiceVersion=20070822&MarketPlace=US&ID=V20070822%2FUS%2Fusoph-20%2F8002%2F00321291-93d6-4d50-9878-8a2035a2f8dc&Operation=NoScript">Amazon.com Widgets</A></NOSCRIPT>
  <br />
</div>
<div id="amazon-CA-content" class="hide">
  <SCRIPT charset="utf-8" type="text/javascript" src="http://ws.amazon.ca/widgets/q?ServiceVersion=20070822&MarketPlace=CA&ID=V20070822/CA/usophwhermind-20/8002/d8a7c39c-5958-4586-92f5-45e93b309e7a"> </SCRIPT> <NOSCRIPT><A HREF="http://ws.amazon.ca/widgets/q?ServiceVersion=20070822&MarketPlace=CA&ID=V20070822%2FCA%2Fusophwhermind-20%2F8002%2Fd8a7c39c-5958-4586-92f5-45e93b309e7a&Operation=NoScript">Amazon.ca Widgets</A></NOSCRIPT>
  <br />
</div>
<div id="amazon-FR-content" class="hide">
  <SCRIPT charset="utf-8" type="text/javascript" src="http://ws.amazon.fr/widgets/q?ServiceVersion=20070822&MarketPlace=FR&ID=V20070822/FR/usoph-21/8002/508af374-bf18-4eb6-9be3-02cc71b4ca2f"> </SCRIPT> <NOSCRIPT><A HREF="http://ws.amazon.fr/widgets/q?ServiceVersion=20070822&MarketPlace=FR&ID=V20070822%2FFR%2Fusoph-21%2F8002%2F508af374-bf18-4eb6-9be3-02cc71b4ca2f&Operation=NoScript">Widgets Amazon.fr</A></NOSCRIPT>
  <br />
</div>
<div id="amazon-DE-content" class="hide">
  <SCRIPT charset="utf-8" type="text/javascript" src="http://ws.amazon.de/widgets/q?ServiceVersion=20070822&MarketPlace=DE&ID=V20070822/DE/usophwhermi08-21/8002/39be1da4-d441-4718-b294-28a8bcb58622"> </SCRIPT> <NOSCRIPT><A HREF="http://ws.amazon.de/widgets/q?ServiceVersion=20070822&MarketPlace=DE&ID=V20070822%2FDE%2Fusophwhermi08-21%2F8002%2F39be1da4-d441-4718-b294-28a8bcb58622&Operation=NoScript">Amazon.de Widgets</A></NOSCRIPT>
  <br />
</div>         
            
            
        {/if}
       {/case}
      {case match='read'}
            <h1>Read</h1>
            {def $page_limit = 10
                 $classes =array('folder')
                 $children = array()
                 $children_count = ''}
                 
            {set $children_count=fetch( 'content', 'tree_count', hash( 'parent_node_id', $node.node_id,
										'attribute_filter',array( 'or', array( 'library_item/type','=',0),array( 'library_item/type','=',1) ),
                                                                      'class_filter_type', 'exclude',
                                                                      'class_filter_array', $classes ) )
                  $children=fetch( 'content','tree', hash( 'parent_node_id', $node.node_id,
								'attribute_filter',array( 'or', array( 'library_item/type','=',0),array( 'library_item/type','=',1) ),
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array('name',true() ),
                                                            'class_filter_type', 'exclude',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) )}
       
            <div class="content-view-children">
                    {foreach $children as $child }
 			{node_view_gui content_node=$child view="line"}
                    {/foreach}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

      {/case}        
      {case match='listen'}
            <h1>Listen</h1>
            {def $page_limit = 10
                 $classes =array('folder')
                 $children = array()
                 $children_count = ''}
                 
            {set $children_count=fetch( 'content', 'tree_count', hash( 'parent_node_id', $node.node_id,
										'attribute_filter',array( 'or', array( 'library_item/type','=',3),array( 'library_item/type','=',4) ),
                                                                      'class_filter_type', 'exclude',
                                                                      'class_filter_array', $classes ) )
                  $children=fetch( 'content','tree', hash( 'parent_node_id', $node.node_id,
								'attribute_filter',array( 'or', array( 'library_item/type','=',3),array( 'library_item/type','=',4) ),
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array('name',true() ),
                                                            'class_filter_type', 'exclude',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) )}
       
            <div class="content-view-children">
                    {foreach $children as $child }
 			{node_view_gui content_node=$child view="line"}
                    {/foreach}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

      {/case}
      {case match='view'}
            <h1>View</h1>
            {def $page_limit = 10
                 $classes =array('folder')
                 $children = array()
                 $children_count = ''}
                 
            {set $children_count=fetch( 'content', 'tree_count', hash( 'parent_node_id', $node.node_id,
										'attribute_filter',array( array( 'library_item/type','=',2) ),
                                                                      'class_filter_type', 'exclude',
                                                                      'class_filter_array', $classes ) )
                  $children=fetch( 'content','tree', hash( 'parent_node_id', $node.node_id,
								'attribute_filter',array( array( 'library_item/type','=',2) ),
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', array('name',true() ),
                                                            'class_filter_type', 'exclude',
                                                            'class_filter_array', $classes,
                                                            'limit', $page_limit ) )}
       
            <div class="content-view-children">
                    {foreach $children as $child }
 			{node_view_gui content_node=$child view="line"}
                    {/foreach}
            </div>

            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

      {/case}
      {case}
  
        <h1>{$node.name|wash}</h1>
  
            {if $node.object.data_map.text.has_content}
                <div class="attribute-short">
                    {attribute_view_gui attribute=$node.data_map.text}
                </div>
                {*<a href={concat($node.url_alias,"/(show)/article")|ezurl} class="more-link">&gt;&gt;More</a>*}
                <div class="break"></div>
            {/if}
            
        <h1>Upload to the library</h1>
                          <br />
        <form method="post" action={"/content/action"|ezurl} class="add-content">
            <input type="hidden" name="ClassIdentifier" value="library_item" />
            <input type="hidden" name="NodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
                  <input class="clear-button" type="submit"  name="NewButton" value="Upload" />
        </form>
        
        
      {/case}     
      {/switch}                                                        
  

    </div>
</div>