{set-block variable=$subject scope=root}{ezini('NewsletterMailSettings', 'EmailSubjectPrefix', 'cjw_newsletter.ini')} {$contentobject.name|wash}{/set-block}{set-block variable=$html_mail}<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>{$#subject}</title>
{literal}
<style type="text/css">
#header {
	width:645px;
	height:100px;
text-align:right;
background-color:#35444b;
}
#header img {
	float:left;  
}
#header div {
    color: #CE2E0C;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 16px;  
margin-right:20px;
margin-top:20px;
}
#header h1 {
    color: #DCD198;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 27px;
    line-height: 28px;  
padding:0;margin:0;
font-weight:normal;
margin-right:20px;

}
#header2 {
	width:645px;
	height:28px;
text-align:right;
background-image:url('http://u-sophia.com/extension/usophia/design/standard/images/newsletter/skin/default/header2bg.jpg');
background-repeat:repeat-x;
}
#footer img {
  margin:0 auto;
display:block;
margin-top:40px;
}
.main-content {
padding:10px 20px;
margin-bottom:4px;
}
.main-content.blue {
	background-color:#2e4254;color: #DCD198;
}
.main-content.red {
background-color:#ffeabe;color: #800000;
}
.main-content h3 {
font-family: Arial,Helvetica,sans-serif; 
font-size: 18px;
font-weight:normal;
text-align:left;
margin:5px 0;
}
.main-content.blue p.author {
  color:white;
}
.readmore-bar {
width: 100%;
height:25px;
margin-bottom:15px;
color:white;
}
.readmore-bar.red { background-color:#ffeabe; }
.readmore-bar.blue { background-color:#2e4254; }
.readmore-bar img {
  
}
.readmore-bar img {
  float:right;
}

.readmore-bar p {
  margin:2px 0 0 20px;padding:0;
width:50%;
float:left;
}

</style>
{/literal}

</head>
<body>
<table id="table-main">
<tr align="left">
    {def $edition_data_map = $contentobject.data_map
         $webnewsletter = fetch('content','node',hash('node_id',35870))}
    <td valign="top">
        <table width="689" cellpadding="0" cellspacing="0" border="0" bgcolor="#ffffff">
            <tr id="header">
                <td colspan="2"><a href="http://u-sophia.com"><img src={'images/newsletter/skin/default/newsletter_logo.jpg'|ezdesign()} border="0" width="227" height="80" alt="" /></a>
<div class="custom">{$edition_data_map.motto.content}</div>
<h1 class="custom">U-SOPHERS' <strong>NEWSLETTER</strong></h1>
		</td>
            </tr>

            <tr id="header2">
                <td colspan="2">
		<a href="http://u-sophia.com"><img src={'images/newsletter/skin/default/NewWeb.jpg'|ezdesign()} border="0" width="90" height="31" alt="" /></a>
		<a href="mailto:dan.shorer@u-sophia.com"><img src={'images/newsletter/skin/default/NewEmail.jpg'|ezdesign()} border="0" width="148" height="31" alt="" /></a>
</td>
            </tr>





{*            <tr>
                <td style="padding: 20px 0 0 15px" colspan="2">
                    {if $edition_data_map.title.has_content}
                        <h1>{$edition_data_map.title.content|wash()}</h1>
                    {/if}
                </td>
            </tr>*}
            <tr style="">
                <td class="main-content" style="padding:0;width:75%;">
{*                    {if $edition_data_map.description.has_content}
                        {$edition_data_map.description.content.output.output_text|wash(xml)}
                    {/if}*}





            {def $list_items = fetch('content', 'list', hash( 'parent_node_id', $contentobject.contentobject.main_node_id,
                                                              'sort_by', array( 'priority' , true() ),
                                                              'class_filter_type', 'include',
                                                              'class_filter_array', array( 'cjw_newsletter_article', 'article' ) ) )
            }
            {if $list_items|count|ne(0)}

                    {* show subarticles *}
               {foreach $list_items as $attribute sequence array('blue','red') as $style}
			<div class="main-content {$style}">


                        {* title *}
                        {if $attribute.data_map.title.has_content}
                            <h3>{attribute_view_gui attribute=$attribute.data_map.title}</h3>
                        {/if}

                        {* text *}
                        {if $attribute.data_map.short_description.has_content}
                            {attribute_view_gui attribute=$attribute.data_map.short_description}
                        {/if}

                        {if $attribute.data_map.image.has_content}
                            {attribute_view_gui attribute=$attribute.data_map.image image_class="imagelarge"}
                        {/if}
                        {if $attribute.data_map.body.has_content}
                            {attribute_view_gui attribute=$attribute.data_map.body}
                        {/if}			
			</div>	
			<div class="readmore-bar {$style}">
                        {if $attribute.data_map.author.has_content}
                          <p class="author">{attribute_view_gui attribute=$attribute.data_map.author}</p>
                        {/if}	

				{if $attribute.data_map.url.has_content}<a href="{$attribute.data_map.url.content}"><img src="https://system.newzapp.co.uk/editsite/customers/16206/nz-images/button_readmore_dark.gif" /></a>{/if}
			</div>
                {/foreach}

            {/if}










                    <br />
                </td>
                <td style="background-color:#fff;color: #800000;padding:10px;width:25%;vertical-align: top;text-align:left; font-size: 16px;">
                    {if $edition_data_map.right_column_text.has_content}
                        {$edition_data_map.right_column_text.content.output.output_text|wash(xml)}
                    {/if}
                    <br />
                </td>
            </tr>
            <tr id="footer">
	    	<td colspan="2">

<a href="http://u-sophia.com"><img src={'images/newsletter/skin/default/footer_image.jpg'|ezdesign()} border="0" width="648" height="34" alt="" /></a>

		</td>
            </tr>
            <tr>
                <td style="padding: 10px 30px 10px 10px;color:#989ca5;" colspan="2">
                    <p style="font-family:arial,helvetica,sans-serif;font-size:10px;line-height:1.5;">
  		   {def $src_url = concat('http://u-sophia.com/newsletter/preview/' , $contentobject.contentobject.id, '/', $contentobject.contentobject.current_version , '/0/ezflow_site_user/default/')} 
		    Newsletter does not display properly? <a href="{$src_url}" style="font-family:arial,helvetica,sans-serif;padding:0;line-height:1.5;"><u>{'View on the web'|i18n('cjw_newsletter/skin/default')}</u></a><br/>
                    {'To unsubscribe from this newsletter please visit the following link'|i18n('cjw_newsletter/skin/default')}:
                                
				<a href="http://u-sophia.com/newsletter/unsubscribe/#_hash_unsubscribe_#" style="color:blue;font-family:arial,helvetica,sans-serif;padding:0;line-height:1.5;"><u>{'unsubscribe'|i18n('cjw_newsletter/skin/default')}</u></a>
 
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</body>
</html>
{/set-block}{$html_mail|cjw_newsletter_str_replace(
                            array( '<body>',
                                   '<table id="table-main">',
  				   '<a class="image"',
                                   '<a href=',
                                   '<li>',
                                   '<p>',
                                   '<h1>',
                                   '<h2>',
                                   ' />',

                                   '     ',
                                   '   ',
                                   '  ',
                                   '  ',
                                   '> <'
                                    ),
                            array( '<body bgcolor="#ffffff" text="#666666" link="#666666" vlink="#666666" alink="#666666" style="margin:0;padding:0;font-family:arial,helvetica,sans-serif;">',
                                   '<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" style="margin:0;padding:0;background-color: #FFFFFF; height: 100%;width: 100%">',
                                   '<a style="color:#666666;font-family:arial,helvetica,sans-serif;padding:0;line-height:1.5;text-decoration: none;"',				    
                                   '<a style="color:#666666;font-family:arial,helvetica,sans-serif;padding:0;line-height:1.5;" href=',
                                   '<li style="color:#666666;font-family:arial,helvetica,sans-serif;font-size:11px;padding:0;line-height:1.5;">',
                                   '<p style="font-family:arial,helvetica,sans-serif;font-size:11px;padding:0;line-height:1.5;">',
                                   '<h1 style="color:#cc0000;font-family:arial,helvetica,sans-serif;font-size:15px;font-weight:bold;line-height:1;padding:0">',
                                   '<h2 style="color:#666666;font-family:arial,helvetica,sans-serif;font-size:1.3em;font-weight:bold;line-height:1;padding:0">',
                                   '>',

                                   '',
                                   '',
                                   ' ',
                                   ' ',
                                   '><'
                                    )
                                   )}
