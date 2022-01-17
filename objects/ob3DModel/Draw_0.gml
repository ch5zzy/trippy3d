/// @description Draw model
gpu_set_cullmode(cullmode);
matrix_set(matrix_world, matrix_build(x, y, z, xrot, yrot, zrot, xscale * scale, yscale * scale, zscale * scale));
vertex_submit(model, pr_trianglelist, tex);
matrix_set(matrix_world, matrix_build_identity());
gpu_set_cullmode(cull_counterclockwise);
