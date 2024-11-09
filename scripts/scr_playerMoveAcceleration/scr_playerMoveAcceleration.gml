function scr_playerMoveAcceleration() {
	
	if input && abs(obj_player.velocity) < obj_player.sprintSpeedMax {
		obj_player.xAcceleration = lengthdir_x(obj_player.sprintForce, obj_player.aDir);
		obj_player.yAcceleration = lengthdir_y(obj_player.sprintForce, obj_player.aDir);
	}
	else {
		obj_player.xAcceleration = 0;
		obj_player.yAcceleration = 0;
	}
}