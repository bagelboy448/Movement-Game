/// @description Controls
	
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
	

	
//	Decceleration due to friction
//	=============================
	if (!grappled || grappleDistance <= maxGrappleLength - 15) {
	    scr_playerDecceleration();
	} // if
//	=======	
	
//	Simple collisions
//	===================================================
	if (place_meeting(x + xVelocity, y, obj_solidWall)) {
		xVelocity *= -collisionCoefficient;
		if (grappled) {
		    grappled = false;
		}
	} // if
	if (place_meeting(x, y + yVelocity, obj_solidWall)) {
	    yVelocity *= -collisionCoefficient;
		if (grappled) {
		    grappled = false;
		}
	} // if
//	=======	
	
//	Check for grapple input
//	==========================================
	if (mouse_check_button_pressed(mb_right)) {
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

	if (grappled && mouse_check_button(mb_right)) {
	    xAcceleration += lengthdir_x(grappleAcceleration, grappleDir);
	    yAcceleration += lengthdir_y(grappleAcceleration, grappleDir);
	}
	else {
	    grappled = false;
	}

//	Grappled movement
//	=================
	if (grappled) {
		
//		Calculate current movement direction and distance from the grapple point
//		========================================================================
		vDir = point_direction(0, 0, xVelocity, yVelocity);
		grappleDistance = distance(x, y, grappleX, grappleY);
		grappleDir = point_direction(x, y, grappleX, grappleY);
//		=======================================================
		
//		If the player is within 5px of the maximum grapple length and not trying to move 
//		in towards the grapple, conform their movement to take them in a circle.
//		====================================================================================================
		if (grappleDistance > maxGrappleLength + 5 && !(vDir < grappleDir + 90 && vDir > grappleDir - 90)) {
			
//			1. A "reference vector" is created with	length 1 and perpendicular to the grapple direction
			var xRef = lengthdir_x(1, grappleDir + 90);
			var yRef = lengthdir_y(1, grappleDir + 90);
			
//			2. A copy of the player's velocity vector is created
			var xVelocityTemp = xVelocity;
			var yVelocityTemp = yVelocity;
			
//			3. Take the vector projection of the velocity onto the reference vector
			xVelocity = xRef * (dotProduct(xVelocityTemp, yVelocityTemp, xRef, yRef)/dotProduct(xRef, yRef, xRef, yRef));
			yVelocity = yRef * (dotProduct(xVelocityTemp, yVelocityTemp, xRef, yRef)/dotProduct(xRef, yRef, xRef, yRef));
			
		} // if
	} // if
//	=======	
	
//	Accelerate
//	===========================
	xVelocity += xAcceleration;
	yVelocity += yAcceleration;
//	===========================
	
//	Move
//	===============
	x += xVelocity;
	y += yVelocity;
	acceleration = magnitude(xAcceleration, yAcceleration);
	velocity = magnitude(xVelocity, yVelocity);
//	===========================================

//	Correct movement to keep grapple length constant
//	=====================================================
	if (grappled && grappleDistance > maxGrappleLength + 5) {
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
	
//	Show debug text	
	if (keyboard_check_pressed(ord("T"))) {
		debugText = !debugText;
	} // if
	
//	Shoot a projectile
	if (mouse_check_button(mb_left) && shootingCounter <= 0) {
		shootingCounter = shootingCooldown;
		var projectile = instance_create_depth(x, y, depth - 1, obj_projectileParent);
		
		var targetInst = instance_nearest(mouse_x, mouse_y, obj_interactiveBody);
		if (targetInst != noone) {
		    if (distance(mouse_x, mouse_y, targetInst.xCenter, targetInst.yCenter) <= targetInst.targetRadius) {
			    projectile.projectileParent(0.1, 50, image_angle, image_angle, 1, 1, true, targetInst); // projectile constructor
			}
			else {
			    projectile.projectileParent(0.1, 50, image_angle, image_angle, 1, 1); // projectile constructor
			}
		}
		else {
		    projectile.projectileParent(0.1, 50, image_angle, image_angle, 1, 1); // projectile constructor
		}
		
	} // if
	else {
		shootingCounter--;
	} // else
//	=========