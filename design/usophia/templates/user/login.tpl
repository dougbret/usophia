{set-block scope=global variable=cache_ttl}0{/set-block}
<form method="post" action={"/user/login/"|ezurl}>

{literal}
  <script type="text/javascript"> 
    jQuery(document).ready(function() {
      if(getParam( "meeting_login" ) == 1) {
        $.fancybox(
          '<img src="/extension/usophia/design/usophia/images/usophia-logo-message.png" alt="" ><p>If you are registered to U-Sophia, please log in to join the event. Not yet registered? Do it now!.</p>',
          {
                  'autoDimensions'	: false,
            'width'         		: 550,
            'height'        		: 400,
            'transitionIn'		: 'none',
            'transitionOut'		: 'none'
          }
        );
      }  
    });
  
    function getParam( name )
    {
     name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
     var regexS = "[\\?&]"+name+"=([^&#]*)";
     var regex = new RegExp( regexS );
     var results = regex.exec( window.location.href );
     if( results == null )
      return "";
    else
     return results[1];
    }
  </script>
{/literal} 
<div class="maincontentheader">
<h1>{"Login"|i18n("design/standard/user")}</h1>
</div>

{if $User:warning.bad_login}
<div class="warning">
<h2>{"Could not login"|i18n("design/standard/user")}</h2>
<ul>
    <li>{"A valid username and password is required to login."|i18n("design/standard/user")}</li>
</ul>
</div>
{else}

{if $site_access.allowed|not}
<div class="warning">
<h2>{"Access not allowed"|i18n("design/standard/user")}</h2>
<ul>
    <li>{"You are not allowed to access %1."|i18n("design/standard/user",,array($site_access.name))}</li>
</ul>
</div>
{/if}

{/if}

<div class="block">
<label for="id1">{"Username"|i18n("design/standard/user",'User name')}</label><div class="labelbreak"></div>
<input class="halfbox" type="text" size="10" name="Login" id="id1" value="{$User:login|wash}" tabindex="1" />
</div>
<div class="block">
<label for="id2">{"Password"|i18n("design/standard/user")}</label><div class="labelbreak"></div>
<input class="halfbox" type="password" size="10" name="Password" id="id2" value="" tabindex="1" />
</div>

{if and( ezini_hasvariable( 'Session', 'RememberMeTimeout' ), ezini( 'Session', 'RememberMeTimeout' ) )}
    <div class="block">
        <input type="checkbox" tabindex="1" name="Cookie" id="id3" /><label for="id3" style="display:inline;">{"Remember me"|i18n("design/admin/user/login")}</label>
    </div>
{/if}

<div class="buttonblock">
<input class="defaultbutton" type="submit" name="LoginButton" value="{'Login'|i18n('design/standard/user','Button')}" tabindex="1" />
<input class="button" type="submit" name="RegisterButton" value="{'Sign Up'|i18n('design/standard/user','Button')}" tabindex="1" />
</div>

{*if ezini( 'SiteSettings', 'LoginPage' )|eq( 'custom' )*}
    <p><a href={'/user/forgotpassword'|ezurl}>{'Forgot your password?'|i18n( 'design/standard/user' )}</a></p>
{*/if*}


{if ezhttp_hasvariable('redirect','get')}
  <input type="hidden" name="RedirectURI" value="{ezhttp('redirect','get')}" />
{else}
  <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
{/if}


{section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
  {section name=postData loop=$User:post_data }
     <input name="Last_{$postData:key}" value="{$postData:item}" type="hidden" /><br/>
  {/section}
{/section}
</form>
