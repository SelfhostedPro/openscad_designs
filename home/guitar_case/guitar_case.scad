include <BOSL2/joiners.scad>
include <BOSL2/screws.scad>
include <BOSL2/std.scad>

length = 30;
width = 70;
height = 100;
wall_width = 3;

hex_sizes = [ 5, 3, 2.5, 2, 1.5, 1 ];
hex_bits = 2;
// Rotatation for the hexagons [degrees]
hex_angle = 90;

// Additional diameter for each hole [mm]
clearance = 0.4;

// Wall width [mm]
hex_wall_width = 3;

// Spacing between each hole [mm]
spacing = 2;

$fn = 100;

offsets = [for (i = 0, a = 0; i < len(hex_sizes); a = a + hex_sizes[i] + spacing, i = i + 1) a];
echo(offsets);

module shell(size = [ length, width, height ], side = "top")
{
    difference()
    {
        cuboid([ length, width, height ], rounding = 3);
        cuboid([ length - wall_width, width - wall_width, height - wall_width ], rounding = 0.25);
        if (side == "top")
            translate([ 0, 0, height / 2 - height / 8 ]) cuboid([ length + 0.1, width + 0.1, height / 4 ]);
    }
}

module hex_wrenches(offsets = offsets, sizes = hex_sizes, height = 10, wall_width = hex_wall_width, clearance = clearance)
{
    difference()
    {
        hull() for (i = [0:len(sizes) - 1])
        {
            echo(i);
            translate([ offsets[i] + sizes[i] / 2, sizes[i] / 2, 0 ])
                cyl(h = height, d = sizes[i] + wall_width + clearance, chamfer = 0.5, center = false);
            translate([ offsets[i] + sizes[i] / 2, sizes[i] / 2, -sizes[i] / 4 ]) rotate([ 180, 0, 180 ]) #wedge([ sizes[i], sizes[i] + wall_width + clearance, height ], center = true);
        }
        for (i = [0:len(sizes) - 1]) {
            echo(i);
            translate([ offsets[i] + sizes[i] / 2, sizes[i] / 2, -0.5 ])
// cylinder(h=11, d=sizes[i], center=true);
#linear_extrude(height = height * 3, center = true) rotate([ 0, 0, hex_angle ]) hexagon(id = sizes[i] + clearance);
        }
    }
}

shell();

translate([ 50, 0, 0 ]) hex_wrenches();