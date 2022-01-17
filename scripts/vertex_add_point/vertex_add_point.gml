/// @function				vertex_add_point(xx,yy,zz,nx,ny,nz,utex,vtex,color,alpha)
/// @param vbuffer			vertex buffer
/// @param x				x-coordinate of the point
/// @param y				y-coordinate of the point
/// @param z				z-coordinate of the point
/// @param nx				x-component of the normal
/// @param ny				y-component of the normal
/// @param nz				z-component of the normal
/// @param utex				u-coordinate of the texture
/// @param vtex				v-coordinate of the texture
/// @param color			color of the vertex
/// @param alpha			alpha of the vertex
function vertex_add_point(vbuffer, xx, yy, zz, nx, ny, nz, utex, vtex, color, alpha) {
	vertex_position_3d(vbuffer, xx, yy, zz);
	vertex_normal(vbuffer, nx, ny, nz);
	vertex_texcoord(vbuffer, utex, vtex);
	vertex_color(vbuffer, color, alpha);
}