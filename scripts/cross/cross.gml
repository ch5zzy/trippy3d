/// @param vec_a
/// @param vec_b
function cross(a, b) {
	var c = array_create(3);

	var ax = a[0], ay = a[1], az = a[2];
	var bx = b[0], by = b[1], bz = b[2];
	
	c[0] = ay * bz - az * by;
	c[1] = az * bx - ax * bz;
	c[2] = ax * by - ay * bx;
	
	return c;
}