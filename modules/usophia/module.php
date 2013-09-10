<?php

$Module = array( 'name' => 'U-Sophia', 'variable_params' => true );

$ViewList = array();
$FunctionList = array();
	
$ViewList['current_user'] = array( 'script' => 'current_user.php' );

$ViewList[ 'user_dashboard' ] = array(
'functions' => array(  'user_dashboard' ),
'script' => 'user_dashboard.php',	
'params' => array(  ) );

$ViewList[ 'octoshape' ] = array(
'functions' => array(  'octoshape' ),
'script' => 'octoshape.php',	
'params' => array(  ) );	

$ViewList[ 'item_update' ] = array(
'functions' => array(  'item_update' ),
'script' => 'item_update.php',	
'params' => array(  ) );		

$FunctionList[ 'user_dashboard' ] = array( );
$FunctionList[ 'octoshape' ] = array( );
$FunctionList[ 'item_update' ] = array( );
?>
