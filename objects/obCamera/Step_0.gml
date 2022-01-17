/// @description Mouse look
direction -= (display_mouse_get_x() - display_get_width()/2) / 10;
pitch = clamp(pitch - (display_mouse_get_y() - display_get_height()/2) / 10, -80, 80);

display_mouse_set(display_get_width() / 2, display_get_height()/2);

if(keyboard_check(vk_escape)) {
    game_end();
}

var fb_speed = keyboard_check(ord("W")) - keyboard_check(ord("S")) * move_speed * _dt;
var zoom = (mouse_wheel_up() - mouse_wheel_down()) * move_speed * 100 * _dt;
x += dcos(direction) * (fb_speed + zoom);
y -= dsin(direction) * (fb_speed + zoom);
z += dsin(pitch) * (fb_speed + zoom);

var lr_speed = keyboard_check(ord("D")) - keyboard_check(ord("A")) * move_speed * _dt;
x += dsin(direction) * lr_speed;
y += dcos(direction) * lr_speed;

var ud_speed = (keyboard_check(vk_space) - keyboard_check(vk_shift)) * move_speed * _dt;
z += ud_speed;

//set light pos
if(keyboard_check(ord("Q"))) {
	light_pos_x = x;
	light_pos_y = y;
	light_pos_z = z;
	light_dir_x = dcos(direction);
	light_dir_y = -dsin(direction);
	light_dir_z = dsin(pitch);
}