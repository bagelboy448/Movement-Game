/// @description

if (takeDamage) {
	var inst = instance_create_depth(xCenter, yCenter, depth + 1, obj_groundSplatter);
	inst.image_xscale = 1 + damageAmount/100;
	inst.image_angle = damageDir;
	takeDamage = false;
	damageAmount = 0;
}

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