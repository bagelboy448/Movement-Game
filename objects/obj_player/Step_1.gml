/// @description Movement
	
//	Get movement input
//	==============================
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
//	=================================

//	Determine the acceleration direction (aDir) for internal forces
//	===============================================================
	xDir = right - left;
	yDir = down - up;
	aDir = point_direction(0, 0, xDir, yDir);
//	=========================================

//	Detect input == true
//	=================================
	input = (xDir != 0 || yDir != 0);
//	=================================	
	
//	Sprint Acceleration
//	=============================
	scr_playerMoveAcceleration();
//	=============================	
	
//	Accelerate
//	===========================
	xVelocity += xAcceleration;
	yVelocity += yAcceleration;
	velocity = magnitude(xVelocity, yVelocity);
//	===========================================	
	
//	Decceleration due to friction
//	=============================
	if (!grappled) {
	    scr_playerDecceleration();
	}
//	==========================	
	
//	Simple collisions
//	===================================================
	if place_meeting(x + xVelocity, y, obj_solidWall) {
		xVelocity *= -collisionCoefficient;
	} // if
	if (place_meeting(x, y + yVelocity, obj_solidWall)) {
	    yVelocity *= -collisionCoefficient;
	} // if
//	=======	
	
//	Check for grapple input
//	==========================================
	if (mouse_check_button_pressed(mb_left)) {
	    grappled = !grappled;
		if (distance(x, y, mouse_x, mouse_y) > maxGrappleLength) {
		    grappleDir = point_direction(x, y, mouse_x, mouse_y);
			grappleX = x + lengthdir_x(maxGrappleLength, grappleDir);
			grappleY = y + lengthdir_y(maxGrappleLength, grappleDir);
		} // if
		else {
		    grappleX = mouse_x;
			grappleY = mouse_y;
		} // else
	} // if
//	=======

//	Grappled movement
//	=================
	if (grappled) {
		vDir = point_direction(0, 0, xVelocity, yVelocity);
		grappleDistance = distance(x, y, grappleX, grappleY);
		grappleDir = point_direction(x, y, grappleX, grappleY);
		if (grappleDistance > maxGrappleLength - 5 && !(vDir < grappleDir + 90 && vDir > grappleDir - 90)) {
			var xRef = lengthdir_x(1, grappleDir + 90);
			var yRef = lengthdir_y(1, grappleDir + 90);
			var xVelocityTemp = xVelocity;
			var yVelocityTemp = yVelocity;
			xVelocity = xRef * (dotProduct(xVelocityTemp, yVelocityTemp, xRef, yRef)/dotProduct(xRef, yRef, xRef, yRef));
			yVelocity = yRef * (dotProduct(xVelocityTemp, yVelocityTemp, xRef, yRef)/dotProduct(xRef, yRef, xRef, yRef));
		} // if
	} // if
//	=======	
	
//	Move
//	===============
	x += xVelocity;
	y += yVelocity;
//	===============

//	Correct movement to keep grapple length constant
//	=====================================================
	if (grappled && grappleDistance > maxGrappleLength) {
	    x += lengthdir_x(grappleDistance - maxGrappleLength, grappleDir);
	    y += lengthdir_y(grappleDistance - maxGrappleLength, grappleDir);
	} // if
// ========
	
//	Non-movement inputs
//	===============================

//	Put the player in test position
	if (keyboard_check(vk_enter)) {
	    scr_setPlayerStatic(100, 100);
		grappled = false;
	} // if
	
	if (keyboard_check_pressed(ord("T"))) {
		debugText = !debugText;
	}
	
//	=======	