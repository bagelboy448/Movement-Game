//	Deccelerate the player
//	====================================
	function scr_playerDecceleration() {
		obj_player.vDir = point_direction(0, 0, obj_player.xVelocity, obj_player.yVelocity);
		if (obj_player.xVelocity != 0) {
			if (abs(obj_player.xVelocity) < obj_player.decceleration && abs(obj_player.xVelocity) > 0) {
			    obj_player.xVelocity = 0;
			} // if
			else {
				obj_player.xVelocity += lengthdir_x(obj_player.decceleration, obj_player.vDir + 180);
			} // else
		} // else
		if (obj_player.yVelocity != 0) {
			if (abs(obj_player.yVelocity) < obj_player.decceleration && abs(obj_player.yVelocity) > 0) {
			    obj_player.yVelocity = 0;
			} // if
			else {
			    obj_player.yVelocity += lengthdir_y(obj_player.decceleration, obj_player.vDir + 180);
			} // else
		} // if
	} // function scr_playerDecceleration()
//	=======================================	