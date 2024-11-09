//	Velocity vector is set using a constant velocity vector
//	=======================================================
	xVelocity = lengthdir_x(velocity, vDir);
	yVelocity = lengthdir_y(velocity, vDir);
//	========================================

//	The projectile checks for collisions with interactive bodies using collision_line() and bounding boxes
//	======================================================================================================
	var inst = collision_line(x, y, x + xVelocity, y + yVelocity, obj_interactiveBody, false, true);
	if (inst != noone) {
	    inst.addForce(velocity * mass, vDir, 1);
		
//		Damage is based on the instantaneous transfer of momentum and a random multiplier
		inst.applyDamage(velocity * mass * (minDamageMultiplier + random(maxDamageMultiplier - minDamageMultiplier)));
		
		instance_destroy(self);
	} // if
//	=======

//	Check wall collisions
//	=====================
	wallCollisions();
//	=================

//	Adjust vDir and image angle accordingly
//	===================================================
	vDir = point_direction(0, 0, xVelocity, yVelocity);
	image_angle = vDir;
//	===================

//	Move
//	===============
	x += xVelocity;
	y += yVelocity;
//	===============