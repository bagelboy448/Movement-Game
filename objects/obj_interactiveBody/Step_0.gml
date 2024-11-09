/// @description

if (hp <= 0) {
	instance_destroy(self);
}

applyForces();
vDir = point_direction(0, 0, xVelocity, yVelocity);

simpleWallCollisions();

deccelerate();

x += xVelocity;
y += yVelocity;