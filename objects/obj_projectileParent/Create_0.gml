/// @description Initialization and function declaration

	mass = 1;
	velocity = 0;

	xVelocity = 0;
	yVelocity = 0;
	vDir = 0;
	image_angle = 0;

	collisionCoefficient = 1;

	minDamageMultiplier = 0;
	maxDamageMultiplier = 0;
	
	headshot = false;
	headshotTarget = noone;

//	Basic object constructor
//	===============================================================
	function projectileParent(_mass, _velocity, _vDir, _imageAngle, 
								_minDamageMultiplier, _maxDamageMultiplier, 
								_headshot = false, _headshotTarget = noone) constructor {
									
		mass = _mass;
		velocity = _velocity;
		vDir = _vDir;
		image_angle = _imageAngle;
		minDamageMultiplier = _minDamageMultiplier;
		maxDamageMultiplier = _maxDamageMultiplier;
		
		headshot = _headshot;
		headshotTarget = _headshotTarget;
		
	} // constructor projectileParent()
//	===================================	

//	Calculates more advanced solid wall collisions using collision_line()
//	=====================================================================
	function wallCollisions() {
		var inst = collision_line(x, y, x + xVelocity, y, obj_solidWall, true, true);
		if (inst != noone) {
		    var objDist = distance_to_object(inst);
			var moveDir = vDir;
			var xDist = lengthdir_x(objDist, moveDir);
			xVelocity = -collisionCoefficient * (xVelocity - xDist);
		} // if
		inst = collision_line(x, y, x, y + yVelocity, obj_solidWall, true, true);
		if (inst != noone) {
		    var objDist = distance_to_object(inst);
			var moveDir = vDir;
			var yDist = lengthdir_y(objDist, moveDir);
			yVelocity = -collisionCoefficient * (yVelocity - yDist);
		} // if
	} // function wallCollision()
//	=============================