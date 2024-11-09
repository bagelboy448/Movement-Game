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

xCenter = x + sprite_width / 2;
yCenter = y + sprite_width / 2;