/// @param vec
function normalize(vec) {
	var res = array_create(3);
	
	var vx = vec[0], vy = vec[1], vz = vec[2];
	var mag = sqrt(vx * vx + vy * vy + vz * vz);
	
	res[0] = vx / mag;
	res[1] = vy / mag;
	res[2] = vz / mag;
	
	return res;
}
