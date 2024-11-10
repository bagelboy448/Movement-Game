/// @description Rendering

	draw_self();
	image_angle = point_direction(x, y, mouse_x, mouse_y);
	if (grappled) {
		var currentColor = draw_get_color();
	    draw_set_color(c_black);
		draw_line_width(x, y, grappleX, grappleY, 3);
		draw_set_color(currentColor);
	}
	
	array_push(recordedVelocity, velocity);
		if (array_length(recordedVelocity) >= 150) {
		    array_delete(recordedVelocity, 0, 1);
		}
	
	if (debugText) {
	    if (grappled) {			
			var grappleDir = point_direction(x, y, grappleX, grappleY);
			var grappleLengthS = "length: " + string(grappleDistance) + "px";
			draw_text(
			x + lengthdir_x(grappleDistance/2, grappleDir), 
			y + lengthdir_y(grappleDistance/2, grappleDir),
			grappleLengthS);
			draw_text(100, 500 + 70, "grappled = true");
			draw_text(100, 500 + 90, "length: " + string(grappleDistance));
		}
	
		var position = "position: (" + string(x) + ", " + string(y) + ")";
		draw_text(x, y + 10, position);
		draw_text(100, 500 + 10, position);

		var velocityS = "velocity: <" + string(xVelocity) + ", " + string(yVelocity) + "> = "
		+ string(magnitude(xVelocity, yVelocity)) + "m/s";
		draw_text(x, y + 30, velocityS);
		draw_text(100, 500 + 30, velocityS);

		var accelerationS = "acceleration: <" + string(xAcceleration) + ", " + string(yAcceleration) + "> = "
		+ string(acceleration) + "m/s/s";
		draw_text(x, y + 50, accelerationS);
		draw_text(100, 500 + 50, accelerationS);

		var graphStartX = 800;
		var graphStartY = 570;
		for (var i = 0; i < array_length(recordedVelocity); i++) {
		    draw_point(graphStartX + 2 * i, graphStartY - 10 * recordedVelocity[i])
		}
		draw_line(graphStartX, graphStartY, graphStartX + 300, graphStartY);
		draw_line(graphStartX, graphStartY, graphStartX, graphStartY -70);
		draw_text(graphStartX, graphStartY, "velocity over time");
		
	}