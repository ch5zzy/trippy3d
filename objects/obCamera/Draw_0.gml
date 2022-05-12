/// @description Initialize camera
draw_clear(c_black);
var camera = camera_get_active();

#region shadowmapping
shader_set(shd_depth);
surface_set_target(shadowmap_surface);
draw_clear(c_black);

light_view_mat = matrix_build_lookat(light_pos_x, light_pos_y, light_pos_z, light_pos_x + light_dir_x, light_pos_y + light_dir_y, light_pos_z + light_dir_z, 0, 0, 1);
light_proj_mat = matrix_build_projection_ortho(shadowmap_size / 4, -shadowmap_size / 4, 1, 32000);
camera_set_view_mat(camera, light_view_mat);
camera_set_proj_mat(camera, light_proj_mat);
camera_apply(camera);

//draw floor and models
vertex_submit(vfloor, pr_trianglelist, sprite_get_texture(spGrass, 0));
with (ob3DModel) event_perform(ev_draw, 0);

surface_reset_target();
#endregion

#region render 3D scene
var xfrom = x;
var yfrom = y;
var zfrom = z;
var xto = x + dcos(direction) * dcos(pitch);
var yto = y - dsin(direction) * dcos(pitch);
var zto = z + dsin(pitch);

shader_reset();
view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

//draw sky
gpu_set_zwriteenable(false);
matrix_set(matrix_world, matrix_build(xfrom, yfrom, zfrom, 0, 0, 0, 1, 1, 1));
vertex_submit(vskybox, pr_trianglelist, sprite_get_texture(spSkybox, 0));
matrix_set(matrix_world, matrix_build_identity());
gpu_set_zwriteenable(true);

shader_set(shd_basic_3d);

shader_set_uniform_f_array(shader_get_uniform(shd_basic_3d, "u_LightViewMat"), light_view_mat);
shader_set_uniform_f_array(shader_get_uniform(shd_basic_3d, "u_LightProjMat"), light_proj_mat);
texture_set_stage(shader_get_sampler_index(shd_basic_3d, "s_DepthTexture"), surface_get_texture(shadowmap_surface));
var light_pos = shader_get_uniform(shd_basic_3d, "lightPos");
var light_dir = shader_get_uniform(shd_basic_3d, "lightDir");
var light_color = shader_get_uniform(shd_basic_3d, "lightColor");
var light_ambient = shader_get_uniform(shd_basic_3d, "lightAmbient");
var light_range = shader_get_uniform(shd_basic_3d, "lightRange");
var light_angle = shader_get_uniform(shd_basic_3d, "lightCutoffAngle");
var light_inner_angle = shader_get_uniform(shd_basic_3d, "lightInnerRad");
shader_set_uniform_f(light_pos, light_pos_x, light_pos_y, light_pos_z);
shader_set_uniform_f(light_dir, light_dir_x, light_dir_y, light_dir_z);
shader_set_uniform_f(light_color, 1, 1, 1, 1);
shader_set_uniform_f(light_ambient, 0.25, 0.25, 0.25, 1);
shader_set_uniform_f(light_range, 800);
shader_set_uniform_f(light_angle, dcos(45));
shader_set_uniform_f(light_inner_angle, dcos(30));


//draw floor
vertex_submit(vfloor, pr_trianglelist, sprite_get_texture(spGrass, 0));

//draw models
with (ob3DModel) event_perform(ev_draw, 0);

shader_reset();
#endregion
