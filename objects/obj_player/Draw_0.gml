/// @description Rendering

	draw_self();
	image_angle = point_direction(x, y, mouse_x, mouse_y);
	
	if (grappled) {
		var currentColor = draw_get_color();
		draw_set_color(c_black);
	    draw_line_width(x, y, grappleX, grappleY, 3);
		draw_set_color(currentColor);
		var grappleLength = magnitude(abs(x - grappleX), abs(y - grappleY));
		var grappleDir = point_direction(x, y, grappleX, grappleY);
		var grappleLengthS = "length: " + string(grappleLength) + "px";
		draw_text(
		x + lengthdir_x(grappleLength/2, grappleDir), 
		y + lengthdir_y(grappleLength/2, grappleDir),
		grappleLengthS);
		draw_text(100, 500 + 70, "grappled = true");
		draw_text(100, 500 + 90, grappleLengthS);
	}
	
	var position = "position: (" + string(x) + ", " + string(y) + ")";
	draw_text(x, y + 10, position);
	draw_text(100, 500 + 10, position);

	var velocityS = "velocity: <" + string(xVelocity) + ", " + string(yVelocity) + "> = "
	+ string(magnitude(xVelocity, yVelocity)) + "m/s";
	draw_text(x, y + 30, velocityS);
	draw_text(100, 500 + 30, velocityS);

	var accelerationS = "acceleration: <" + string(xAcceleration) + ", " + string(yAcceleration) + "> = "
	+ string(magnitude(xAcceleration, yAcceleration)) + "m/s/s";
	draw_text(x, y + 50, accelerationS);
	draw_text(100, 500 + 50, accelerationS);