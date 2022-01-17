/// @description Draw FPS
draw_text(0, 0, string(fps) + "/" + string(fps_real));

merry_screen_pos = world_to_screen(merry.x, merry.y, merry.z, view_mat, proj_mat);
draw_text(merry_screen_pos[0], merry_screen_pos[1], "merry");