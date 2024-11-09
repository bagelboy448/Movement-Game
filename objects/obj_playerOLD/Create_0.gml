up = 0;
down = 0;
left = 0;
right = 0;
space = 0;
Q = 0;
E = 0;

xInput = 0;
yInput = 0;

acceleration = 2;
aDir = 0;
maxRunningSpeed = 20;

mass = 1;
frictionK = 0.5;
decceleration = mass * frictionK;

xAcceleration = 0;
yAcceleration = 0;

xVelocity = 0;
yVelocity = 0;
vDir = 0;

playerForces = []; // force, direction, duration

jetForce = 10;
jetCooldown = 60;
duration = 30;
count = 0;