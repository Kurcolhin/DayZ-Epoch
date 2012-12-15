
private["_list","_animalssupported","_type","_root","_favouritezones","_randrefpoint","_PosList","_PosSelect","_Pos","_agent","_id","_pos","_near"];
_list = getposATL player nearEntities [["CAAnimalBase"],dayz_animalDistance];

if (count _list < dayz_maxAnimals) then {
	//Find where animal likes
	_animalssupported = ["Chicken","Cow","Sheep","WildBoar","WildBoar","WildBoar","Goat","Rabbit","Rabbit","Dog"];
	
	_type =  (_animalssupported select floor(random(count _animalssupported)));
	if (_type == "Cow") then {
		_animalssupported = ["Cow01","Cow02","Cow03","Cow04","Cow01_EP1"];
		_type =  (_animalssupported select floor(random(count _animalssupported)));
	};
	if (_type == "Goat") then {
		_animalssupported = ["Goat01_EP1","Goat02_EP1","Goat"];
		_type =  (_animalssupported select floor(random(count _animalssupported)));
	};
	if (_type == "Sheep") then {
		_animalssupported = ["Sheep","Sheep02_EP1","Sheep01_EP1"];
		_type =  (_animalssupported select floor(random(count _animalssupported)));
	};
	if (_type == "Chicken") then {
		_animalssupported = ["Hen","Cock"];
		_type =  (_animalssupported select floor(random(count _animalssupported)));
	};
	if (_type == "Dog") then {
		_animalssupported = ["DZ_Fin","DZ_Pastor"];
		_type =  (_animalssupported select floor(random(count _animalssupported)));
	};

	_root = configFile >> "CfgVehicles" >> _type;
	_favouritezones = getText ( _root >> "favouritezones");
	
	//_randrefpoint = [position player, 10, dayz_animalDistance, 1, 0, 50, 0] call BIS_fnc_findSafePos;
	_randrefpoint = getposATL player;
	_PosList = 		selectbestplaces [_randrefpoint,dayz_animalDistance,_favouritezones,10,5];
	_PosSelect = 	_PosList select (floor random (count _PosList));
	_Pos =  		_PosSelect select 0;
	_list = 		_Pos nearEntities [["CAAnimalBase","Man"],50];
	
	
	if (player distance _Pos < dayz_animalDistance and NOT surfaceIsWater _Pos and (count _list <= 1)) then {
		if (_type == "DZ_Pastor") then { _agent = createAgent [_type, _Pos, [], 0, "NONE"]; } else { _agent = createAgent [_type, _Pos, [], 0, "FORM"]; };
		_agent setpos _Pos;
		_id = [_pos,_agent] execFSM "\z\addons\dayz_code\system\animal_agent.fsm";
	};
	sleep 1;
};

//Comment out above code and use code below for testing
/*
private["_type","_pos","_agent","_id"];
_near = (position player) nearEntities ["DZ_Pastor",500];

if (count _near == 0) then {
	_type = "DZ_Pastor";
	_pos = player modelToWorld [0,(count _near) + 1,0];
	_agent = createAgent [_type, _pos, [], 0, "NONE"];
	player reveal _agent;
	_agent setpos _pos;
	//_id = [_pos,_agent] execFSM "\z\addons\dayz_code\system\animal_agent.fsm";
	_id = 1;
	_agent setVariable ["fsm_handle", _id];
};
*/