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
	scr_playerDecceleration();
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
		    var grappleDir = point_direction(x, y, mouse_x, mouse_y);
			grappleX = x + lengthdir_x(maxGrappleLength, grappleDir);
			grappleY = y + lengthdir_y(maxGrappleLength, grappleDir);
		} // if
		else {
		    grappleX = mouse_x;
			grappleY = mouse_y;
		} // else
	} // if
//	=======
	
	if (grappled) {
	    var grappleDir = point_direction(x, y, grappleX, grappleY);
	}
	
//	Move
//	===============
	x += xVelocity;
	y += yVelocity;
//	===============
	
//	Non-movement inputs
//	===============================

//	Put the player in test position
	if (keyboard_check(vk_enter)) {
	    scr_setPlayerStatic(100, 100);
	} // if
	
//	=======	