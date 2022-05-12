/// @description Setup 3D
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_counterclockwise);

pitch = 0;
direction = 0;
z = 32;

move_speed = 6;
mouse_lock = true;

view_mat = undefined;
proj_mat = undefined;

light_pos_x = 0;
light_pos_y = 0;
light_pos_z = 0;
light_dir_x = 0;
light_dir_y = 0;
light_dir_z = 0;

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vformat = vertex_format_end();

shadowmap_size = 4096;
shadowmap_surface = surface_create(shadowmap_size, shadowmap_size);

#region floor
vfloor = vertex_create_buffer();
vertex_begin(vfloor, vformat);

var s = 128;
for(var i = 0; i < room_width; i += s) {
	for(var j = 0; j < room_height; j += s) {
		var color;
		if((i % (s * 2) == 0 && j % (s * 2) == 0) || (i % (s * 2) > 0 && j % (s * 2) > 0)) {
			color = c_white;
		} else {
			color = c_aqua;
		}
			
		vertex_add_point(vfloor, i, j, 0,			0, 0, 1,	0, 0,	color, 1);
		vertex_add_point(vfloor, i + s, j, 0,		0, 0, 1,	1, 0,	color, 1);
		vertex_add_point(vfloor, i + s, j + s, 0,	0, 0, 1,	1, 1,	color, 1);
		
		vertex_add_point(vfloor, i, j, 0,			0, 0, 1,	0, 0,	color, 1);
		vertex_add_point(vfloor, i + s, j + s, 0,	0, 0, 1,	1, 1,	color, 1);
		vertex_add_point(vfloor, i, j + s, 0,		0, 0, 1,	0, 1,	color, 1);
	}
}

vertex_end(vfloor);
#endregion

vskybox = load_obj("skybox.obj");

#region merry
merry = instance_create_depth(500, 500, depth, ob3DModel);
merry.model = load_obj("merry.obj", "merry.mtl");
merry.z = 100;
#endregion

#region ball
ball = instance_create_depth(300, 300, depth, ob3DModel);
ball.model = load_obj("ball.obj");
ball.z = 30;
#endregion

#region maxip4d
maxi = instance_create_depth(800, 300, depth, ob3DModel);
maxi.model = load_obj("maxip4d.obj");
maxi.tex = sprite_get_texture(spMaxip4d, 0);
//maxi.cullmode = cull_noculling;
#endregion