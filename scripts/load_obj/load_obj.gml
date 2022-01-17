/// @param obj_fname
/// @param mtl_fname
function load_obj(obj_fname, mtl_fname="") {
	var obj_file = file_text_open_read(obj_fname);
	
	var malpha = ds_map_create();
	var mcolor = ds_map_create();
	var mactive = "none";
	
	ds_map_set(malpha, mactive, 1);
	ds_map_set(mcolor, mactive, c_white);
	
	if(mtl_fname != "") {
		var mtl_file = file_text_open_read(mtl_fname);
		var mname = mactive;
		
		while(!file_text_eof(mtl_file)) {
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			
			var terms = string_split(line, " ");

			switch(terms[0]) {
				case "newmtl": //material name
					mname = terms[1];
					break;
				case "Kd": //color
					var r = real(terms[1]) * 255;
					var g = real(terms[2]) * 255;
					var b = real(terms[3]) * 255;
					var color = make_color_rgb(r, g, b);
					ds_map_set(mcolor, mname, color);
					break;
				case "d": //alpha
					var alpha = real(terms[1]);
					ds_map_set(malpha, mname, alpha);
					break;
				default:
					break;
			}
		}		
	}

	var model = vertex_create_buffer();
	vertex_begin(model, obCamera.vformat);

	var vx = ds_list_create();
	var vy = ds_list_create();
	var vz = ds_list_create();

	var vnx = ds_list_create();
	var vny = ds_list_create();
	var vnz = ds_list_create();

	var vutex = ds_list_create();
	var vvtex = ds_list_create();

	while(!file_text_eof(obj_file)) {
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		
		var terms = string_split(line, " ");
		
		switch(terms[0]) {
			case "v": //vertex
				ds_list_add(vx, real(terms[1]));
				ds_list_add(vy, real(terms[2]));
				ds_list_add(vz, real(terms[3]));
				break;
			case "vt": //texture
				ds_list_add(vutex, real(terms[1]));
				ds_list_add(vvtex, real(terms[2]));
				break;
			case "vn": //normal
				ds_list_add(vnx, real(terms[1]));
				ds_list_add(vny, real(terms[2]));
				ds_list_add(vnz, real(terms[3]));
				break;
			case "f": //face
				for(var j = 1; j <= 3; j++) {
					var data = string_split(terms[j], "/");
					
					var xx = ds_list_find_value(vx, real(data[0]) - 1);
					var yy = ds_list_find_value(vy, real(data[0]) - 1);
					var zz = ds_list_find_value(vz, real(data[0]) - 1);
					var utex = ds_list_find_value(vutex, real(data[1]) - 1);
					var vtex = ds_list_find_value(vvtex, real(data[1]) - 1);
					var nx = ds_list_find_value(vnx, real(data[2]) - 1);
					var ny = ds_list_find_value(vny, real(data[2]) - 1);
					var nz = ds_list_find_value(vnz, real(data[2]) - 1);
					
					vertex_add_point(model, xx, yy, zz, nx, ny, nz, utex, vtex, ds_map_find_value(mcolor, mactive), ds_map_find_value(malpha, mactive));
				}
				break;
			case "usemtl": //use material
				if(mtl_fname != "") {
					mactive = terms[1];
					break;
				}
			default:
				break;
		}
	}

	vertex_end(model);

	ds_list_destroy(vx);
	ds_list_destroy(vy);
	ds_list_destroy(vz);
	ds_list_destroy(vnx);
	ds_list_destroy(vny);
	ds_list_destroy(vnz);
	ds_list_destroy(vutex);
	ds_list_destroy(vvtex);

	file_text_close(obj_file);

	return model;
}
