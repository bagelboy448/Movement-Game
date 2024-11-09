//	Get user input
//	==============================
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
//	=================================

//	Determine aDir (target movement direction)
//	==========================================
	xInput = right - left;
	yInput = down - up;

	if (xInput != 0 || yInput != 0) {
		aDir = point_direction(0, 0, xInput, yInput);
	    xAcceleration = lengthdir_x(acceleration / mass, aDir);
		yAcceleration = lengthdir_y(acceleration / mass, aDir);
	} // if
	else {
		aDir = vDir;
	    xAcceleration = 0;
		yAcceleration = 0;
	} // else
//	=========

	space = keyboard_check(vk_space);
	if (space && count <= 0) {
		addForceToPlayer(jetForce, vDir, duration);
		count = jetCooldown;
	}
	else {
		count--;
	}
	
	ApplyPlayerForces();

	xVelocity += xAcceleration;
	yVelocity += yAcceleration;

	vDir = point_direction(0, 0, xVelocity, yVelocity);
	if (xVelocity != 0) {
		if (abs(xVelocity) < decceleration && abs(xVelocity) > 0) {
		    xVelocity = 0;
		} // if
		else {
			xVelocity += lengthdir_x(decceleration, vDir + 180);
		} // else
	} // else
	if (yVelocity != 0) {
		if (abs(yVelocity) < decceleration && abs(yVelocity) > 0) {
		    yVelocity = 0;
		} // if
		else {
		    yVelocity += lengthdir_y(decceleration, vDir + 180);
		} // else
	} // if

	xVelocity = clamp(xVelocity, -maxRunningSpeed, maxRunningSpeed);
	yVelocity = clamp(yVelocity, -maxRunningSpeed, maxRunningSpeed);

	x += xVelocity;
	y += yVelocity;

	image_angle = point_direction(x, y, mouse_x, mouse_y);