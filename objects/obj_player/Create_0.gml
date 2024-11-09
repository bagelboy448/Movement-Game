/// @description Initialization

	randomize();

	up = 0;
	down = 0;
	left = 0;
	right = 0;
	input = 0;
	
	xDir = 0;
	yDir = 0;
	aDir = 0;
	
	mass = 70; // kg
	frictionK = 0.05;
	decceleration = (mass * frictionK) / 60;
	
	sprintSpeedMax = 7; // m/s
	sprintForce = 500 / mass / 60; // m/s/s
	
	xAcceleration = 0;
	yAcceleration = 0;
	
	xVelocity = 0;
	yVelocity = 0;
	velocity = 0;
	vDir = 0;
	
	collisionCoefficient = 0.75;
	
	grappled = false;
	grappleX = 0;
	grappleY = 0;
	maxGrappleLength = 200;
	currentGrappleLength = 0;
	grappleDistance = 0;
	grappleDir = 0;
	
	debugText = false;
	recordedVelocity = [];
	
	shootingCooldown = 10; // shots/sec = 60/shootingCooldown
	shootingCounter = 0;