<?php

$user = eZUser::currentUser();

$groups = $user->attribute('groups');
in_array(12,$groups) ? $admin = 1 : $admin = 0;

echo $user->attribute('contentobject_id') . "," . $user->attribute('login') . "," . $user->attribute('password_hash') . "," . $user->attribute('email') . "," . $admin;
eZExecution::cleanExit();

?>