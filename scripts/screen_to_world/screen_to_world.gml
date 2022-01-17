/// @param x
/// @param y
/// @param view_mat
/// @param proj_mat
function screen_to_world(xx, yy, view_mat, proj_mat){
	var mx = 2 * (xx / window_get_width() - .5) / proj_mat[0];
	var my = 2 * (yy / window_get_height() - .5) / proj_mat[5];
	var my = 2 * (yy / window_get_height() - .5) / proj_mat[5];
	var camX = -(view_mat[12] * view_mat[0] + view_mat[13] * view_mat[1] + view_mat[14] * view_mat[2]);
	var camY = -(view_mat[12] * view_mat[4] + view_mat[13] * view_mat[5] + view_mat[14] * view_mat[6]);
	var camZ = -(view_mat[12] * view_mat[8] + view_mat[13] * view_mat[9] + view_mat[14] * view_mat[10]);

	if(proj_mat[15] == 0) { // perspective projection
	    return [view_mat[2]  + mx * view_mat[0] + my * view_mat[1],
	            view_mat[6]  + mx * view_mat[4] + my * view_mat[5],
	            view_mat[10] + mx * view_mat[8] + my * view_mat[9],
	            camX,
	            camY,
	            camZ];
	} else { //ortho projection
	    return [view_mat[2],
	            view_mat[6],
	            view_mat[10],
	            camX + mx * view_mat[0] + my * view_mat[1],
	            camY + mx * view_mat[4] + my * view_mat[5],
	            camZ + mx * view_mat[8] + my * view_mat[9]];
	}
}