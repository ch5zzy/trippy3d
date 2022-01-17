/// @description Mouse look and movement
if(mouse_lock) {
	window_set_cursor(cr_none);
	
	direction -= (window_mouse_get_x() - window_get_width()/2) / 10;
	pitch = clamp(pitch - (window_mouse_get_y() - window_get_height()/2) / 10, -80, 80);

	window_mouse_set(window_get_width() / 2, window_get_height()/2);
} else {
	window_set_cursor(cr_arrow);
}

if(keyboard_check(vk_escape)) {
    game_end();
}

if(keyboard_check_pressed(vk_control)) {
	mouse_lock = !mouse_lock;
}

//movement
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