/// @description Initialization and function declaration

	hp = 100; 

	acceleration = 0;
	xAcceleration = 0;
	yAcceleration = 0;
	aDir = 0;

	velocity = 0;
	xVelocity = 0;
	yVelocity = 0;
	vDir = 0;

	mass = 70; // kg
	frictionK = 0.01;
	decceleration = mass * frictionK / 60;
	collisionCoefficient = 1;

	forces = [];
	
	xCenter = x + sprite_width / 2;
	yCenter = y + sprite_width / 2;
	targetRadius = 10;
	
	takeDamage = false;
	damageAmount = 0;
	damageDir = 0;

//	Adds a force to the interactive body. The ordered triple is 
//	(force magnitude, force direction, frame duration)
//	==================================================
	function addForce(force, fDir, duration) {
	    array_push(forces, force, fDir, duration);
	} // function addForce()
//	========================

//	Applies all forces in the force array to the interactive body and decrements their duration
//	===========================================================================================
	function applyForces() {
	    if (array_length(forces) != 0) {
		    for (var i = 0; i < array_length(forces) / 3; i = 3 * i + 3) {
			    xVelocity += lengthdir_x(forces[i] / mass, forces[i + 1]);
			    yVelocity += lengthdir_y(forces[i] / mass, forces[i + 1]);
				forces[i + 2]--;
				
//				If a force's duration is zero it is removed from the array
				if (forces[i + 2] <= 0) {
				    array_delete(forces, i, 3);
				} // if
				
			} // for
		} // if
	} // function applyForces()
//	===========================

//	Reduces current hp by an amount
//	===============================
	function applyDamage(amount, _damageDir) {
	    hp -= amount;
		takeDamage = true;
		damageAmount = amount;
		damageDir = _damageDir;
	} // function applyDamage()
//	===========================

//	Calculates basic place_meeting() solid wall collisions
//	======================================================
	function simpleWallCollisions() {
	    if (place_meeting(x + xVelocity, y, obj_solidWall)) {
			xVelocity *= -collisionCoefficient;
		} // if
		if (place_meeting(x, y + yVelocity, obj_solidWall)) {
		    yVelocity *= -collisionCoefficient;
		} // if
	} // function simpleWallCollisions()
//	====================================

//	Deccelerates the body in the direction of motion
//	================================================
	function deccelerate() {
	    if (xVelocity != 0) {
			if (abs(xVelocity) < decceleration && abs(xVelocity) > 0) {
			    xVelocity = 0;
			} // if
			else {
				xVelocity += lengthdir_x(decceleration, vDir + 180);
			} // else
		} // if
		if (yVelocity != 0) {
			if (abs(yVelocity) < decceleration && abs(yVelocity) > 0) {
			    yVelocity = 0;
			} // if
			else {
				yVelocity += lengthdir_y(decceleration, vDir + 180);
			} // else
		} // if
	} // function deccelerate()
//	===========================