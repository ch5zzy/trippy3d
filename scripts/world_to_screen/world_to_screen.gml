/// @param x
/// @param y
/// @param z
/// @param view_mat
/// @param proj_mat
function world_to_screen(xx, yy, zz, view_mat, proj_mat) {
	if (proj_mat[15] == 0) { //perspective projection
	    var w = view_mat[2] * xx + view_mat[6] * yy + view_mat[10] * zz + view_mat[14];
	    // If you try to convert the camera's "from" position to screen space, you will end up dividing by zero
	    if (w <= 0) return [NaN, NaN];
	    if (w == 0) return [NaN, NaN];
	    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8] * zz + view_mat[12]) / w;
	    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9] * zz + view_mat[13]) / w;
	} else { //ortho projection
	    var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8]  * zz + view_mat[12]);
	    var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9]  * zz + view_mat[13]);
	}

	return [(0.5 + 0.5 * cx) * window_get_width(), (0.5 + 0.5 * cy) * window_get_height()];
}