/// @description

draw_self();
draw_text(x, y - 20, "hp: " + string(hp));

var ellipseRadius = targetRadius;
draw_ellipse_color(xCenter - ellipseRadius, yCenter - ellipseRadius, 
					xCenter + ellipseRadius, yCenter + ellipseRadius,
					c_yellow, c_yellow, true);