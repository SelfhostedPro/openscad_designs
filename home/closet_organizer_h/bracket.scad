include <BOSL2/std.scad>

$fn = 100;
thickness = 4;

frame_size = [ 27.5, 12.8, 25 ];
washer_size = [ 25, 3.5, 25 ];
bracket_size = [ 25, 16.5 + 5, 30 ];

module square_washer() {
    diff() cuboid(washer_size, rounding = 1, except = [BACK]) attach(FRONT, TOP, inside = true, shiftout = 0.05) tag("remove") #cylinder(washer_size.y + 0.1, d = 8.6, anchor = CENTER);
}

module frame()
{
    diff() cuboid(frame_size);
}

module bracket()
{
    diff() cuboid(bracket_size)
    {
        attach(BACK, FRONT, inside = true, shiftout = 0.05) tag("remove") cuboid([ bracket_size.x + 0.1, bracket_size.y - thickness, bracket_size.z - thickness ]);
        attach(FRONT, TOP, inside = true, shiftout = 0.05) tag("remove") cylinder(bracket_size.y + 0.1, d = 8.5, anchor = CENTER);
    }
}

// translate([ 0, frame_size.y / 2 + washer_size.y / 2, 0 ])
// #square_washer();
//         translate([ 0, 0, 0 ])
bracket();