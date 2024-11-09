draw_self();

var position = "position: (" + string(x) + ", " + string(y) + ")";
draw_text(x, y + 10, position);

var velocity = "velocity: <" + string(xVelocity) + ", " + string(yVelocity) + ">";
draw_text(x, y + 30, velocity);

var accelerationS = "acceleration: <" + string(xAcceleration) + ", " + string(yAcceleration) + ">";
draw_text(x, y + 50, accelerationS);