/// @description Draw status
surface_resize(application_surface, window_get_width(), window_get_height());

draw_text(0, 0, string(fps) + "/" + string(fps_real));
draw_text(0, 32, "Mouse lock " + (mouse_lock ? "enabled" : "disabled"));

merry_screen_pos = world_to_screen(merry.x, merry.y, merry.z, view_mat, proj_mat);
draw_text(merry_screen_pos[0], merry_screen_pos[1], "merry");

//draw_surface_stretched(shadowmap_surface, 0, 0, 400, 400);
