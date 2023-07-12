pub const vertex_color_offset = 6;

pub const vertex_count = vertex_data.len / vertex_len;

pub const vertex_data_size = @sizeOf(@TypeOf(vertex_data));

pub const vertex_len = 9;

pub const vertex_norm_offset = 3;

pub const vertex_stride = vertex_len * @sizeOf(f32);

pub const vertex_data = [_]f32{
    // x,     y,   r,   g,   b
    -0.5,  -0.5, 1.0, 0.0, 0.0,
    0.5,   -0.5, 0.0, 1.0, 0.0,
    0.0,   0.5,  0.0, 0.0, 1.0,
    -0.55, -0.5, 1.0, 1.0, 0.0,
    -0.05, 0.5,  1.0, 0.0, 1.0,
    -0.55, 0.5,  0.0, 1.0, 1.0,
};

pub const index_data = [_]u16{
    // Base
    0,  1,  2,
    0,  2,  3,
    // Sides
    4,  5,  6,
    7,  8,  9,
    10, 11, 12,
    13, 14, 15,
};

pub const point_data = [_]f32{
    // x, y,    z,    nx,     ny,     nz,   r,   g,   b
    // Base
    -0.5, -0.5, -0.3, 0,      -1,     0,    1.0, 0.0, 0.0,
    0.5,  -0.5, -0.3, 0,      -1,     0,    0.0, 1.0, 0.0,
    0.5,  0.5,  -0.3, 0,      -1,     0,    0.0, 0.0, 1.0,
    -0.5, 0.5,  -0.3, 0,      -1,     0,    1.0, 1.0, 0.0,
    // Sides, with different normals per face.
    -0.5, -0.5, -0.3, 0,      -0.848, 0.53, 1.0, 0.0, 0.0,
    0.5,  -0.5, -0.3, 0,      -0.848, 0.53, 0.0, 1.0, 0.0,
    0.0,  0.0,  0.5,  0,      -0.848, 0.53, 0.8, 0.8, 0.8,
    //
    0.5,  -0.5, -0.3, 0.848,  0,      0.53, 0.0, 1.0, 0.0,
    0.5,  0.5,  -0.3, 0.848,  0,      0.53, 0.0, 0.0, 1.0,
    0.0,  0.0,  0.5,  0.848,  0,      0.53, 0.8, 0.8, 0.8,
    //
    0.5,  0.5,  -0.3, 0,      0.848,  0.53, 0.0, 0.0, 1.0,
    -0.5, 0.5,  -0.3, 0,      0.848,  0.53, 1.0, 1.0, 0.0,
    0.0,  0.0,  0.5,  0,      0.848,  0.53, 0.8, 0.8, 0.8,
    //
    -0.5, 0.5,  -0.3, -0.848, 0,      0.53, 1.0, 1.0, 0.0,
    -0.5, -0.5, -0.3, -0.848, 0,      0.53, 1.0, 0.0, 0.0,
    0.0,  0.0,  0.5,  -0.848, 0,      0.53, 0.8, 0.8, 0.8,
};
