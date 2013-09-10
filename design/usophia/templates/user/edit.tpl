<form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">

<div class="user-edit">

<div class="attribute-header">
  <h1 class="long">{"User profile"|i18n("design/ezwebin/user/edit")}</h1>
</div>

<div class="block">
  <label>{"Username"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.login|wash}</p>
</div>

<div class="block">
  <label>{"Email"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.email|wash(email)}</p>
</div>

<div class="block">
  <label>{"Name"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.contentobject.name|wash}</p>
</div>



<div class="buttonblock">
<input class="button" type="submit" name="EditButton" value="{'Edit profile'|i18n('design/ezwebin/user/edit')}" />
<input class="button" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n('design/ezwebin/user/edit')}" />
</div>

</div>

</form>