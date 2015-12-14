<?php

// an array of values:
$values = array('Alabama','Alaska','American Samoa','Arizona','Arkansas','California','Colorado','Connecticut','Delaware',
'District of Columbia','Florida','Georgia','Guam','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana'
,'Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire'
,'New Jersey','New Mexico','New York','North Carolina','North Dakota','Northern Marianas Islands','Ohio','Oklahoma','Oregon'
,'Pennsylvania','Puerto Rico','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia'
,'Virgin Islands','Washington','West Virginia','Wisconsin','Wyoming');

$states =array();
$i = 0;

// assign these values an ID.  Normally, this ID would come from a database key or similar master value
foreach($values as $state){
	$states['state_' . ++$i] = $state;
}

$query = '';
if(array_key_exists('query',$_GET)){
	$query = $_GET['query'];
} else if(array_key_exists('query',$_POST)){
	$query = $_POST['query'];
}

$retVal 		= array();
$suggestions 	= array();

foreach($states as $key=>$state){
	$pos = stripos($state, $query);
	if (!($pos === false)) {
		$value = array();
		$value[$key] = $state;
		array_push($suggestions,$value);
	}
}

$retVal['query'] = $query;
$retVal['suggestions'] = $suggestions;

header('Content-type: application/json');
echo json_encode($retVal);
?>